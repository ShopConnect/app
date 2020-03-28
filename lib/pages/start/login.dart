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
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _autoValidate = false;
  String _email;
  String _password;
  bool _wrongPassword = false;
  bool _userDeactivated = false;
  bool _userNotFound = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Anmelden')),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/start_background.jpg'),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: formUI(),
            ),
          ),
        ),
      ),
    );
  }

  Widget formUI() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: 'E-Mail Adresse',
              filled: true,
              fillColor: Color.fromRGBO(255, 255, 255, 0.8),
              errorMaxLines: 3,
              errorStyle: TextStyle(
                fontSize: 14.0,
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: validateEmail,
            focusNode: _emailFocusNode,
            onFieldSubmitted: (_) {
              _emailFocusNode.unfocus();
              FocusScope.of(context).requestFocus(_passwordFocusNode);
            },
            onSaved: (String val) {
              _email = val;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: 'Passwort',
              filled: true,
              fillColor: Color.fromRGBO(255, 255, 255, 0.8),
              errorMaxLines: 3,
              errorStyle: TextStyle(
                fontSize: 14.0,
              ),
            ),
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            focusNode: _passwordFocusNode,
            validator: validatePassword,
            onSaved: (String val) {
              _password = val;
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.only(left: 50, right: 50),
          width: MediaQuery.of(context).size.width,
          child: RaisedButton(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(top: 20, bottom: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            elevation: 5,
            textColor: Colors.white,
            child: Text(
              'Anmelden',
              style: TextStyle(fontSize: 20),
            ),
            onPressed: _validateInputs,
          ),
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
    } else if (_userDeactivated) {
      return 'Dieser Account wurde aus dem System ausgeschlossen.';
    } else if (_userNotFound) {
      return 'Diese E-Mail Adresse konnte keinem Account zugeordnet werden!';
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
      changeValidate(true);
    }
  }

  void login() async {
    _userNotFound = false;
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

        http.Response responseUser =
            await http.get(AppConstants.apiURL + "/user/@me", headers: header);

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

          // TODO: If 201 or schon vorhanden Navigate ausführen sonst? <-- einbauen sobald Nick go gibt
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/home',
              (Route<dynamic> route) => false,
            );
        }
      }
    } else if (statusCode == 401) {
      var result = jsonDecode(response.body);
      if (result['message'] == 'password') {
        _wrongPassword = true;
        changeValidate(true);
      } else {
        _wrongPassword = false;
      }

      if (result['message'] == 'deactivated') {
        _userDeactivated = true;
        changeValidate(true);
      } else {
        _userDeactivated = false;
      }
    } else if (statusCode == 404) {
      _userNotFound = true;
      changeValidate(true);
    }
  }

  void changeValidate(bool validate) {
    if (mounted) {
      setState(() {
        _autoValidate = validate;
      });
    }
  }
}
