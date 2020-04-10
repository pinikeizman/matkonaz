import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matkonaz/types/recipe.dart';
import 'package:matkonaz/widgets/forms/add_recipe_form_widget.dart';
import 'package:uuid/uuid.dart';

final Uuid uuid = Uuid();

class IngredientFormWidget extends StatefulWidget {
  final Null Function(Ingredient) onSubmit;
  final Function onCancel;

  const IngredientFormWidget({Key key, this.onSubmit, this.onCancel})
      : super(key: key);

  @override
  IngredientFormWidgetState createState() {
    return IngredientFormWidgetState();
  }
}

class IngredientFormWidgetState extends State<IngredientFormWidget> {
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final unitController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  onFormSubmit() {
    if (_formKey.currentState.validate()) {
      var ingredient = new Ingredient(
          id: uuid.v4(),
          name: nameController.text,
          unit: unitController.text,
          amount: int.tryParse(amountController.text),
          createdAt: DateTime.now().millisecondsSinceEpoch);
      if(widget.onSubmit != null) widget.onSubmit(ingredient);
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
            decoration: InputDecoration(labelText: "Name"),
            controller: nameController,
            validator: notEmptyValidator,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Amount"),
            controller: amountController,
            validator: notEmptyValidator,
            keyboardType: TextInputType.number,
            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "unit"),
            controller: unitController,
            validator: notEmptyValidator,
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
