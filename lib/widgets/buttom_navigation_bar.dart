import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class CButtomNavigationBar extends StatefulWidget {
  final Function onSelect;
  final int index;
  CButtomNavigationBar({this.onSelect, this.index});

  @override
  _CButtomNavigationBarState createState() => _CButtomNavigationBarState();
}

class _CButtomNavigationBarState extends State<CButtomNavigationBar> {
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
          onTap: (idx) {widget.onSelect(idx);}, // new
          currentIndex: widget.index, // new
          selectedItemColor: Colors.blue,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          unselectedItemColor: Colors.grey,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home, ),
              title: Text('Home',),
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.location_on,),
              title: Text('Maps'),
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart,),
              title: Text('Shops'),
            ),
            const BottomNavigationBarItem(
                icon: Icon(Icons.library_books,),
                title: Text('News')
            )
          ],
        ),
      ),
    );
  }
}

/*
* MdiIcons.homeOutline
* MdiIcons.compassOutline
* MdiIcons.cartOutline
* MdiIcons.textBoxMultipleOutline
* */