import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yanapay_app/src/core/bloc/auth_bloc.dart';
import 'package:yanapay_app/src/core/models/user.dart';
import 'package:yanapay_app/src/ui/pages/global_bloc.dart';
import 'package:yanapay_app/src/ui/pages/home_page.dart';
import 'package:yanapay_app/src/ui/utils/show_loading.dart';
import 'package:yanapay_app/src/ui/widgets/yanapay_button.dart';
import 'package:yanapay_app/src/ui/widgets/yanapay_input.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthPage extends StatefulWidget {
  
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  @override
  void initState() { 
    super.initState();
  }

  final AuthBloc authBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        initialData: AuthOption.LOGIN,
        stream: authBloc.optionStream,
        builder: (context, snapshot) {
          final selectedOption = snapshot.data;
          return selectedOption == AuthOption.LOGIN
            ? LoginPage(mBloc: authBloc)
            : RegisterPage(mBloc: authBloc);
        }
      ),
    );
  }
}

class LoginPage extends StatefulWidget {

  AuthBloc mBloc;

  LoginPage({@required this.mBloc});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool splashLoadFinished = false;
  bool showWidgets = false;

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() { 
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 2500), () {
        setState(() {
          splashLoadFinished = true;
        });
      });

      Future.delayed(const Duration(milliseconds: 5000), () {
        setState(() {
          showWidgets = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 36
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 36
          ),
          child: AnimatedAlign(
            curve: Curves.bounceOut,
            alignment: splashLoadFinished ? Alignment.topCenter : Alignment.center,
            duration: const Duration(milliseconds: 2500),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 70
                  ),
                  height: 150,
                  width: 150,
                  child: Image.asset("assets/images/yanapay-logo.png"),
                ),
                splashLoadFinished
                  ? AnimatedOpacity(
                      duration: const Duration(seconds: 1),
                      opacity: showWidgets ? 1.0 : 0.0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                            SizedBox(
                              height: 36,
                            ),
                            YanapayInput(
                              mController: _usernameController,
                              mHint: "Usuario",
                              mOnChanged: (value) {},
                            ),
                            SizedBox(height: 24),
                            YanapayInput.password(
                              mController: _passwordController,
                              mHint: "Contraseña",
                              mOnChanged: (value) {},
                            ),   
                            const SizedBox(height: 32),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: YanapayButton(
                                mText: "Ingresar",
                                mOnPressed: () async {
                                  showLoading(context);
                                  final querySnapshot = await FirebaseFirestore.instance.collection('user').where('username', isEqualTo: _usernameController.text ?? "").get();
                                  
                                  final docs = querySnapshot.docs;
                                  final data = docs.first.data();

                                  if (data["password"] == (_passwordController.text ?? "")) {
                                    User loggedUser = User.fromSnapshot(docs.first);
                                    globalBloc.changeUser(loggedUser);

                                    Navigator.pop(context);

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => HomePage()
                                      )
                                    );
                                  } else {
                                    Navigator.pop(context);
                                  }
                                  // Future.delayed(const Duration(milliseconds: 2000), () {
                                  //   Navigator.pop(context);
                                  //   
                                  // });
                                },
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              width: double.infinity,
                              child: SignInButton(
                                Buttons.Google,
                                text: "Sign in with Google",
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)
                                ),
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(height: 24),
                            FlatButton(
                              onPressed: _changeAuthPage,
                              child: Text(
                                "¿No tienes una cuenta?\nRegistrar",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.solid
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                        ],
                      ),
                    )
                  : Container()
              ],
            )
          ),
        ),
      ),
    );
  }

  void _changeAuthPage() {
    widget.mBloc.changeOption(AuthOption.REGISTER);
  }
}

class RegisterPage extends StatefulWidget {

  AuthBloc mBloc;

  RegisterPage({@required this.mBloc});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  File mFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Text(
            "Crear nuevo usuario",
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 24
          ),
          child: Column(
            children: [
              _RegisterFilePicker(
                mOnFilePicked: (newFile) {
                  mFile = newFile;
                },
              ),
              const SizedBox(height: 32),
              YanapayInput(
                mHint: "Usuario",
                mController: _usernameController,
                mOnChanged: (value){ },
              ),
              const SizedBox(height: 24),
              YanapayInput(
                mHint: "Email",
                mController: _emailController,
                mOnChanged: (value){ },
              ),
              const SizedBox(height: 24),
              YanapayInput.password(
                mHint: "Contraseña",
                mController: _passwordController,
                mOnChanged: (value){ },
              ),
              const SizedBox(height: 24),
              YanapayInput.password(
                mHint: "Repetir Contraseña",
                mController: _confirmPasswordController,
                mOnChanged: (value){ },
              ),
              const SizedBox(height: 24),
              Container(
                width: MediaQuery.of(context).size.width,
                child: YanapayButton(
                  mText: "Crear Nuevo Usuario",
                  mOnPressed: () async {
                    try {
                      showLoading(context);
                      final result = await _registerUser(context);
                      if (result) {
                        Navigator.pop(context);
                        widget.mBloc.changeOption(AuthOption.LOGIN);
                        Flushbar(
                          message: "Usuario creado correctamente",
                          backgroundColor: Colors.deepPurple,
                          duration: const Duration(seconds: 3)
                        ).show(context);
                      } else {
                        Navigator.pop(context);
                      }
                      
                    } catch (error) {
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ]
          ),
        )
      ),
    );
  }

  Future<bool> _registerUser(context) async {
    String username = _usernameController.text ?? "";
    String email = _emailController.text ?? "";
    String password = _passwordController.text ?? "";
    String confirmPassword = _confirmPasswordController.text ?? "";

    if (username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showNotCompleteFields(context);
    } else {
      final documentReference = await widget.mBloc.createUser(
        username: username,
        email: email,
        password: password
      );

      if (documentReference != null) {
        await uploadUserImage(mFile, documentReference);
        return true;
      }
      return false;
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
    Reference storageReference = FirebaseStorage.instance.ref().child('user/${_image.path.split('/').last}');
    UploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.whenComplete(() async {
      print('File Uploaded');
      await storageReference.getDownloadURL().then((fileURL) {returnURL =  fileURL;});
    });
    return returnURL;
  }

  _showNotCompleteFields(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text("Debe completar todos los campos"),
          actions: [FlatButton(onPressed: () => Navigator.pop(context), child: Text("Aceptar"),)]
        );
      }
    );
  }
}

class _RegisterFilePicker extends StatefulWidget {
  
  Function(File) mOnFilePicked;
  
  _RegisterFilePicker({@required this.mOnFilePicked});

  @override
  __RegisterFilePickerState createState() => __RegisterFilePickerState();
}

class __RegisterFilePickerState extends State<_RegisterFilePicker> {
  
  File mFile;
  ImagePicker picker = ImagePicker();


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          await _pickImage();
          widget.mOnFilePicked(mFile);
        } catch (error) {
          print("Error: $error");
        }
      },
      child: Stack(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              image: mFile != null 
                ? DecorationImage(
                    image: FileImage(mFile),
                    fit: BoxFit.cover
                  )
                : null,
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.deepPurple, width: 0.5),
              boxShadow: [
                BoxShadow(
                  offset: Offset(3, 3),
                  color: Colors.black26,
                  spreadRadius: 3,
                  blurRadius: 3
                )
              ]
            ),

            child: mFile != null
              ? Container()
              : Center(child: Text("Sin imagen"))
          ),

          Positioned(
            bottom: 10,
            right: 0,
            child: Icon(
              Icons.camera_alt, 
              color: Colors.deepPurple,
              size: 24,
            ),
          )
        ],
      ),
    );
  }

  Future _pickImage() async {
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