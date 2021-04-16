import 'dart:io';
import 'package:flutter/material.dart';


class DisplayPicture extends StatefulWidget {
  final String imagePath;
  DisplayPicture({Key key, this.imagePath}) : super(key: key);

  @override
  _DisplayPictureState createState() => _DisplayPictureState();
}

class _DisplayPictureState extends State<DisplayPicture> {

  static final String endpoint = '';
  Future<File> file;
  String status = '';
  String base64Image = '';
  String errorMessage = 'Error Uploading Image';

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white
        ),
        title: Text(
          'Display the Picture',
          style: TextStyle(
            color: Colors.white
          )
        )
      ),
      body: Container(
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
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20),
                child: Image.file(
                  File(widget.imagePath),
                  fit: BoxFit.contain,
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: MediaQuery.of(context).size.width / 1.5,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                width: 120.0,
                child: FlatButton(
                  textColor: Colors.white,
                  color: Colors.cyan,
                  onPressed: () {
                    print('Upload clicked');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: Icon(Icons.upload_file, color: Colors.white,),
                      ),
                      Text('Upload')
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      )
    );
  }
}