import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:tflite/tflite.dart';

class DisplayPicture extends StatefulWidget {
  final dynamic image;
  DisplayPicture({Key key, this.image}) : super(key: key);

  @override
  _DisplayPictureState createState() => _DisplayPictureState();
}

class _DisplayPictureState extends State<DisplayPicture> {
  static final String endpoint = '';
  Future<File> file;
  String status = '';
  String base64Image = '';
  String errorMessage = 'Error Uploading Image';

  List _result;
  String _confidence = '';
  String _name = '';
  String numbers = '';

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  loadModel() async {
    var resultLoad = await Tflite.loadModel(
        labels: 'assets/labels.txt', model: 'assets/model_unquant.tflite');
    print('result: $resultLoad');
    applyModelOnImage(widget.image);
  }

  applyModelOnImage(String image) async {
    var resultRun = await Tflite.runModelOnImage(
        path: image,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);

    setState(() {
      _result = resultRun;
      String str = _result[0]['label'];
      _name = str.substring(2);
      _confidence = _result != null
          ? (_result[0]['confidence'] * 100.0).toString().substring(0, 2) + '%'
          : '';
      print('$_name, $_confidence');
    });
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: BackButton(color: Colors.white),
            title: Text('Display the Picture',
                style: TextStyle(color: Colors.white))),
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue,
                Colors.black26,
              ],
            )),
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(20),
                    child: (widget.image is String)
                        ? Image.file(
                            File(widget.image),
                            fit: BoxFit.contain,
                            height: MediaQuery.of(context).size.height / 1.5,
                            width: MediaQuery.of(context).size.width / 1.5,
                          )
                        : Image.memory(
                            img.encodeJpg(widget.image),
                            height: MediaQuery.of(context).size.height / 1.5,
                            width: MediaQuery.of(context).size.width / 1.5,
                          ),
                    // Container(
                    //   child: FittedBox(
                    //       child: SizedBox(
                    //     width: _image.width.toDouble(),
                    //     height: _image.height.toDouble(),
                    //     child:
                    //         Image.memory(img.encodeJpg(faceCrop)),
                    //   )),
                    // )
                  ),
                  Text('$_name \nConfidence: $_confidence'),
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
                            child: Icon(
                              Icons.upload_file,
                              color: Colors.white,
                            ),
                          ),
                          Text('Upload')
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}
