import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:yanapay_app/src/core/bloc/home_bloc.dart';
import 'package:yanapay_app/src/core/models/YanapayPost.dart';
import 'package:yanapay_app/src/ui/pages/global_bloc.dart';
import 'package:yanapay_app/src/ui/utils/show_loading.dart';
import 'package:yanapay_app/src/ui/widgets/file_post.dart';
import 'package:yanapay_app/src/ui/widgets/post.dart';
import 'package:yanapay_app/src/ui/widgets/yanapay_input.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostPage extends StatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  
  bool emergencyActivated = false;
  File mFile;
  final picker = ImagePicker();

  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check, color: Colors.white),
        onPressed: () async {
          try {
            showLoading(context);
            await _createPost(context);
            Navigator.pop(context);
            Navigator.pop(context);
            Flushbar(
              message: "Publicacion creada correctamente",
              backgroundColor: Colors.deepPurple,
            );
          } catch (error) {
            Navigator.pop(context);
            print(error);
          }
        },
      ),
      appBar: AppBar(
        title: Text(
          "Crear Post",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Container(
            height: 75,
            width: 75,
            child: Image.asset("assets/images/yanapay-logo.png"),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 18,
          left: 24,
          right: 24
        ),
        child: Column(
          children: [
            YanapayInput(
              mOnChanged: (value) {},
              mController: _descriptionController,
              mHint: "Descripcion",
            ),
            const SizedBox(height: 24),
            mFile != null ?
              Container(
                width: double.infinity,
                child: Image.file(mFile),
              ): Container(),
              const SizedBox(height: 24),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
              ),
              color: Colors.deepPurple,

              onPressed: () async {
                await getImage();
              },
              child: Text("Seleccionar imagen", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            )
          ],
        )
      )
    );
  }

  Future<bool> _createPost(context) async {
    String description = _descriptionController.text ?? "";
    String email = globalBloc.user.email;
    String username = globalBloc.user.username;
    String userImage = globalBloc.user.image;

    final documentReference = await FirebaseFirestore.instance.collection('post').add({
      "description": description,
      "email": email,
      "username": username,
      "userImage": userImage,
    });

    if (documentReference != null) {
      if (mFile != null) {
        await uploadUserImage(mFile, documentReference);
      }
      return true;
    }
    return false;
  }

  Future<void> uploadUserImage(File mFile, DocumentReference ref) async {
    try {
      String imageUrl = await uploadFile(mFile);
      ref.update({"image": imageUrl});
    } catch (error) {
      print(error);
    }
  }

  Future<String> uploadFile(File _image) async {
    String returnURL;
    Reference storageReference = FirebaseStorage.instance.ref().child('post/${_image.path.split('/').last}');
    UploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.whenComplete(() async {
      print('File Uploaded');
      await storageReference.getDownloadURL().then((fileURL) {returnURL =  fileURL;});
    });
    return returnURL;
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        mFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
}