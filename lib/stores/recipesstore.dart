import 'package:matkonaz/types/types.dart';
import 'package:mobx/mobx.dart';

part 'recipesstore.g.dart';

class RecipesStore = _RecipesStore with _$RecipesStore;

abstract class _RecipesStore with Store {
  @observable
  List<Recipe> recipes = <Recipe>[];

  @action
  void add(Recipe recipe) {
    recipes.add(recipe);
  }
}
