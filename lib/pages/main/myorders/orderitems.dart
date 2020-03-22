import 'package:flutter/material.dart';
import 'package:shopconnect/models/order.dart';
import 'package:shopconnect/widgets/itemcard.dart';

class OrderItems extends StatefulWidget {
  final Order order;

  OrderItems(this.order);

  @override
  _OrderItemsState createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Name',
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ItemCard(widget.order.items[index]);
          },
          itemCount: widget.order.items.isEmpty ? 0 : widget.order.items.length,
        ),
      ),
    );
  }
}
