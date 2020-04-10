import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../main.dart';

class CmnScaffold extends StatelessWidget {
  final Widget child;
  final String title;
  final List<Widget> actions;

  const CmnScaffold(
      {Key key, this.child, this.title = "Matkonaz", this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(this.title),
        actions: actions ??
            <Widget>[
              FlatButton(
                child: Icon(Icons.note_add),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed("${Routes.app_recipes_recipe_add}");
                },
              )
            ],
      ),
      body: this.child,
    );
  }
}
