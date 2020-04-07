import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matkonaz/widgets/add-recipe-form-widget.dart';
import 'package:matkonaz/types/types.dart';
import 'package:matkonaz/widgets/recipe-widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class RecipesList extends StatefulWidget {
  @override
  RecipesListState createState() {
    // TODO: implement createState
    return RecipesListState();
  }
}

class RecipesListState extends State<RecipesList> {
  final _formKey = GlobalKey<FormState>();
  List<Recipe> recipes = [];

  @override
  Widget build(BuildContext context) {
    void onSubmit() {
      // Validate returns true if the form is valid, or false
      // otherwise.
      if (_formKey.currentState.validate()) {
        // If the form is valid, display a Snackbar.
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Processing Data')));
        Navigator.of(context).pop();
      }
    }

    void onCancel() {
      Navigator.of(context).pop();
    }

    // TODO: implement build
    return Column(
      children:
          recipes.map((recipe) => new RecipeWidget(recipe: recipe)).toList(),
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
