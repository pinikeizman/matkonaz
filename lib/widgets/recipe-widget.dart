import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matkonaz/types/types.dart';

class RecipeWidget extends StatelessWidget {
  final Recipe recipe;

  const RecipeWidget({this.recipe});

  static fromRecipe(Recipe recipe) {
    return new RecipeWidget(recipe: recipe);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: <Widget>[
        Text("Image"),
        Column(
          children: <Widget>[
            Text("Title: ${recipe.title}"),
            Text("Description: ${recipe.title}")
          ],
        )
      ],
    );
  }
}