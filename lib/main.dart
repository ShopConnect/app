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

  if (await Token.get() == null) {
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
      title: 'Shop Connect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF3CA8BA),
        accentColor: Color(0xFFDEDEDEDE),
        backgroundColor: Color(0xFFF1F1F1),
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
