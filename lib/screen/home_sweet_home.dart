import 'package:flutter/material.dart';

import 'home.dart';

class HomeSweetHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.location_city, color: Colors.grey,)),
              Tab(icon: Icon(Icons.share, color: Colors.grey,)),
              Tab(icon: Icon(Icons.directions_bike, color: Colors.grey,)),
            ],
          ),
          body: TabBarView(
              children: [
                Home(),
                Icon(Icons.directions_car),
                Icon(Icons.directions_transit),
              ],
          ),
        ),
    );
  }
}
