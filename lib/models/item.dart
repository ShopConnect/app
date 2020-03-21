import 'package:flutter/foundation.dart';

class Item {
  int id;
  String name;
  String description;
  double price;
  int quantity;
  int category;
  bool isOptional;

  Item({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.price,
    @required this.quantity,
    @required this.category,
    @required this.isOptional,
  });
}