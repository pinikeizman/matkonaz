import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:matkonaz/main.dart';
import 'package:matkonaz/types/recipe.dart';
import 'package:matkonaz/widgets/components/recipe_photo.dart';
import 'package:matkonaz/widgets/components/step_list.dart';
import 'package:matkonaz/widgets/forms/add_ingredient_from.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:tuple/tuple.dart';
import 'package:uuid/uuid.dart';
import '../components/ingredients_list.dart';
import 'add_step_from.dart';
import '../get_picture_dialog.dart';

String notEmptyValidator(value) {
  if (value.isEmpty) {
    return 'Field must not be empty';
  }
  return null;
}

class AddRecipeForm extends StatefulWidget {
  const AddRecipeForm({Key key}) : super(key: key);

  @override
  AddRecipeFormState createState() {
    return AddRecipeFormState();
  }
}

class AddRecipeFormState extends State<AddRecipeForm> {
  final Uuid uuid = Uuid();
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final String addRecipeFilename = "add_recipe.png";
  final Function getPersistedFilePath = (String filename) =>
      getApplicationDocumentsDirectory()
          .then((dir) => join(dir.path, filename));
  FileImage _picture;

  final List<Ingredient> ingredients = [];
  final List<RecipeStep> steps = [];

  Future<FileImage> getPictureFromDisk() async {
    final String path = await getPersistedFilePath(addRecipeFilename);
    final isExists = await File(path).exists();
    return isExists ? FileImage(File(path)) : null;
  }

  @override
  void initState() {
    super.initState();
    getPictureFromDisk().then((file) => setState(() {
          _picture = file;
        }));
  }

  Future<Tuple2<File, String>> persistRecipeImageAndReturnPath(
      File tmpPictureFile, String recipeId) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final filePath =
        join('images', recipeId, '${DateTime.now().toIso8601String()}.png');
    final fullPath = join(directory.path, filePath);
    return new File(fullPath).create(recursive: true).then((file) {
      return tmpPictureFile.copy(fullPath);
    }).then((file) => Tuple2(file, filePath));
  }

  Function onSubmit(context, store) => () async {
        if (_formKey.currentState.validate()) {
          final String recipeId = uuid.v4();
          final Tuple2<File, String> fileAndPath =
              _picture?.file!=null ? await persistRecipeImageAndReturnPath(_picture?.file, recipeId)
                  .catchError((onError) {
            print(onError);
            return null;
          }) : null;
          var recipe = new Recipe(
              title: titleController.text,
              picturePath: fileAndPath?.item2,
              description: descriptionController.text,
              ingredients: ingredients,
              steps: steps,
              id: recipeId,
              createdAt: DateTime.now().millisecondsSinceEpoch);
          try {
            var _store = StoreRef.main();
            var db = await store.db;
            var json = recipe.toJson();
            await _store.record(recipe.id).put(db, json);
          } catch (e) {
            print(e);
          }
          store.store.recipes.add(recipe);
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text('Processing Data')));
          Navigator.of(context).popUntil(ModalRoute.withName('/'));
        }
      };

  Function onCancel(context) => () {
        Navigator.of(context).pop();
      };

  Function showAddPictureDialog(context) => () async {
        showDialog(
            context: context,
            builder: (context) {
              return AddPictureDialog(onPicture: (FileImage img) async {
                setState(() {
                  _picture = img;
                });
              });
            });
      };

  @override
  Widget build(BuildContext context) {
    final MatkonazInheritedWidget store = MatkonazInheritedWidget.of(context);
    final ThemeData td = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraint) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraint.maxHeight),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  AddRecipePhoto(
                    onTap: showAddPictureDialog(context),
                    provider: _picture,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'What are we cooking?',
                      labelText: 'Recipe Title *',
                    ),
                    controller: titleController,
                    validator: notEmptyValidator,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Give some more delicious details...',
                      labelText: 'Recipe Description *',
                    ),
                    controller: descriptionController,
                    validator: notEmptyValidator,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 150),
                    child: EditablePanel(
                      title: Text(
                        'Ingredients',
                        style: td.textTheme.title,
                      ),
                      body: ingredients.length > 0
                          ? IngredientList(
                              ingredients: ingredients,
                            )
                          : Text("No Ingredients yet."),
                      dialog: SimpleDialog(
                        title: Text(
                          'Add Ingredient',
                          style: td.textTheme.title,
                        ),
                        contentPadding: EdgeInsets.all(15),
                        children: <Widget>[
                          IngredientFormWidget(
                            onCancel: () => Navigator.of(context).pop(),
                            onSubmit: (Ingredient ingredient) {
                              setState(() {
                                ingredients.add(ingredient);
                                Navigator.of(context).pop();
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 150),
                    child: EditablePanel(
                      title: Text(
                        'Steps',
                        style: td.textTheme.title,
                      ),
                      body: steps.length > 0
                          ? StepList(
                              steps: steps,
                            )
                          : Text("No Steps yet."),
                      dialog: SimpleDialog(
                        title: Text(
                          'Add Ingredient',
                          style: td.textTheme.title,
                        ),
                        contentPadding: EdgeInsets.all(15),
                        children: <Widget>[
                          StepFormWidget(
                            onCancel: () => Navigator.of(context).pop(),
                            onSubmit: (RecipeStep step) {
                              setState(() {
                                steps.add(step);
                                Navigator.of(context).pop();
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  SubmitCancelFormControl(
                      onSubmit(context, store), onCancel(context))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EditablePanel extends StatelessWidget {
  final Widget title;
  final Widget dialog;
  final Widget body;

  const EditablePanel({
    Key key,
    this.dialog,
    this.title,
    this.body,
  }) : super(key: key);

  void showAddIngredientDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  title,
                  SizedBox(
                    width: 50,
                    child: FlatButton(
                      onPressed: () {
                        showAddIngredientDialog(context);
                      },
                      child: Icon(
                        Icons.add,
                        size: 20,
                      ),
                      textTheme: ButtonTextTheme.primary,
                      padding: EdgeInsets.all(0),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Flexible(child: body),
      ],
    );
  }
}

class SubmitCancelFormControl extends StatelessWidget {
  final Function onSubmit;
  final Function onCancel;

  const SubmitCancelFormControl(this.onSubmit, this.onCancel);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          onPressed: onSubmit,
          child: Text('Submit'),
        ),
        SizedBox(width: 16.0),
        RaisedButton(
          onPressed: onCancel,
          child: Text('Cancel'),
        ),
      ],
    );
  }
}

class AddRecipePhoto extends StatelessWidget {
  final Function onTap;
  final ImageProvider provider;

  const AddRecipePhoto({Key key, this.onTap, this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Tooltip(
        message: "Add recipe photo",
        child: GestureDetector(
          onTap: onTap,
          child: RecipePicture(
            provider: provider,
            size: 150,
          ),
        ));
  }
}
