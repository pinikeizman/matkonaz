import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'cmn_scaffold_widget.dart';

class TakePictureWidget extends StatefulWidget {
  final CameraDescription camera;
  final Function onPicture;

  const TakePictureWidget({Key key, this.camera, this.onPicture})
      : super(key: key);

  @override
  State<TakePictureWidget> createState() {
    // TODO: implement createState
    return TakePictureState();
  }
}

class TakePictureState extends State<TakePictureWidget> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.ultraHigh,
    );
    try {
      _initializeControllerFuture = _controller.initialize();
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CmnScaffold(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the Future is complete, display the preview.
              var _widget = _controller != null
                  ? Column(children: <Widget>[
                      Expanded(child: CameraPreview(_controller)),
                      FlatButton(
                        child: Row(
                          children: <Widget>[
                            Expanded(child: Icon(MdiIcons.camera)),
                          ],
                        ),
                        onPressed: () async {
                          try {
                            final String tmpPath = join(
                                (await getTemporaryDirectory()).path,
                                "${DateTime.now().millisecondsSinceEpoch}.png");
                            await _controller.takePicture(tmpPath);
                            Navigator.of(context).pop();
                            widget.onPicture(FileImage(
                              File(tmpPath),
                            ));
                          } catch (e) {
                            print(e);
                          }
                        },
                      )
                    ])
                  : Text("no camera found");
              return Expanded(
                child: _widget,
              );
            } else {
              // Otherwise, display a loading indicator.
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ],
    ));
  }
}
