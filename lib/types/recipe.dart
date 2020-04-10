import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recipe.g.dart';

@JsonSerializable()
class Ingredient {
  final String name;
  final int amount;
  final String unit;
  final String id;
  final int createdAt;

  const Ingredient(
      {@required this.name,
      @required this.amount,
      @required this.unit,
      @required this.id,
      this.createdAt});

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}

@JsonSerializable()
class RecipeStep {
  final String id;
  final String title;
  final String description;
  final int order;
  final int createdAt;

  const RecipeStep(
      {this.id, this.title, this.description, this.order, this.createdAt});

  factory RecipeStep.fromJson(Map<String, dynamic> json) =>
      _$RecipeStepFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeStepToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Recipe {
  const Recipe(
      {@required this.id,
      @required this.title,
      this.description,
      this.ingredients,
      this.steps,
      this.picturePath,
      this.createdAt});

  final String id;
  final String title;
  final String description;
  final String picturePath;
  final List<Ingredient> ingredients;
  final List<RecipeStep> steps;
  final int createdAt;

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeToJson(this);
}
