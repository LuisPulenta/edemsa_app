import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:edemsa_app/models/response.dart';

class DisplayPictureAScreen extends StatefulWidget {
  final XFile image;

  DisplayPictureAScreen({required this.image});

  @override
  _DisplayPictureAScreenState createState() => _DisplayPictureAScreenState();
}

class _DisplayPictureAScreenState extends State<DisplayPictureAScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vista previa de la foto'),
      ),
      body: Column(
        children: [
          Image.file(
            File(widget.image.path),
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      child: Text('Usar Foto'),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF120E43),
                        minimumSize: Size(100, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        Response response =
                            Response(isSuccess: true, result: widget.image);
                        Navigator.pop(context, response);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      child: Text('Volver a tomar'),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFE03B8B),
                        minimumSize: Size(100, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
