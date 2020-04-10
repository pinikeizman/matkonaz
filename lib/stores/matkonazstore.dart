import 'package:matkonaz/types/recipe.dart';
import 'package:mobx/mobx.dart';

part 'matkonazstore.g.dart';

class MatkonazStore = _MatkonazStore with _$MatkonazStore;

abstract class _MatkonazStore with Store {
  @observable
  List<Recipe> recipes = <Recipe>[];

  @action
  void add(Recipe recipe) {
    recipes.add(recipe);
  }

  @action
  void set(List<Recipe> _recipes) {
    recipes = _recipes;
  }
}
