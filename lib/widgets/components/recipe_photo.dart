import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RecipePicture extends StatelessWidget {
  final ImageProvider provider;
  final int size;

  const RecipePicture({Key key, this.provider, this.size = 60})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return provider == null
        ? Icon(
      MdiIcons.imagePlus,
      size: 150.0,
    )
        : Container(
      width: 150.0,
      height: 150.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: provider,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
    );
  }
}
