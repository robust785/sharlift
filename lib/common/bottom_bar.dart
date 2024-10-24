import 'package:flutter/material.dart';

import 'package:badges/badges.dart' as badges;
import 'package:sharlift/features/cart%20tab/screens/cart_page.dart';

import 'package:sharlift/features/home/screens/home_screen.dart';
import 'package:sharlift/features/lifts%20posted%20tab/screen/lift_posted.dart';
import 'package:sharlift/features/request%20page%20tab/screens/request_page.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/bottom-nav-bar';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  List<Widget> pages = [
    const HomeScreen(),
    const RequestPage(),
    const LiftPosted(),
    const CartPage(),
  ];
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;
  void setPage(int p) {
    setState(() {
      _page = p;
      debugPrint("Current Page Index: $_page");
    });
  }

  @override
  void initState() {
    super.initState();
    debugPrint("inside bt nav bar");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        // elevation: 5,

        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        onTap: setPage,
        currentIndex: _page,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        // backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: SizedBox(
              width: bottomBarWidth,
              child: const Icon(Icons.home_outlined),
            ),
          ),
          BottomNavigationBarItem(
            label: "Requests",
            icon: SizedBox(
              width: bottomBarWidth,
              child: const Icon(Icons.transfer_within_a_station_outlined),
            ),
          ),
          BottomNavigationBarItem(
            label: "Lifts Posted",
            icon: SizedBox(
              width: bottomBarWidth,
              child: const Icon(Icons.person_outline_outlined),
            ),
          ),
          BottomNavigationBarItem(
            label: "Purchase",
            icon: SizedBox(
              width: bottomBarWidth,
              child: const badges.Badge(
                  badgeContent: Text(
                    '3',
                    style: TextStyle(color: Colors.white),
                  ),
                  badgeStyle: badges.BadgeStyle(
                      badgeColor: Color.fromARGB(255, 0, 0, 0),
                      elevation: 4,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Icon(Icons.shopping_cart_outlined)),
            ),
          ),
        ],
      ),
      body: pages[_page],
    );
  }
}
