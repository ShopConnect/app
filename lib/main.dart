import 'package:flutter/material.dart';
import 'package:shopconnect/pages/start/login.dart';
import 'package:shopconnect/pages/start/register.dart';
import 'package:shopconnect/pages/start/start.dart';

void main() => runApp(ShopConnect());

class ShopConnect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/start',
      routes: {
        '/start': (context) => StartPage(),
        '/start/login': (context) => LoginPage(),
        '/start/register': (context) => RegisterPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text('HAHA')
      ),
    );
  }
}
