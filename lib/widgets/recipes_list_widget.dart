import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:matkonaz/main.dart';
import 'package:matkonaz/stores/matkonazstore.dart';
import 'package:matkonaz/widgets/components/recipe.dart';
import 'package:path/path.dart';

import 'cmn_scaffold_widget.dart';

class RecipesList extends StatelessWidget {
  const RecipesList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Directory appDirectory = MatkonazInheritedWidget.of(context).appDirectory;
    final MatkonazStore store = MatkonazInheritedWidget.of(context).store;
    return CmnScaffold(
      child: Observer(
          name: 'recipe_list',
          builder: (_) {
            var listWidget = ListView.builder(
              itemCount: store.recipes.length,
              itemBuilder: (context, index) {
                var recipe = store.recipes[index];
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RecipeInfoWidget(
                        recipe: recipe,
                      ),
                    ));
                  },
                  leading: Image(
                    height: 50.0,
                    width: 50.0,
                    fit: BoxFit.fill,
                    image: recipe.picturePath != null
                        ? FileImage(
                            File(join(appDirectory.path, recipe.picturePath)))
                        : AssetImage("icons/recipe.png"),
                  ),
                  title: Text(recipe.title),
                  subtitle: recipe.description != null
                      ? Text(recipe.description)
                      : null,
                  trailing: recipe.createdAt != null
                      ? Text(
                          "${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(recipe.createdAt)).inMinutes}m ago")
                      : SizedBox.shrink(),
                );
              },
            );
            var children = store.recipes.length != 0
                ? listWidget
                : Text("No recipes yet.");

            return children;
          }),
    );
  }
}
