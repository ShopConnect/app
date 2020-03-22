import 'package:flutter/material.dart';
import 'package:shopconnect/models/orderitem.dart';

class ItemCard extends StatelessWidget {
  final OrderItem item;

  ItemCard(this.item);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        title: Text(
          item.item.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        isThreeLine: true,
        subtitle: Text(
          'Anzahl: ' +
              item.quantity.toString() +
              '\n' +
              'Einzelpreis: € ' +
              item.item.price.toStringAsFixed(2),
        ),
        trailing: Text(
          '€ ' + (item.quantity * item.item.price).toStringAsFixed(2),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
