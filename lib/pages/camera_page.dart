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