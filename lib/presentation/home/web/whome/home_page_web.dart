import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:web_shop/presentation/admin/add_data_page.dart';
import 'package:web_shop/presentation/home/components/app_layouts.dart';
import 'package:web_shop/presentation/home/web/whome/about.dart';
import 'package:web_shop/presentation/home/web/whome/footer.dart';
import 'package:web_shop/presentation/home/web/whome/locale.dart';

class HomeScreenWeb extends StatefulWidget {
  @override
  _HomeScreenWebState createState() => _HomeScreenWebState();
}

class _HomeScreenWebState extends State<HomeScreenWeb> {
  final ScrollController _scrollController = ScrollController();
  int _selectedIndex = 0;
  Map<String, String> _currentLocale = LocaleStrings.uzbek;

  void _scrollToSection(double position) {
    _scrollController.animateTo(
      position,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    double position = MediaQuery.of(context).size.height * index;
    _scrollToSection(position);
  }

  void _changeLanguage(String lang) {
    setState(() {
      if (lang == 'UZ') {
        _currentLocale = LocaleStrings.uzbek;
      } else if (lang == 'RU') {
        _currentLocale = LocaleStrings.russian;
      }
    });
  }

  void _navigateToAboutPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AboutPage(locale: _currentLocale),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: const Size(1440, 1024),
        minTextAdapt: true,
        splitScreenMode: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Image.asset('assets/images/logo.png'), // Logo image
        ),
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNavItem(context, _currentLocale['home'] ?? 'Home', 0),
              _buildNavItem(context, _currentLocale['products'] ?? 'Products', 1),
              _buildNavItem(context, _currentLocale['about_us'] ?? 'About Us', 2),
              _buildNavItem(context, _currentLocale['contact_us'] ?? 'Contact Us', 3),
            ],
          ),
        ),
        actions: [
          DropdownButton<String>(
            icon: const Icon(Icons.language, color: Colors.black),
            items: <String>['UZ', 'RU'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) _changeLanguage(newValue);
            },
          ),
          SizedBox(width: 20.h),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            _buildHome(_currentLocale['home'] ?? 'Home', 0, Colors.white),
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: const Text(
                'Products',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildProductsSection("products", 1),
            _buildAbout(_currentLocale['about_us'] ?? 'About Us', 2, Colors.white),
            _buildFooter(_currentLocale['contact_us'] ?? 'Contact Us', 3, Colors.blue)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const AddDataPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onNavItemTapped(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                color: isSelected ? Colors.blue : Colors.black,
              ),
            ),
            if (isSelected)
              Container(
                height: 2,
                width: 20,
                color: Colors.blue,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHome(String title, int index, Color color) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: color,
      child: Stack(
        children: [
          // Background image
          Image.asset(
            "assets/images/88.png",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),

          // Text overlay
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: 300, // Text container width
                padding: const EdgeInsets.all(16),
                color: Colors.white
                    .withOpacity(0.8), // Semi-transparent background color
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _currentLocale['new_arrival'] ?? 'New Arrival',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _currentLocale['discover_our_new_collection'] ?? 'Discover Our New Collection',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _currentLocale['lorem_ipsum'] ?? 'Lorem Ipsum',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () {
                        // Button action
                      },
                      child: Text(_currentLocale['buy_now'] ?? 'Buy Now'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.amber,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(String title, int index, Color color) {
    return Container(
      color: color,
      child: const Footer(
        companyName: "Online Market",
        address: "Toshkent",
        phone: "+998901234567",
        email: "email@gmail.com",
        facebookUrl: "https://facebook.com/",
        instagramUrl: "https://instagram.com/mobilflutter",
        twitterUrl: "https://twitter.com/{username}",
      ),
    );
  }

  Widget _buildAbout(String title, int index, Color color) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: color,
      child: AboutPage(locale: _currentLocale),
    );
  }

  Widget _buildProductsSection(String title, int index) {
    int crossAxisCount = (AppLayout.getScreenWidth(context) / 200).floor();

    return Container(
      padding: EdgeInsets.all(20.w),
      color: Colors.white,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No products found'));
          }

          final products = snapshot.data!.docs;

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(10.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount == 0 || crossAxisCount == 1
                  ? 2
                  : crossAxisCount,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.75,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return _buildProductItem(products[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildProductItem(DocumentSnapshot document) {
  // Safely extract data from Firestore
  final data = document.data() as Map<String, dynamic>;
  final title = data['title'] as String? ?? 'No Title';
  final pricing = data['pricing']?.toString() ?? 'No Price';
  final description = data['description'] as String? ?? 'No Description';
  final images = data['images'] as String? ?? '';

  return FutureBuilder<String>(
    future: images.isNotEmpty 
        ? FirebaseStorage.instance.ref(images).getDownloadURL() 
        : Future.value(''),  // Return an empty URL if images is empty
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Center(
                  child: Icon(Icons.error, size: 50),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title, style: const TextStyle(fontSize: 14)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(pricing, style: const TextStyle(fontSize: 12)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        );
      } else {
        final imageUrl = snapshot.data!;
        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 150,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(Icons.error, size: 50),
                          );
                        },
                      )
                    : const SizedBox.shrink(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title, style: const TextStyle(fontSize: 14)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(pricing, style: const TextStyle(fontSize: 12)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        );
      }
    },
  );
}


}
