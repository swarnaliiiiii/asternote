import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  File? image;

  Future<void> _captureFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      image = File(pickedFile!.path);
    });
  }

  Future<void> _pickImagefromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickedImage!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan book cover'),
      ),
      body: Center(
        child: image == null ? Text('No Image Selected') : Image.file(image!),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: _pickImagefromGallery,
            tooltip: 'Pick Image',
            child: Icon(Icons.photo),
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            onPressed: _captureFromCamera,
            tooltip: 'Capture Image',
            child: Icon(Icons.camera),
          ),
        ],
      ),
    );
  }
}

Future<void> uploadImage(File image) async {
  var url = Uri.parse('htttp://localhost:5000/upload');
  var request = http.MultipartRequest('POST', url);
  request.files.add(await http.MultipartFile.fromPath('image', image.path));
  var response = await request.send();
  if (response.statusCode == 200) {
    print('Image uploaded');
  } else {
    print('Image not uploaded');
  }
}
