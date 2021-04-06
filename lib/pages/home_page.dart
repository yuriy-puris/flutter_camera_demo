import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}


class HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a photo')),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            FlatButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/camera'), 
              child: Text('Go to camera'))
          ],
        )
      ),
    );
  }
}