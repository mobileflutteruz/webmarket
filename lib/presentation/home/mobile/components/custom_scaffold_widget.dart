import 'package:flutter/material.dart';
import 'package:web_shop/presentation/home/bottom_nav_bar.dart';

class CustomScaffoldWidget extends StatelessWidget {
  final Widget body;
  final bool showBottomNavBar;
  final int initialIndex;

  const CustomScaffoldWidget({
    super.key,
    required this.body,
    this.showBottomNavBar = false,
    this.initialIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar:
          showBottomNavBar ? BottomNavBar(initialIndex: initialIndex) : null,
    );
  }
}
