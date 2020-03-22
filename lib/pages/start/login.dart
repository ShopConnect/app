import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shopconnect/constants.dart';

import 'package:http/http.dart' as http;
import 'package:shopconnect/models/user.dart';
import 'dart:convert';

import 'package:shopconnect/utils/token.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _autoValidate = false;
  String _email;
  String _password;
  bool _wrongPassword = false;
  // TODO: Message box that informs the user he is BANNED
  bool _userDeactivated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Anmelden')),
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
        SizedBox(
          height: 10,
        ),
        RaisedButton(
          onPressed: _validateInputs,
          child: Text('Anmelden'),
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
      return 'Bitte geben Sie ein korrektes Passwort an!';
    } else if (_wrongPassword) {
      return 'Ihr Passwort ist falsch!';
    } else {
      return null;
    }
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
    String fcmToken = await _firebaseMessaging.getToken();

    String json = '{"email": "$_email", "password": "$_password"}';
    http.Response response = await http.post(
      AppConstants.apiURL + "/auth/login",
      headers: AppConstants.postHeaders,
      body: json,
    );

    int statusCode = response.statusCode;
    if (statusCode == 201) {
      var token = jsonDecode(response.body);
      if (token != null) {
        Token.set(token['token']);
        var tokenAuth = token['token'];

        final Map<String, String> header = {
          "Authorization": "Bearer $tokenAuth",
          "Content-type": "application/json"
        };

        http.Response responseUser = await http
            .get(AppConstants.apiURL + "/user/@me", headers: header);

        int statusCodeUser = responseUser.statusCode;
        if (statusCodeUser == 200) {
          var userReponse = jsonDecode(responseUser.body);
          User.id = userReponse['id'];
          User.firstName = userReponse['firstName'];
          User.lastName = userReponse['lastName'];
          User.email = userReponse['email'];
          User.country = userReponse['country'];
          User.city = userReponse['city'];
          User.zipCode = userReponse['zipCode'];
          User.street = userReponse['street'];
          User.houseNumber = userReponse['houseNumber'];
          User.payPalHandle = userReponse['payPalHandle'];
          User.iban = userReponse['iban'];
          User.telephoneNumber = userReponse['telephoneNumber'];
          User.isVerified = userReponse['isVerified'];

          String fcmTokenJSON = '{"token": "$fcmToken"}';

          http.Response responseToken = await http.post(
            AppConstants.apiURL + "/user/@me/register-device",
            headers: header,
            body: fcmTokenJSON,
          );
          int statusCodeToken = responseToken.statusCode;

          User.loadOrders();

          if (statusCodeToken == 201) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/home',
              (Route<dynamic> route) => false,
            );
          }
        }
      }
    } else if (statusCode == 401) {
      var result = jsonDecode(response.body);
      if (result['message'] == 'password') {
        _wrongPassword = true;
      } else {
        _wrongPassword = false;
      }

      if (result['message'] == 'deactivated') {
        _userDeactivated = true;
      } else {
        _userDeactivated = false;
      }
    } else if (statusCode == 404) {
      //TODO: Add post message that register failed because username is already in use
    }
  }
}
