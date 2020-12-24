import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../tools/bottom_navigation_bar_provider.dart';

class MyBottomNavigationBar extends StatelessWidget {
  @override
  const MyBottomNavigationBar({
    Key key,
    @required this.onTapped,
  }) : super(key: key);
  final Function onTapped;

  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.black54,

      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Inicio')),
        BottomNavigationBarItem(
            icon: Icon(Icons.trending_up), title: Text('Evolución')),
        BottomNavigationBarItem(
            icon: Icon(Icons.assessment), title: Text('Proyección')),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings), title: Text('Ajustes')),
//            BottomNavigationBarItem(
//                icon: Icon(Icons.compare_arrows), title: Text('Transactions'))
      ],
      onTap: onTapped,
      currentIndex:
          Provider.of<BottomNavigationBarProvider>(context).currentIndex,
    );
  }
}