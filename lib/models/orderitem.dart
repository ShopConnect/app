import 'package:flutter/foundation.dart';
import 'package:shopconnect/models/item.dart';

class OrderItem {
  int id;
  int quantity;
  bool isOptional;
  Item item;

  OrderItem({
    @required this.id,
    @required this.quantity,
    @required this.isOptional,
    @required this.item,
  });
}