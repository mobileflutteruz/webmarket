import 'package:flutter/material.dart';
import 'package:web_shop/presentation/home/mobile/home_page_mobile.dart';
import 'package:web_shop/presentation/home/web/whome/home_page_web.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Check the platform and screen size
    final bool isWeb = MediaQuery.of(context).size.width > 500;
    return isWeb ? HomeScreenWeb() : HomeScreenMobile();
  }
}
