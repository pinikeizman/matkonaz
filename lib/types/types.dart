import 'dart:ffi';

import 'package:flutter/cupertino.dart';

class Ingredient {
  final String name;
  final Float amount;

  const Ingredient({this.name, this.amount});
}

class Step {
  final Ingredient ingredient;

  const Step({this.ingredient});
}

class Recipe {
  const Recipe({
    @required this.title,
    @required this.description,
    @required this.ingredients,
    @required this.steps,
    @required this.id,
  });

  final String id;
  final String title;
  final String description;
  final List<Ingredient> ingredients;
  final List<Step> steps;
}
