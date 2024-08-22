import 'package:flutter/material.dart';
import 'package:web_shop/presentation/home/mobile/mfoods/mfoods.dart';
import 'package:web_shop/presentation/home/mobile/mhome/mhome_page.dart';
import 'package:web_shop/presentation/home/mobile/my_account/mmy_account_page.dart';
import 'package:web_shop/presentation/home/mobile/my_cart/mmy_cart_page.dart';

class BottomNavBar extends StatefulWidget {
  final int initialIndex;
  const BottomNavBar({super.key, required this.initialIndex});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        _navigateToRoute(context, MHomePage());
        break;
      case 1:
        _navigateToRoute(context, MFoodsPage());
        break;
      case 2:
        _navigateToRoute(context, MMyAccountPage());
        break;
      case 3:
        _navigateToRoute(context, MMyCartPage());
        break;
    }
  }

  void _navigateToRoute(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      type: BottomNavigationBarType.fixed,
      onTap: _onItemTapped,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.black,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_max_outlined,
              color: _selectedIndex == 0 ? Colors.green : Colors.black),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.food_bank_outlined,
              color: _selectedIndex == 1 ? Colors.green : Colors.black),
          label: 'Foods',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_2_outlined,
              color: _selectedIndex == 2 ? Colors.green : Colors.black),
          label: "My Account",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag_outlined,
              color: _selectedIndex == 3 ? Colors.green : Colors.black),
          label: 'My Cart',
        ),
      ],
    );
  }
}
