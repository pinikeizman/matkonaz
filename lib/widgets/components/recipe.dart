import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matkonaz/main.dart';
import 'package:matkonaz/types/recipe.dart';
import 'package:matkonaz/utils.dart';
import 'package:matkonaz/widgets/cmn_scaffold_widget.dart';
import 'package:matkonaz/widgets/components/ingredients_list.dart';
import 'package:matkonaz/widgets/components/step_list.dart';
import 'package:matkonaz/widgets/fader.dart';
import 'package:path/path.dart';
import 'dart:math';

class RecipeInfoWidget extends StatefulWidget {
  final Recipe recipe;

  const RecipeInfoWidget({Key key, this.recipe}) : super(key: key);

  @override
  RecipeInfoWidgetState createState() {
    return RecipeInfoWidgetState();
  }
}

class RecipePictureWidget extends StatelessWidget {
  final String path;

  const RecipePictureWidget({Key key, this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 150.0,
      decoration: path != null
          ? BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: FileImage(File(path)),
              ),
            )
          : null,
      child: path == null
          ? FittedBox(
              fit: BoxFit.fill,
              child: Icon(Icons.photo),
            )
          : SizedBox.shrink(),
    );
  }
}

class RecipeInfoWidgetState extends State<RecipeInfoWidget> {
  static final noScrollPhysics = const NeverScrollableScrollPhysics();

  @override
  Widget build(BuildContext context) {
    Directory appDirectory = MatkonazInheritedWidget.of(context).appDirectory;
    var recipe = widget.recipe;
    final String picPath = recipe.picturePath != null
        ? join(appDirectory.path, recipe.picturePath)
        : null;
    Widget picWidget = RecipePictureWidget(path: picPath);

    ThemeData td = Theme.of(context);
    return CmnScaffold(
      child: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  FaderWidget(
                    key: GlobalKey<FaderWidgetState>(),
                    child: picWidget,
                  ),
                  FaderWidget(
                    key: GlobalKey<FaderWidgetState>(),
                    begin: 0.2,
                    child: Text(
                      recipe.title,
                      style: td.textTheme.headline,
                    ),
                  ),
                  SizedBox(height: 15),
                  FaderAndTransformWidget(
                    milliseconds: 500,
                    key: GlobalKey<FaderAndTransformWidgetState>(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          "recipe.descriptionrecipe.descriptionrecipe.descriptionrecipe.description\nrecipe.description\nrecipe.description\nrecipe.description\n",
                          style: td.textTheme.subhead,
                        ),
                        SizedBox(height: 5),
                        Text(
                          Utils.dateFmt.format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  recipe.createdAt)),
                          style: td.textTheme.caption,
                        ),
                        IngredientList(
                          physics: noScrollPhysics,
                          ingredients: recipe.ingredients ?? [],
                        ),
                        StepList(
                          physics: noScrollPhysics,
                          steps: recipe.steps ?? [],
                        ),
                        RaisedButton(
                          child: Text("share"),
                          onPressed: () {
//              Share.file(
//                'New Challenge',
//                'pini.png',
//                file.readAsBytesSync(),
//                '*/*',
//                text: 'Recipe: ${recipe.title} dssssdsdsd',
//              );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
