import 'dart:io';
import 'package:flutter_test_camera/pages/take_picture.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';


class CameraPage extends StatefulWidget {

  @override
  CameraPageState createState() => CameraPageState();
}

class CameraPageState extends State<CameraPage> {
  List<CameraDescription> cameras;
  CameraController _cameraController;
  Future<void> _initializeCameraControllerFuture;

  var vidPath;

  @override
  void initState() {
    super.initState();
    _getAvailableCameras();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> _getAvailableCameras() async {
    try {
      cameras = await availableCameras();
      _cameraController = CameraController(cameras[1], ResolutionPreset.medium);
      _initializeCameraControllerFuture = _cameraController.initialize();
      _initializeCameraControllerFuture.then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    } catch (e) {
      print("_getAvailableCameras $e");
    }
  }

   @override
    Widget build(BuildContext context) {
      return Stack(children: <Widget>[
          FutureBuilder(
            future: _initializeCameraControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_cameraController);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
      ]);
    }
}

// final size = MediaQuery.of(context).size;
    // final deviceRatio = size.width / size.height;
    // final xScale = _controller.value.aspectRatio / deviceRatio;
    // Modify the yScale if you are in Landscape
    // final yScale = 1.0;
    // return Container(
    //   child: AspectRatio(
    //     aspectRatio: deviceRatio,
    //     child: Transform(
    //       alignment: Alignment.center,
    //       transform: Matrix4.diagonal3Values(xScale, yScale, 1),
    //       child: CameraPreview(_controller),
    //     ),
        // child: Stack(
        //   children: <Widget>[
        //     CameraPreview(_controller),
        //     Align(
        //       alignment: Alignment.bottomCenter,
        //       child: Container(
        //         width: double.infinity,
        //         height: 120.0,
        //         padding: EdgeInsets.all(20.0),
        //         color: Color.fromRGBO(00, 00, 00, 0.7),
        //         child: Stack(
        //           children: <Widget>[
        //             Align(
        //               alignment: Alignment.center,
        //               child: Material(
        //                 color: Colors.transparent,
        //                 child: InkWell(
        //                   borderRadius: BorderRadius.all(Radius.circular(50.0)),
        //                   onTap: () {
        //                     // _captureImage();
        //                   },
        //                   child: Container(
        //                     padding: EdgeInsets.all(4.0),
        //                     child: Icon(
        //                       Icons.camera_front,
        //                       color: Colors.white,
        //                     )
        //                   ),
        //                 ),
        //               ),
        //             ),
        //             Align(
        //               alignment: Alignment.centerRight,
        //               child: Material(
        //                 color: Colors.transparent,
        //                 child: InkWell(
        //                   borderRadius: BorderRadius.all(Radius.circular(50.0)),
        //                   onTap: () {
        //                     // if (!_toggleCamera) {
        //                     //   onCameraSelected(widget.cameras[1]);
        //                     //   setState(() {
        //                     //     _toggleCamera = true;
        //                     //   });
        //                     // } else {
        //                     //   onCameraSelected(widget.cameras[0]);
        //                     //   setState(() {
        //                     //     _toggleCamera = false;
        //                     //   });
        //                     // }
        //                   },
        //                   child: Container(
        //                     padding: EdgeInsets.all(4.0),
        //                     child: Icon(Icons.camera_enhance),
        //                     // child: Image.asset(
        //                     //   'assets/images/ic_switch_camera_3.png',
        //                     //   color: Colors.grey[200],
        //                     //   width: 42.0,
        //                     //   height: 42.0,
        //                     // ),
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
    //   )
    // );