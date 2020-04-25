import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class CButtomNavigationBar extends StatelessWidget {
  final Function onSelect;
  final int index;
  CButtomNavigationBar({this.onSelect, this.index});

  @override
  Widget build(BuildContext context) {
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
            const BottomNavigationBarItem(
              icon: Icon(MdiIcons.homeOutline, ),
              title: Text('Home',),
            ),
            const BottomNavigationBarItem(
              icon: Icon(MdiIcons.compassOutline,),
              title: Text('Maps'),
            ),
            const BottomNavigationBarItem(
              icon: Icon(MdiIcons.cartOutline,),
              title: Text('Shops'),
            ),
            const BottomNavigationBarItem(
                icon: Icon(MdiIcons.textBoxMultipleOutline,),
                title: Text('News')
            )
          ],
        ),
      ),
    );
  }
}

/*
*
*
*
*
* */