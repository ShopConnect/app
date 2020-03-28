import 'package:flutter/material.dart';
import 'package:shopconnect/models/user.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: ImageIcon(
            AssetImage('assets/images/logout.png'),
          ),
          onPressed: () async {
            await User.logout(context);
          },
        ),
      ),
    );
  }
}
