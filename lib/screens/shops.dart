import 'package:flutter/material.dart';

import '../widgets/title.dart';
import 'shop_tabs/all.dart';
import 'shop_tabs/supermarkets.dart';
import 'shop_tabs/pharmacies.dart';
import '../widgets/ctab.dart';

class Shops extends StatefulWidget {
  static const String routeName = "Shops";
  @override
  _ShopsState createState() => _ShopsState();
}

class _ShopsState extends State<Shops> with TickerProviderStateMixin{
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }


  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
        CTitle('Shops'),
        TabBar(
          isScrollable: false,
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Theme.of(context).primaryColor,
          indicatorColor: Colors.transparent,
          onTap: (idx) {
            setState(() {
              _tabController.index = idx;
            });
          },
          tabs: [
            Tab(child: CTab(title: 'All',color: _tabController.index == 0? Theme.of(context).primaryColor: Colors.white,)),
            Tab(child: CTab(title: 'Pharmacies',color: _tabController.index == 1? Theme.of(context).primaryColor: Colors.white)),
            Tab(child: CTab(title: 'Supermarkets',color: _tabController.index == 2? Theme.of(context).primaryColor: Colors.white)),
          ],
        ),
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.8,
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [All(), Pharmacies(), SuperMarkets()],
          ),
        ),
        SizedBox(height: 120,)
      ]),
    );
  }
}
