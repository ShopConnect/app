import 'package:flutter/material.dart';
import 'package:shopconnect/enums/myordernavigation.dart';

class MyOrderNavigationButton extends StatelessWidget {
  final MyOrderNavigation myOrderNavigationButton;
  final Function onPressed;
  final bool selected;

  MyOrderNavigationButton(
    this.myOrderNavigationButton, {
    @required this.onPressed,
    @required this.selected,
  });

  // decoration: selected
  //                   ? BoxDecoration(
  //                       border: Border(
  //                         bottom: BorderSide(
  //                           width: 2,
  //                           color: Theme.of(context).primaryColor,
  //                         ),
  //                       ),
  //                     )
  //                   : null,

  // elevation: 8,
  // shadowColor: Color(0xFFFAFAFA),

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          top: 10,
          right: 10,
          bottom: 0,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: Container(
            color: selected ? Colors.white : Color(0xFFF1F1F1),
            child: RawMaterialButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onPressed: () => onPressed(myOrderNavigationButton),
              child: Text(
                _getText(),
              ),
            ),
          ),
        ),
      ),
      // ),
    );
  }

  String _getText() {
    switch (myOrderNavigationButton) {
      case MyOrderNavigation.Active:
        return 'Aktive';
      case MyOrderNavigation.Finished:
        return 'Erledigte';
      default:
        return null;
    }
  }
}
