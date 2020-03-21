import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ShopConnect')
      ),
      body: Column(
        children: <Widget>[
          FlatButton(
            child: Text('Anmelden'),
            onPressed: () => Navigator.pushNamed(context, '/start/login'),
          ),
          FlatButton(
            child: Text('Registrieren'),
            onPressed: () => Navigator.pushNamed(context, '/start/register'),
          ),
        ],
      ),
    );
  }
}
