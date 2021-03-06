import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'picture_page.dart';

class TakePicture extends StatefulWidget {
  @override
  TakePictureState createState() => TakePictureState();
}

class TakePictureState extends State<TakePicture> {
  List<CameraDescription> cameras;
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  File imageFile;
  String imagePath;
  PickedFile pickedFile;

  @override
  void initState() {
    super.initState();
    pickedFile = null;
    // _getAvailableCameras();
  }

  // @override
  // void dispose() {
  //   _controller?.dispose();
  //   super.dispose();
  // }

  // Future<void> _getAvailableCameras() async {
  //   try {
  //     cameras = await availableCameras();
  //     _controller = CameraController(cameras[1], ResolutionPreset.medium);
  //     _controller?.initialize().then((_) {
  //       if (!mounted) {
  //         return;
  //       }
  //       setState(() {});
  //     });
  //   } catch (e) {
  //     print("_getAvailableCameras $e");
  //   }
  // }

  _getFromGallery(context) async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
        imageFile = File(pickedFile.path);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DisplayPicture(image: imagePath)));
      });
    }
  }

  _getFromCamera(context) async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
        imageFile = File(pickedFile.path);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DisplayPicture(image: imagePath)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        title: Text('Take a picture', style: TextStyle(color: Colors.white)),
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
        )),
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
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                            width: 2, color: Theme.of(context).primaryColor)),
                    child: FlatButton(
                      onPressed: () {
                        _getFromGallery(context);
                      },
                      child: Icon(
                        Icons.image_search_sharp,
                        color: Theme.of(context).primaryColor,
                        size: 50,
                      ),
                      shape: CircleBorder(
                          side: BorderSide(color: Colors.transparent)),
                    )),
                Text('Your photos')
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(10),
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                            width: 2, color: Theme.of(context).primaryColor)),
                    child: FlatButton(
                      onPressed: () {
                        _getFromCamera(context);
                      },
                      child: Icon(
                        Icons.photo_camera,
                        color: Theme.of(context).primaryColor,
                        size: 50,
                      ),
                      shape: CircleBorder(
                          side: BorderSide(color: Colors.transparent)),
                    )),
                Text('Camera')
              ],
            )
          ],
        )),
      ),
    );
  }
}
