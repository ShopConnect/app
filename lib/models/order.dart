import 'package:flutter/foundation.dart';
import 'package:shopconnect/enums/orderstate.dart';
import 'package:shopconnect/models/orderitem.dart';

class Order {
  int id;
  List<OrderItem> items = [];
  num maxValue;
  OrderState state;

  Order({
    @required this.id,
    @required this.items,
    @required this.maxValue,
    @required this.state,
  });
}
