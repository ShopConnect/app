import 'package:flutter/material.dart';
import 'package:shopconnect/models/user.dart';
import 'package:shopconnect/widgets/ordercard.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meine Einkaufslisten'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Aktualisieren',
            onPressed: () => _refreshIndicatorKey.currentState.show(),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () async {
            await User.loadOrders();
            setState(() {
              User.ownedOrders = User.ownedOrders;
            });
          },
          child: ListView.builder(
            itemCount: 17,
            itemBuilder: (BuildContext context, int index) {
              return OrderCard(User.ownedOrders[index]);
            },
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        child: FloatingActionButton(
          onPressed: null,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
