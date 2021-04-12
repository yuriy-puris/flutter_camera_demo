import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_test_camera/pages/home_page.dart';
import 'package:flutter_test_camera/pages/take_picture.dart';
import 'package:flutter_test_camera/pages/register_page.dart';
import 'package:flutter_test_camera/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Camera',
      routes: {
        '/home': (BuildContext context) => HomePage(),
        '/camera': (BuildContext context) => TakePicture(),
        '/register': (BuildContext context) => RegisterPage(),
        '/login': (BuildContext context) => LoginPage()
      },
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.cyan[400],
        accentColor: Colors.deepOrange[200],
        textTheme: TextTheme(
          headline:
                    TextStyle(fontSize: 52.0, fontWeight: FontWeight.bold),
                title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
                body1: TextStyle(fontSize: 18.0))),
        home: HomePage(),
    );
  }
}