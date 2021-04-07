import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'camera_page.dart';


class TakePicture extends StatefulWidget {

  @override
  TakePictureState createState() => TakePictureState();
}

class TakePictureState extends State<TakePicture> {
  List<CameraDescription> cameras;
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _getAvailableCameras();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _controller != null
          ? _initializeControllerFuture = _controller.initialize()
          : null; //on pause camera disposed so we need call again "issue is only for android"
    }
  }

  Future<void> _getAvailableCameras() async {
    try {
      cameras = await availableCameras();
      _controller = CameraController(cameras[1], ResolutionPreset.medium);
      _controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    } catch (e) {
      print("_getAvailableCameras $e");
    }
  }

  Future<void> onWillPop() async {
    print('will');
  }
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture')),
      body: Container(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(10),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(width: 2, color: Theme.of(context).primaryColor)),
                    child: FlatButton(
                      onPressed: () {}, 
                      child: Icon(
                        Icons.image_search_sharp,
                        color: Theme.of(context).primaryColor,
                        size: 50,
                      ),
                    )
                  ),
                  Text('Your photos')
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(20),
                    width: 100,
                    height: 100,
                    child: Stack(
                      children: <Widget>[
                        RotatedBox(
                          quarterTurns: MediaQuery.of(context).orientation == Orientation.landscape ? 3 : 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: OverflowBox(
                              alignment: Alignment.center,
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Container(
                                  width: size,
                                  height: size,
                                  child: CameraPreview(
                                    _controller
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        new Positioned.fill(
                          top: 55,
                          child: new Opacity(
                            opacity: 1,
                            child: FlatButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => CameraPage()));
                              }, 
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                              ),
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text('Camera')
                ],
              )
            ],
          )
        ),
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}