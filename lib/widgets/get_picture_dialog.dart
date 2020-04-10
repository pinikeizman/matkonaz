import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:matkonaz/widgets/take_picture_widget.dart';

import '../main.dart';

class AddPictureDialog extends StatelessWidget {
  final Function(FileImage) onPicture;

  const AddPictureDialog({Key key, this.onPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cameras = MatkonazInheritedWidget.of(context).cameras;
    // TODO: implement build
    return AlertDialog(
      title: Text("Choose a method to add picture:"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  child: Icon(
                    MdiIcons.imagePlus,
                    size: 50.0,
                  ),
                  onPressed: () async {
                    File img =
                        await ImagePicker.pickImage(source: ImageSource.gallery);
                    this.onPicture(FileImage(img));
                  },
                ),
              ),
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TakePictureWidget(
                          camera: cameras[0],
                          onPicture: this.onPicture,
                        ),
                      ),
                    );
                  },
                  child: Icon(
                    MdiIcons.camera,
                    size: 50.0,
                  ),
                ),
              ),
            ],
          ),
          FlatButton(
            child: Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
