import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopconnect/constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrieren'),
      ),
      body: Text('Register'),
    );
  }

  void register() async {

    String json = '{"email": $_email, "password": $_password}';
    http.Response response = await http.post(AppConstants.apiURL + "/auth/register", headers: AppConstants.postHeaders, body: json);

    int statusCode = response.statusCode;

    if (statusCode == 200) {
     //TODO: Add post message that register was success
      Navigator.pushNamed(context, '/start/login');
    } else if (statusCode == 400) {
     //TODO: Add post message that register failed because username is already in use
    }
  }
}