import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final IconData icon;
  final String label;

  ProfileButton({
    @required this.icon,
    @required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {},
        child: RawMaterialButton(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                icon,
                size: 40,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(
                height: 10,
              ),
              Text(label),
            ],
          ),
          onPressed: null,
        ),
      ),
    );
  }
}
