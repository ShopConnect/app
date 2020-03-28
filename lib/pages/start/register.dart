import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopconnect/constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _passwordRepeatFocusNode = FocusNode();
  bool _autoValidate = false;
  String _email;
  String _password;
  String _passwordRepeat;
  bool _emailAlreadyInUse = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrieren')),
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
            onFieldSubmitted: (_) => changeFocus(
              context: context,
              current: _emailFocusNode,
              next: _passwordFocusNode,
            ),
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
            textInputAction: TextInputAction.next,
            validator: validatePassword,
            focusNode: _passwordFocusNode,
            onFieldSubmitted: (_) => changeFocus(
              context: context,
              current: _passwordFocusNode,
              next: _passwordRepeatFocusNode,
            ),
            onSaved: (String val) {
              _password = val;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: 'Passwort wiederholen',
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
            validator: validatePassword,
            focusNode: _passwordRepeatFocusNode,
            onSaved: (String val) {
              _passwordRepeat = val;
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
              'Registrieren',
              style: TextStyle(fontSize: 20),
            ),
            onPressed: _validateInputs,
          ),
        ),
      ],
    );
  }

  void changeFocus({
    @required BuildContext context,
    @required FocusNode current,
    @required FocusNode next,
  }) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Bitte geben Sie eine gültige E-Mail Adresse ein!';
    } else if (_emailAlreadyInUse) {
      return 'Diese E-Mail Adresse ist bereits vergeben.';
    } else {
      return null;
    }
  }

  String validatePassword(String value) {
    if (value.length < 8) {
      return 'Bitte geben Sie ein gültiges Passwort ein!';
    } else if (_password != _passwordRepeat) {
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
        changeValidate(true);
      }
    } else {
      changeValidate(true);
    }
  }

  void register() async {
    _emailAlreadyInUse = false;
    String json = '{"email": "$_email", "password": "$_password"}';
    http.Response response = await http.post(
      AppConstants.apiURL + "/auth/register",
      headers: AppConstants.postHeaders,
      body: json,
    );

    int statusCode = response.statusCode;
    if (statusCode == 201) {
      Navigator.pushReplacementNamed(context, '/start/login');
    } else if (statusCode == 400) {
      _emailAlreadyInUse = true;
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
