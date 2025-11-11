import 'package:flutter/material.dart';
import 'package:nibit/pages/discover_page.dart';
import 'package:nibit/pages/homepage.dart';
import 'package:nibit/pages/wallet_page.dart';

// import 'package:nibit/utils/reusables/stylings.dart';

import '../reusables/stylings.dart';
import 'favorites_page.dart';

class NavPage extends StatefulWidget {
   NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int _currentIndex = 0;
 
  List<Widget> pages = [HomePage(), DiscoverPage(),FavoritesPage(), WalletPage()];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: pages.elementAt(_currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedLabelStyle: TextStyle(color: Colors.black),
          selectedLabelStyle: TextStyle(color: Colors.amber),
          currentIndex: _currentIndex,
            onTap: (int value){setState(() {
              _currentIndex = value;
              
            });},
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home,color:  Colors.grey,), activeIcon: Icon(Icons.home, color: Stylings.yellow, size: 35,) ,label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.compass_calibration_outlined, color:  Colors.grey),activeIcon: Icon(Icons.compass_calibration_outlined, color: Stylings.yellow,size: 35), label: 'Discover'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite_border, color:  Colors.grey),activeIcon: Icon(Icons.favorite_border, color: Stylings.yellow,size: 35), label: 'Favorites'),
              BottomNavigationBarItem(icon: Icon(Icons.wallet_outlined, color:  Colors.grey),activeIcon: Icon(Icons.wallet_outlined, color: Stylings.yellow,size: 35), label: 'Wallet')
            ]),

      ),
    );
  }
}
