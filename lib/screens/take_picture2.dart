import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:edemsa_app/models/response.dart';
import 'package:edemsa_app/screens/display_picture2_screen.dart';

class TakePicture2Screen extends StatefulWidget {
  final CameraDescription camera;

  TakePicture2Screen({required this.camera});

  @override
  _TakePicture2ScreenState createState() => _TakePicture2ScreenState();
}

class _TakePicture2ScreenState extends State<TakePicture2Screen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.low,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tomar Foto'),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();
            Response? response =
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DisplayPicture2Screen(
                          image: image,
                        )));
            if (response != null) {
              Navigator.pop(context, response);
            }
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }
}
