import 'package:flutter/material.dart';
import 'package:shopconnect/constants.dart';
import 'package:shopconnect/models/order.dart';
import 'package:http/http.dart' as http;
import 'package:shopconnect/utils/token.dart';
import 'package:shopconnect/models/user.dart';

import 'dart:convert';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meine Einkaufslisten'),
      ),
      body: Text('test'),
      floatingActionButton: GestureDetector(
        child: FloatingActionButton(
          onPressed: null,
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void loadOrders() async {
    var token = Token.get();
    final Map<String, String> header = {
      "Authorization": "Bearer $token",
      "Content-type": "application/json"
    };

    http.Response response = await http.get(
      AppConstants.apiURL + "/user/@me/orders",
      headers: header,
    );

    if (response.statusCode == 200) {
      List<dynamic> orders = jsonDecode(response.body);
      orders.forEach((item) =>
        User.ownedOrders.add(new Order(id: item.id, items: item.items, maxValue: item.maxValue, state: item.state))
      );
    }
  }
}
