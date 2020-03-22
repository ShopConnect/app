import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shopconnect/constants.dart';
import 'package:shopconnect/models/category.dart';
import 'package:shopconnect/pages/main/myorders/myorders.dart';
import 'package:shopconnect/pages/main/orders/orders.dart';
import 'package:shopconnect/pages/main/settings/settings.dart';
import 'package:shopconnect/utils/lists.dart';
import 'package:shopconnect/utils/token.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 1;
  final List<Widget> _widgetOptions = <Widget>[
    Settings(),
    MyOrders(),
    Orders(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Einstellungen'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            title: Text('Einkaufen'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text('Einkaufslisten'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
