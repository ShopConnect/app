import 'package:flutter/foundation.dart';

class Item {
  int id;
  String name;
  String description;
  double price;
  int category;

  Item({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.price,
    @required this.category,
  });
}