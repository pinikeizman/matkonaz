import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matkonaz/types/recipe.dart';
import 'package:matkonaz/widgets/forms/add_recipe_form_widget.dart';
import 'package:uuid/uuid.dart';

final Uuid uuid = Uuid();

class StepFormWidget extends StatefulWidget {
  final Null Function(RecipeStep) onSubmit;
  final Function onCancel;

  const StepFormWidget({Key key, this.onSubmit, this.onCancel})
      : super(key: key);

  @override
  StepFormWidgetState createState() {
    return StepFormWidgetState();
  }
}

class StepFormWidgetState extends State<StepFormWidget> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final orderController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  onFormSubmit() {
    if (_formKey.currentState.validate()) {
      var step = new RecipeStep(
          id: uuid.v4(),
          title: titleController.text,
          description: descriptionController.text,
          order: int.tryParse(orderController.text),
          createdAt: DateTime.now().millisecondsSinceEpoch);
      if(widget.onSubmit != null) widget.onSubmit(step);
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData td = Theme.of(context);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: "Title"),
            controller: titleController,
            validator: notEmptyValidator,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Description"),
            controller: descriptionController,
            validator: notEmptyValidator,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "order"),
            controller: orderController,
            validator: notEmptyValidator,
            keyboardType: TextInputType.number,
            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
          ),
          SizedBox.fromSize(
            size: Size.fromHeight(20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: onFormSubmit,
                child: Text(
                  "Add",
                  style: td.textTheme.button,
                ),
              ),
              SizedBox(width: 20,),
              FlatButton(
                onPressed: widget.onCancel,
                child: Text(
                  "Cancel",
                  style: td.textTheme.button,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
