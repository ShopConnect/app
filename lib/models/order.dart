import 'package:flutter/foundation.dart';
import 'package:shopconnect/enums/orderstate.dart';

class Order {
  int id;
  List<int> items = [];
  num maxValue;
  OrderState state;

  Order({
    @required this.id,
    @required this.items,
    @required this.maxValue,
    @required this.state,
  });
}
