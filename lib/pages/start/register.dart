import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopconnect/constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _email;
  String _password;
  String _passwordRepeat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrieren')),
      body: SingleChildScrollView(
        child: Container(
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
    return Column(
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
          validator: validatePassword,
          onSaved: (String val) {
            _password = val;
          },
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Passwort wiederholen'),
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          validator: validatePassword,
          onSaved: (String val) {
            _passwordRepeat = val;
          },
        ),
        SizedBox(
          height: 10,
        ),
        RaisedButton(
          onPressed: _validateInputs,
          child: Text('Registrieren'),
        ),
      ],
    );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Bitte geben Sie eine gültige E-Mail Adresse ein!';
    } else {
      return null;
    }
  }

  String validatePassword(String value) {
    if (value.length < 8) {
      return 'Bitte geben Sie ein gültiges Passwort ein!';
    } else if(_password != _passwordRepeat) {
      return 'Beide Passwörter müssen identisch sein!';
    } else {
      return null;
    }
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (_password == _passwordRepeat) {
        register();
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  void register() async {
    String json = '{"email": "$_email", "password": "$_password"}';
    http.Response response = await http.post(
        AppConstants.apiURL + "/auth/register",
        headers: AppConstants.postHeaders,
        body: json);

    int statusCode = response.statusCode;
    print(statusCode);
    if (statusCode == 201) {
      //TODO: Add post message that register was success
      Navigator.pushReplacementNamed(context, '/start/login');
    } else if (statusCode == 400) {
      //TODO: Add post message that register failed because username is already in use
    }
  }
}
