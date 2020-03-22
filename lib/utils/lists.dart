import 'dart:convert';

import 'package:shopconnect/constants.dart';
import 'package:shopconnect/models/category.dart';
import 'package:shopconnect/models/item.dart';
import 'package:shopconnect/utils/token.dart';
import 'package:http/http.dart' as http;

class Lists {
  static List<Category> categories = [];
  static List<Item> items = [];

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
      List<dynamic> categoriesList = jsonDecode(response.body);
      categoriesList.forEach((item) =>
        categories.add(new Category(id: item['id'], name: item['name'], description: item.item['description']))
      );
    }
  }

  void loadItemsForCategory(int id) async {
    var token = Token.get();
    final Map<String, String> header = {
      "Authorization": "Bearer $token",
      "Content-type": "application/json"
    };

    http.Response response = await http.get(
      AppConstants.apiURL + "/categories/$id",
      headers: header,
    );

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      List<dynamic> itemList = jsonDecode(responseBody['items']);
      items.clear();
      itemList.forEach((item) =>
        items.add(new Item(id: item['id'], name: item['name'], description: item['description'],
        price: item['price'], category: item['category']))
      );
    }
  }
}
