import 'package:flutter/material.dart';

import 'take_picture.dart';
import 'register_page.dart';


class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}


class HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Camera app', 
          style: TextStyle(
            color: Colors.white
        )),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                  child: Icon(Icons.app_registration, color: Colors.white,),
                ),
                Text('Sign Up')
              ],
            ),
          ),
        ],
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue,
                Colors.black26,
              ],
            )
          ),
          child: Center(
            // child: Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     Container(
            //       decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(250),
            //               border: Border.all(width: 2, color: Theme.of(context).primaryColor)),
            //       child: FlatButton(
            //         onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TakePicture())),
            //         child: Icon(
            //             Icons.photo_camera,
            //             color: Theme.of(context).primaryColor,
            //             size: 100,
            //         ),
            //       ),
            //     ),
            //     Text(
            //       'Take a photo',
            //       style: TextStyle(
            //         fontSize: 25
            //       )
            //     )
            //   ],
            // )
            child: Container(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 2, color: Theme.of(context).primaryColor)),
              child: FlatButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TakePicture())),
                child: Icon(
                    Icons.photo_camera,
                    color: Theme.of(context).primaryColor,
                    size: 100,
                ),
                shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
              ),
            ),
          ),
        ),
      )
    );
  }
}