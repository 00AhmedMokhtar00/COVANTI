import 'package:flutter/material.dart';

import '../widgets/title.dart';
import '../shop_tabs/all.dart';
import '../shop_tabs/supermarkets.dart';
import '../shop_tabs/pharmacies.dart';
import '../widgets/ctab.dart';

class Shops extends StatefulWidget {

  @override
  _ShopsState createState() => _ShopsState();
}

class _ShopsState extends State<Shops> with TickerProviderStateMixin{
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
  }


  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
      CTitle('Shops'),
      TabBar(
        isScrollable: false,
        controller: _tabController,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.blue,
        indicatorColor: Colors.transparent,

        onTap: (idx) {
          setState(() {
            _tabController.index = idx;
          });
        },
        tabs: [
          Tab(child: CTab(title: 'All',color: _tabController.index == 0? Colors.blue: Colors.white,)),
          Tab(child: CTab(title: 'Pharmacies',color: _tabController.index == 1? Colors.blue: Colors.white)),
          Tab(child: CTab(title: 'Supermarkets',color: _tabController.index == 2? Colors.blue: Colors.white)),
        ],
      ),
      Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [All(), Pharmacies(), SuperMarkets()],
        ),
      ),
    ]);
  }
}
