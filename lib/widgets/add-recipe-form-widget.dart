import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matkonaz/main.dart';
import 'package:matkonaz/stores/recipesstore.dart';
import 'package:matkonaz/types/types.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

final recipes = RecipesStore();

class AppState {
  const AppState({
    @required this.state,
  }) : assert(state != null);
  final dynamic state;
}

class AddRecipeForm extends StatefulWidget {
  @override
  AddRecipeFormState createState() {
    // TODO: implement createState
    return AddRecipeFormState();
  }
}

writeRecipeToDisk(Recipe recipe) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("recepies.${recipe.id}", jsonEncode(recipe));
}

class AddRecipeFormState extends State<AddRecipeForm> {
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void onSubmit() {
      // Validate returns true if the form is valid, or false
      // otherwise.
      if (_formKey.currentState.validate()) {
        // If the form is valid, display a Snackbar.
        recipes.add(new Recipe(title: myController.text, description: null, ingredients: null, steps: null, id: null));
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Processing Data')));
        Navigator.of(context).pushNamed("${Routes.app_recipes}");
      }
    }

    void onCancel() {
      Navigator.of(context).pop();
    }

    // TODO: implement build
    return new Scaffold(
        body: Form(
            key: _formKey,
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'What is this recipe for?',
                          labelText: 'Recipe Title *',
                        ),
                        controller: myController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter recipe title';
                          }
                          return null;
                        },
                      ),
                      SubmitCancelFormControl(onSubmit, onCancel)
                    ]))));
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
