import 'package:flutter/material.dart';
import 'package:shopconnect/models/order.dart';
import 'package:shopconnect/pages/main/myorders/orderitems.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  OrderCard(this.order);

  void showOrderItems(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderItems(order)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showOrderItems(context),
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 5,
        ),
        child: ListTile(
          title: Text('Anzahl Produkte: ' + order.items.length.toString()),
          subtitle: Text('Maximaler Einkaufsbetrag: ' + order.maxValue.toStringAsFixed(2)),
          trailing: Text(order.state.toString().split('.')[1]),
        ),
      ),
    );
  }
}