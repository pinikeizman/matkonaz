import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matkonaz/types/recipe.dart';

class StepList extends StatelessWidget {
  final List<RecipeStep> steps;
  final ScrollPhysics physics;

  const StepList({
    Key key,
    this.steps,
    this.physics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      physics: physics,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final RecipeStep s = steps[index];
        return ListTile(
          title: Wrap(
            spacing: 15,
            alignment: WrapAlignment.center,
            children: <Widget>[
              Text(s.title),
              Text(s.description),
              Text(s.order.toString())
            ],
          ),
        );
      },
      itemCount: steps.length,
    );
  }
}
