import 'package:flutter/material.dart';
import 'package:shopconnect/models/order.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  OrderCard(this.order);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 5,
        ),
        child: ListTile(
          leading: Text(order.id.toString()),
          title: Text('Name'),
          subtitle: Text('Anzahl Produkte: ' + order.items.length.toString()),
          trailing: Text(order.state.toString().split('.')[1]),
        ),
      ),
    );
  }
}