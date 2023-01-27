import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File _image = File(''); // initialize with an empty file

  Future<void> requestPermission() async {
    final status = await Permission.storage.status;
    if (status == PermissionStatus.granted) {
      final result = await Permission.storage.request();
      if (result.isGranted) {
        // Permission granted
      } else {
        // Permission denied
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Assignment 5'),
        ),
        body: Center(
          child: GestureDetector(
            onTap: () async {
              await requestPermission();
              final image = await ImagePicker().pickImage(
                  source: ImageSource.gallery);
              setState(() {
                _image = (image?.path != null ? File(image!.path) : _image);
              });
            },
            child: _image.path.isEmpty
                ? const Text('No image selected.')
                : Image.file(_image),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await requestPermission();
            final image = await ImagePicker().pickImage(
                source: ImageSource.gallery);
            setState(() {
              _image = (image?.path != null ? File(image!.path) : _image);
            });
          },
          child: Icon(Icons.file_upload),
        ),
      ),
    );
  }
}
