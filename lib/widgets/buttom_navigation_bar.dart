import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../localization/keys.dart';
import '../prefs/pref_manager.dart';


class CButtomNavigationBar extends StatelessWidget {
  CButtomNavigationBar({this.onSelect, this.index, this.context});
  final Function onSelect;
  final int index;
  final BuildContext context;

  @override
  Widget build(BuildContext ctx) {
    return Container(

      margin: const EdgeInsets.only(bottom: 30,left: 20, right: 20, top: 30),
      width: double.infinity,
      height: 65,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(color: Colors.grey,blurRadius: 10),
          ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (idx) {onSelect(idx);}, // new
          currentIndex: index, // new
          selectedItemColor: Theme.of(context).primaryColor,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.homeOutline, ),
              title: Text(PrefManager.tr(context, LocKeys.HOME_TITLE)),
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.compassOutline,),
              title: Text(PrefManager.tr(context, LocKeys.MAP_TITLE)),
            ),
//            const BottomNavigationBarItem(
//              icon: Icon(MdiIcons.cartOutline,),
//              title: Text('Shops'),
//            ),
            BottomNavigationBarItem(
                icon: Icon(MdiIcons.textBoxMultipleOutline,),
                title: Text(PrefManager.tr(context, LocKeys.NEWS_TITLE))
            )
          ],
        ),
      ),
    );
  }
}

