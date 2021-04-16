import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;


class FaceCheck extends StatefulWidget {
  @override
  _FaceCheckState createState() => _FaceCheckState();
}


class _FaceCheckState extends State<FaceCheck> {
  File _imageFile;
  List<Face> _faces;
  List<Map<String, int>> faceMaps = [];
  bool isLoading = false;
  ui.Image _image;
  img.Image faceCrop;
  final picker = ImagePicker();

  _getImage() async {
    final imageFile = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 100,
      maxHeight: 400,
      maxWidth: 400
    );

    setState(() {
      isLoading = true;
    });

    final image = FirebaseVisionImage.fromFile(File(imageFile.path));
    final faceDetector = FirebaseVision.instance.faceDetector();
    List<Face> faces = await faceDetector.processImage(image);

    if (mounted) {
      setState(() {
        _imageFile = File(imageFile.path);
        _faces = faces;
        _loadImage(File(imageFile.path));
      });
    }

    List<Map<String, int>> faceMaps = [];
    for (Face face in faces) {
      int x = face.boundingBox.left.toInt();
      int y = face.boundingBox.top.toInt();
      int w = face.boundingBox.width.toInt();
      int h = face.boundingBox.height.toInt();
      Map<String, int> thisMap = {'x': x, 'y': y, 'w': w, 'h':h};
      faceMaps.add(thisMap);
    }
  }

  _loadImage(File file) async {
    final data = await file.readAsBytes();
    await decodeImageFromList(data).then((value) => setState(() {
      _image = value;
      isLoading = false;
    }));
  }

  _cropImage() {
    setState(() {
      img.Image originalImage = img.decodeImage(File(_imageFile.path).readAsBytesSync());
      faceCrop = img.copyCrop(originalImage, 30, 30, 30, 30);
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
          'Face Detection',
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
        alignment: Alignment.center,
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height / 1.5,
                child: isLoading
                      ? Center(child: CircularProgressIndicator())
                      : (_imageFile == null)
                      ? Center(child: Text('No image selected'))
                      : (faceCrop == null) 
                      ? Center(
                        child: FittedBox(
                          child: SizedBox(
                            width: _image.width.toDouble(),
                            height: _image.height.toDouble(),
                            child: CustomPaint(
                              painter: FacePainter(_image, _faces),
                            ),
                          ),
                        ) 
                      )
                      : Container(
                        child: FittedBox(
                          child: SizedBox(
                            width: _image.width.toDouble(),
                            height: _image.height.toDouble(),
                            child: CustomPaint(
                              // painter: CroppedImage(Image.file(faceCrop))
                            ),
                          ),
                        )
                      ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                constraints: BoxConstraints(minWidth: 50, maxWidth: 200),
                child: FlatButton(
                  textColor: Colors.white,
                  color: Colors.cyan,
                  onPressed: _cropImage,
                  child: Text('Crop image'),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add_a_photo, color: Colors.white),
      ),
    );
  }
}

class FacePainter extends CustomPainter {
  final ui.Image image;
  final List<Face> faces;
  final List<Rect> rects = [];

  FacePainter(this.image, this.faces) {
    for (var i = 0; i < faces.length; i++) {
      rects.add(faces[i].boundingBox);
    }
  }

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    final Paint paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0
    ..color = Colors.yellow;

    canvas.drawImage(image, Offset.zero, Paint());
    for (var i = 0; i < faces.length; i++) {
      canvas.drawRect(rects[i], paint);
    }
  }

  @override
  bool shouldRepaint(FacePainter old) {
    return image != old.image || faces != old.faces;
  }
}

class CroppedImage extends CustomPainter {
  final ui.Image image;

  CroppedImage(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint(),
    );
  }

  @override
  bool shouldRepaint(CroppedImage oldDelegate) {
    return image != oldDelegate.image;
  }

}