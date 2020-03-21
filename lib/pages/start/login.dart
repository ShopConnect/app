import 'package:flutter/material.dart';
import 'package:shopconnect/constants.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Anmelden')),
      body: SingleChildScrollView(
        child: new Container(
          margin: EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: formUI(),
          ),
        ),
      ),
    );
  }

  Widget formUI() {
    return new Column(
      children: <Widget>[
        TextFormField(
          decoration: const InputDecoration(labelText: 'E-Mail Adresse'),
          keyboardType: TextInputType.emailAddress,
          validator: validateEmail,
          onSaved: (String val) {
            _email = val;
          },
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Passwort'),
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          validator: (String arg) {
            if (arg.length < 8) {
              return 'Bitte geben Sie ein korrektes Passwort an!';
            } else {
              return null;
            }
          },
          onSaved: (String val) {
            _password = val;
          },
        ),
        SizedBox(
          height: 10,
        ),
        RaisedButton(onPressed: _validateInputs, child: new Text('Anmelden')),
      ],
    );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      login();
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  void login() async {
    String json = '{"email": $_email, "password": $_password}';
    http.Response response = await http.post(
        AppConstants.apiURL + "/auth/login",
        headers: AppConstants.postHeaders,
        body: json);

    int statusCode = response.statusCode;

    if (statusCode == 200) {
      //TODO: Change route
      String body = response.body;
      Navigator.pushNamed(context, '/');
    } else if (statusCode == 400) {
      //TODO: Add post message that register failed because username is already in use
    }
  }
}
