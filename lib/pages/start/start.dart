import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ShopConnect')),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RaisedButton(
              elevation: 5,
              child: Text('Anmelden'),
              onPressed: () => Navigator.pushNamed(context, '/start/login'),
            ),
            RaisedButton(
              elevation: 5,
              child: Text('Registrieren'),
              onPressed: () => Navigator.pushNamed(context, '/start/register'),
            ),
          ],
        ),
      ),
    );
  }
}
