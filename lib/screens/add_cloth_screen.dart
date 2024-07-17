import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../services/firestore_service.dart';
import '../services/auth_service.dart';
import 'dart:io';

class AddClothScreen extends StatefulWidget {
  @override
  _AddClothScreenState createState() => _AddClothScreenState();
}

class _AddClothScreenState extends State<AddClothScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firestoreService = FirestoreService();
  final _authService = AuthService();
  String _category = 'Pants';
  String _name = '';
  File? _image;

  Future<void> getImage() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permission denied')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Cloth')),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _category,
              items: ['Pants', 'Shirts', 'Socks', 'Others']
                  .map((label) => DropdownMenuItem(
                        child: Text(label),
                        value: label,
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _category = value!;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
              onSaved: (value) => _name = value!,
            ),
            ElevatedButton(
              child: Text('Pick Image'),
              onPressed: getImage,
            ),
            if (_image != null) Image.file(_image!),
            ElevatedButton(
              child: Text('Add Cloth'),
              onPressed: () async {
                if (_formKey.currentState!.validate() && _image != null) {
                  _formKey.currentState!.save();
                  final user = _authService.getCurrentUser();
                  await _firestoreService.addCloth(user.uid, _category, _name, _image!);
                  Navigator.pop(context);
                                }
              },
            ),
            // ElevatedButton(  
            //   child: Text('Add Cloth'),  
            //   onPressed: () async {  
            //     if (_formKey.currentState!.validate() && _image != null) {  
            //       _formKey.currentState!.save();  
            //       final Stream<User?> user = await _authService.getCurrentUser();  
            //       if (user != null) {  
            //         await _firestoreService.addCloth(user.uid, _category, _name, _image!);  
            //         Navigator.pop(context);  
            //       } else {  
            //         // Handle the case where user is null  
            //         print('User is null');  
            //       }  
            //     }  
            //   },  
            // ),
          ],
        ),
      ),
    );
  }
}