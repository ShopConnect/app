import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shopconnect/constants.dart';
import 'package:shopconnect/models/category.dart';
import 'package:shopconnect/pages/main/myorders/myorders.dart';
import 'package:shopconnect/pages/main/orders/orders.dart';
import 'package:shopconnect/pages/main/settings/settings.dart';
import 'package:shopconnect/utils/categories.dart';
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

  void loadItemCategories() async {
    var token = Token.get();
    final Map<String, String> header = {
      "Authorization": "Bearer $token",
      "Content-type": "application/json"
    };

    http.Response response = await http.get(
      AppConstants.apiURL + "/categories",
      headers: header,
    );

    if (response.statusCode == 200) {
      List<dynamic> categories = jsonDecode(response.body);
      categories.forEach((item) =>
        Categories.categories.add(new Category(id: item.id, name: item.name, description: item.description))
      );
    }
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
