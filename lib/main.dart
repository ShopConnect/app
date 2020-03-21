import 'package:flutter/material.dart';
import 'package:shopconnect/pages/main/home.dart';
import 'package:shopconnect/pages/start/login.dart';
import 'package:shopconnect/pages/start/register.dart';
import 'package:shopconnect/pages/start/start.dart';
import 'package:shopconnect/utils/push_notifications.dart';
import 'package:shopconnect/utils/token.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String initialRoute;

  if(await Token.get() == null) {
    initialRoute = '/start';
  } else {
    initialRoute = '/home';
  }

  runApp(ShopConnect(initialRoute));
}

class ShopConnect extends StatelessWidget {
  final String initialRoute;
  dynamic notificationsManager;

  ShopConnect(this.initialRoute);

  @override
  Widget build(BuildContext context) {
    notificationsManager = PushNotificationsManager().init();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: initialRoute,
      routes: {
        '/start': (context) => StartPage(),
        '/start/login': (context) => LoginPage(),
        '/start/register': (context) => RegisterPage(),
        '/home': (context) => Home(),
      },
    );
  }
}