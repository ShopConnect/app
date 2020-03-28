import 'package:flutter/material.dart';
import 'package:shopconnect/enums/myordernavigation.dart';
import 'package:shopconnect/widgets/myordernavigationbutton.dart';
import 'package:shopconnect/widgets/profilebutton.dart';
// import 'package:shopconnect/pages/main/myorders/myorders.dart';
// import 'package:shopconnect/pages/main/orders/orders.dart';
// import 'package:shopconnect/pages/main/settings/settings.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ProfileButton> _profileButtons = [
    ProfileButton(icon: Icons.list, label: 'Meine Aufträge'),
    ProfileButton(icon: Icons.message, label: 'Nachrichten'),
    ProfileButton(icon: Icons.people, label: 'Kontakte'),
    ProfileButton(icon: Icons.zoom_in, label: 'Aufträge finden'),
    ProfileButton(icon: Icons.settings, label: 'Einstellungen'),
    ProfileButton(icon: Icons.tag_faces, label: 'Ranking'),
  ];

  MyOrderNavigation _selectedMyOrderNavigationButton = MyOrderNavigation.Active;

  void _selectMyOrderNavigationButton(MyOrderNavigation selected) {
    if (mounted) {
      setState(() {
        _selectedMyOrderNavigationButton = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Maik Zimmermann'),
              centerTitle: true,
              background: Image(
                alignment: Alignment.topCenter,
                image: AssetImage('assets/images/avatar.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(15.0),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return _profileButtons[index];
                },
                childCount: 6,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 2,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MyOrderNavigationButton(
                  MyOrderNavigation.Active,
                  onPressed: _selectMyOrderNavigationButton,
                  selected: _selectedMyOrderNavigationButton ==
                      MyOrderNavigation.Active,
                ),
                MyOrderNavigationButton(
                  MyOrderNavigation.Finished,
                  onPressed: _selectMyOrderNavigationButton,
                  selected: _selectedMyOrderNavigationButton ==
                      MyOrderNavigation.Finished,
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
