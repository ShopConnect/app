import 'dart:convert';

import 'package:shopconnect/constants.dart';
import 'package:shopconnect/enums/orderstate.dart';
import 'package:shopconnect/models/item.dart';
import 'package:shopconnect/models/order.dart';
import 'package:shopconnect/models/orderitem.dart';
import 'package:shopconnect/utils/token.dart';
import 'package:http/http.dart' as http;

class User {
  static int id = 0;
  static String firstName = '';
  static String lastName = '';
  static String birthday = '';
  static String email = '';
  static String country = '';
  static String city = '';
  static String zipCode = '';
  static String street = '';
  static String houseNumber = '';
  static String payPalHandle = '';
  static String iban = '';
  static String telephoneNumber = '';
  static List<Order> ownedOrders = [];
  static List<Order> acceptedOrders = [];
  static bool isVerified = false;

  static Future<void> loadOrders() async {
    User.ownedOrders = [];
    var token = await Token.get();
    final Map<String, String> header = {
      "Authorization": "Bearer $token",
      "Content-type": "application/json"
    };

    http.Response response = await http.get(
      AppConstants.apiURL + "/user/@me/orders",
      headers: header,
    );
    print(response.body);
    if (response.statusCode == 200) {
      List<dynamic> orders = jsonDecode(response.body);
      orders.forEach(
        (item) {
          List<OrderItem> items = [];
          if (item['items'] != null) {
            if (item['items'].length > 0) {
              item['items'].forEach((item) {
                var itemH = item['item'];
                items.add(
                  OrderItem(
                    id: item['id'],
                    quantity: item['quantity'],
                    isOptional: item['isOptional'],
                    item: Item(
                      id: itemH['id'],
                      name: itemH['name'],
                      description: itemH['description'],
                      price: double.parse(itemH['price']),
                      category: itemH[''],
                    ),
                  ),
                );
              });
            }
          }
          User.ownedOrders.add(
            new Order(
              id: item['id'],
              items: items,
              maxValue: item['maxValue'],
              state: OrderState.values.elementAt(item['orderState']),
            ),
          );
        },
      );
    }
  }
}
