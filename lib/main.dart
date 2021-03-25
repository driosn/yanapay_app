import 'package:flutter/material.dart';
import 'package:yanapay_app/src/ui/pages/auth_page.dart';
import 'package:yanapay_app/src/ui/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
 
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
      // home: HomePage()
    );
  }
}