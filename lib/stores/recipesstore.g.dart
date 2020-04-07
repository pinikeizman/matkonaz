// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipesstore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RecipesStore on _RecipesStore, Store {
  final _$recipesAtom = Atom(name: '_RecipesStore.recipes');

  @override
  List<Recipe> get recipes {
    _$recipesAtom.context.enforceReadPolicy(_$recipesAtom);
    _$recipesAtom.reportObserved();
    return super.recipes;
  }

  @override
  set recipes(List<Recipe> value) {
    _$recipesAtom.context.conditionallyRunInAction(() {
      super.recipes = value;
      _$recipesAtom.reportChanged();
    }, _$recipesAtom, name: '${_$recipesAtom.name}_set');
  }

  final _$_RecipesStoreActionController =
      ActionController(name: '_RecipesStore');

  @override
  void add(Recipe recipe) {
    final _$actionInfo = _$_RecipesStoreActionController.startAction();
    try {
      return super.add(recipe);
    } finally {
      _$_RecipesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'recipes: ${recipes.toString()}';
    return '{$string}';
  }
}
