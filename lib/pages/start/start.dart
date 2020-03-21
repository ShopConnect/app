import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/start_background.jpg'),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 2,
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('lib/assets/images/logo.png'),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.6),
                    ),
                    child: Text(
                      'Gemeinsam sind wir stärker!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 50),
              margin: EdgeInsets.only(left: 50, right: 50),
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
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
                      onPressed: () =>
                          Navigator.pushNamed(context, '/start/login'),
                    ),
                  ),
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    elevation: 5,
                    textColor: Colors.white,
                    child: Text(
                      'Registrieren',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () =>
                        Navigator.pushNamed(context, '/start/register'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
