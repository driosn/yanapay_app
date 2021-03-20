import 'package:flutter/material.dart';
import 'package:yanapay_app/src/ui/pages/auth_page.dart';
import 'package:yanapay_app/src/ui/pages/home_page.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        accentColor: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.white
      ),
      home: AuthPage()
    );
  }
}