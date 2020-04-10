import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:matkonaz/stores/matkonazstore.dart';
import 'package:matkonaz/types/recipe.dart';
import 'package:matkonaz/widgets/forms/add_recipe_form_widget.dart';
import 'package:matkonaz/widgets/cmn_scaffold_widget.dart';
import 'package:matkonaz/widgets/recipes_list_widget.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final store = MatkonazStore();
  final List<CameraDescription> cameras = await availableCameras();
  final Directory appDirectory = await getApplicationDocumentsDirectory();

  runApp(
    MatkonazInheritedWidget(
        store: store,
        cameras: cameras,
        appDirectory: appDirectory,
        child: MyApp(),
  ),);
}

class MatkonazInheritedWidget extends InheritedWidget {
  final MatkonazStore store;
  final List<CameraDescription> cameras;
  final Directory appDirectory;

  // We use the database factory to open the database
  final Future<Database> db = getApplicationDocumentsDirectory().then(
          (documentDir) =>
          databaseFactoryIo.openDatabase(join(documentDir.path, 'matkonaz')));

  MatkonazInheritedWidget({
    Key key,
    @required this.store,
    @required this.cameras,
    @required this.appDirectory,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return false;
  }

  static MatkonazInheritedWidget of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<MatkonazInheritedWidget>();
  }
}

enum Routes {
  app_home,
  app_recipes,
  app_recipes_recipe_add,
  take_picture,
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MatkonazInheritedWidget matkonazInheritedWidget =
    MatkonazInheritedWidget.of(context);
    matkonazInheritedWidget.db.then((db) {
      var store = StoreRef.main();
      store.find(db).then((data) {
        final List<Recipe> list = data
            .map((d) => d.value as Map)
            .map((d) => Recipe.fromJson(d))
            .toList();
        matkonazInheritedWidget.store.set(list);
      }).catchError(print);
    });
    return MaterialApp(
        title: 'Makonaz',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RecipesList(),
        routes: <String, WidgetBuilder>{
          "${Routes.app_recipes_recipe_add}": (BuildContext context) =>
              CmnScaffold(
                actions: [],
                child: AddRecipeForm(),
              ),
          "${Routes.app_recipes}": (BuildContext context) => RecipesList(),
          "${Routes.app_recipes}": (BuildContext context) => RecipesList()
        });
  }
}
