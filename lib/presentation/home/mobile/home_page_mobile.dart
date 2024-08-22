import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_shop/presentation/home/mobile/mfoods/mfoods.dart';
import 'package:web_shop/presentation/home/mobile/mhome/mhome_page.dart';
import 'package:web_shop/presentation/home/mobile/my_account/mmy_account_page.dart';
import 'package:web_shop/presentation/home/mobile/my_cart/mmy_cart_page.dart';

export 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreenMobile extends StatefulWidget {
  @override
  _HomeScreenMobileState createState() => _HomeScreenMobileState();
}

class _HomeScreenMobileState extends State<HomeScreenMobile> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'My App',
          style: GoogleFonts.roboto(
            fontSize: 18.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(Icons.menu, color: Colors.black),
            onSelected: (int index) {
              _onNavItemTapped(index);
            },
            itemBuilder: (BuildContext context) {
              return [
                _buildPopupMenuItem('Home', 0),
                _buildPopupMenuItem('Foods', 1),
                _buildPopupMenuItem('My Account', 2),
                _buildPopupMenuItem('My Cart', 3),
              ];
            },
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          MHomePage(),
          MFoodsPage(),
          MMyAccountPage(),
          MMyCartPage(),
        ],
      ),
    );
  }

  PopupMenuItem<int> _buildPopupMenuItem(String label, int index) {
    bool isSelected = _selectedIndex == index;
    return PopupMenuItem<int>(
      value: index,
      child: Text(
        label,
        style: GoogleFonts.roboto(
          fontSize: 14.sp,
          color: isSelected ? Colors.blue : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
