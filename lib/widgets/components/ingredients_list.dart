import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matkonaz/types/recipe.dart';

class IngredientList extends StatelessWidget {
  final List<Ingredient> ingredients;
  final ScrollPhysics physics;

  const IngredientList({
    Key key,
    this.ingredients,
    this.physics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      physics: physics,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final Ingredient i = ingredients[index];
        return ListTile(
          title: Wrap(
            spacing: 15,
            alignment: WrapAlignment.center,
            children: <Widget>[
              Text(i.name),
              Text(i.amount.toString()),
              Text(i.unit)
            ],
          ),
        );
      },
      itemCount: ingredients.length,
    );
  }
}
