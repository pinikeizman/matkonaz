//
//class EditableTile extends StatefulWidget {
//  @override
//  EditableTileState createState() {
//    // TODO: implement createState
//    return EditableTileState();
//  }
//}
//
//class EditableTileState extends State<EditableTile> {
//  final FocusNode _focusNode = FocusNode();
//  bool isEdit;
//
//  EditableTileState({this.isEdit});
//
//  @override
//  Widget build(BuildContext context) {
//    return FocusScope(
//      debugLabel: "EditableTileState",
//      autofocus: true,
//      child: Focus(
//        debugLabel: "Pini",
//        child: Builder(
//          builder: (BuildContext context) {
//            final FocusNode focusNode = Focus.of(context);
//            final bool hasFocus = focusNode.hasFocus;
//            var widget =
//            hasFocus ? IngredientFormWidget() : Text("not in edit");
//            return GestureDetector(
//                onTap: () {
//                  focusNode.requestFocus();
//                },
//                child: widget);
//          },
//        ),
//      ),
//    );
//  }
//}
