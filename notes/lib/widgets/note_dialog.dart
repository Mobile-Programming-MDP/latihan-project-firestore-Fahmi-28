// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes/models/note.dart';
import 'package:notes/services/location_service.dart';
import 'package:notes/services/note_service.dart';
import 'package:share_plus/share_plus.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';

class NoteDialog extends StatefulWidget {
  final Note? note;

  const NoteDialog({Key? key, this.note}) : super(key: key);

  @override
  _NoteDialogState createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  XFile? _imageFile;
  Position? _position;
  Uint8List? _imageBytes;
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _descriptionController.text = widget.note!.description;
    }
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _cameraController.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageFile = pickedFile;
        _imageBytes = bytes;
      });
    }
  }

  Future<void> _getLocation() async {
    final location = await LocationService().getCurrentLocation();
    setState(() {
      _position = location;
    });
  }

  void _shareNote() {
    final String text =
        '${_titleController.text}\n${_descriptionController.text}';
    if (_imageFile != null) {
      Share.shareXFiles([_imageFile!], text: text);
    } else if (widget.note?.imageUrl != null &&
        Uri.parse(widget.note!.imageUrl!).isAbsolute) {
      Share.share('$text\nImage: ${widget.note!.imageUrl}');
    } else {
      Share.share(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.note == null ? 'Add Notes' : 'Update Notes'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Title: ',
              textAlign: TextAlign.start,
            ),
            TextField(
              controller: _titleController,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Description: ',
              ),
            ),
            TextField(
              controller: _descriptionController,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text('Image: '),
            ),
            if (_imageBytes != null)
              SizedBox(
                height: 200, // Set a fixed height for the image container
                child: Image.memory(
                  _imageBytes!,
                  fit: BoxFit.cover,
                ),
              )
            else if (widget.note?.imageUrl != null &&
                Uri.parse(widget.note!.imageUrl!).isAbsolute)
              SizedBox(
                height: 200, // Set a fixed height for the image container
                child: Image.network(
                  widget.note!.imageUrl!,
                  fit: BoxFit.cover,
                ),
              )
            else
              Container(),
            Row(
              children: [
                TextButton(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  child: const Text("Pick Image from Gallery"),
                ),
                TextButton(
                  onPressed: () async {
                    final XFile? image = await _cameraController.takePicture();
                    if (image != null) {
                      final directory =
                          await getApplicationDocumentsDirectory();
                      final path = '${directory.path}/${DateTime.now()}.png';
                      await image.saveTo(path);
                      setState(() {
                        _imageFile = XFile(path);
                      });
                    }
                  },
                  child: const Text("Capture Image with Camera"),
                ),
              ],
            ),
            TextButton(
              onPressed: _getLocation,
              child: const Text("Get Location"),
            ),
            Text(
              _position?.latitude != null && _position?.longitude != null
                  ? 'Current Position : ${_position!.latitude.toString()}, ${_position!.longitude.toString()}'
                  : 'Current Position : ${widget.note?.lat}, ${widget.note?.lng}',
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ),
        TextButton(
          onPressed: _shareNote,
          child: const Text('Share'),
        ),
        ElevatedButton(
          onPressed: () async {
            String? imageUrl;
            if (_imageFile != null) {
              imageUrl = await NoteService.uploadImage(_imageFile!);
            } else {
              imageUrl = widget.note?.imageUrl;
            }

            Note note = Note(
              id: widget.note?.id,
              title: _titleController.text,
              description: _descriptionController.text,
              imageUrl: imageUrl,
              lat: _position != null
                  ? _position!.latitude.toString()
                  : widget.note?.lat.toString(),
              lng: _position != null
                  ? _position!.longitude.toString()
                  : widget.note?.lng.toString(),
              createdAt: widget.note?.createdAt,
            );

            if (widget.note == null) {
              await NoteService.addNote(note);
            } else {
              await NoteService.updateNote(note);
            }
            Navigator.of(context).pop();
          },
          child: Text(widget.note == null ? 'Add' : 'Update'),
        ),
      ],
    );
  }
}
