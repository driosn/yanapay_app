import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:yanapay_app/src/core/bloc/auth_bloc.dart';
import 'package:yanapay_app/src/ui/pages/home_page.dart';
import 'package:yanapay_app/src/ui/widgets/yanapay_button.dart';
import 'package:yanapay_app/src/ui/widgets/yanapay_input.dart';

class AuthPage extends StatelessWidget {
  
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
            : RegisterPage();
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

  @override
  void initState() { 
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 2500), () {
        setState(() {
          splashLoadFinished = true;
        });
      });

      Future.delayed(const Duration(milliseconds: 4000), () {
        setState(() {
          showWidgets = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 36
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 36
        ),
        child: AnimatedAlign(
          curve: Curves.bounceOut,
          alignment: splashLoadFinished ? Alignment.topCenter : Alignment.center,
          duration: const Duration(milliseconds: 1500),
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
                            mHint: "Usuario",
                            mOnChanged: (value) {},
                          ),
                          SizedBox(height: 24),
                          YanapayInput.password(
                            mHint: "Contraseña",
                            mOnChanged: (value) {},
                          ),   
                          const SizedBox(height: 32),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: YanapayButton(
                              mText: "Ingresar",
                              mOnPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      elevation: 0,
                                      backgroundColor: Colors.transparent,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                );
                                Future.delayed(const Duration(milliseconds: 2000), () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => HomePage()
                                    )
                                  );
                                });
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
    );
  }

  void _changeAuthPage() {
    widget.mBloc.changeOption(AuthOption.REGISTER);
  }
}

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Register Page")
      ),
    );
  }
}