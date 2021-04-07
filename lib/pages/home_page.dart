import 'package:flutter/material.dart';

import 'take_picture.dart';


class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}


class HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Camera app')),
      body: Center(
        child: FlatButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TakePicture())),
          child: Icon(
              Icons.photo_camera,
              color: Theme.of(context).primaryColor,
              size: 100,
          ),
        )
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 115,
              child: DrawerHeader(
                child: Text('Menu'),
                decoration: BoxDecoration(color: Theme.of(context).primaryColor)
              ),
            ),
            ListTile(
              title: Text('Sign In'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Sign Up'),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}