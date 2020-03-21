import 'package:flutter/foundation.dart';
import 'package:shopconnect/enums/orderstate.dart';
import 'package:shopconnect/models/item.dart';

class Order {
  int id;
  List<Item> items = [];
  double maxValue = 0;
  OrderState state;

  Order({
    @required this.id,
    @required this.items,
    @required this.maxValue,
    @required this.state,
  });
}
