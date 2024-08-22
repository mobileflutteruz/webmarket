import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_shop/presentation/home/components/cartitem.dart';
import 'package:http/http.dart' as http;

class ProductDetail extends StatelessWidget {
  final CartItem cartItem;

  const ProductDetail({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cartItem.title ?? "Product Details"),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSection(cartItem),
            _buildInfoSection(cartItem),
            _buildAddToCartSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(CartItem cartItem) {
    return FutureBuilder(
      future: _checkImageUrl(cartItem.imageUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.data == false) {
          return const Center(child: Text("Error loading image"));
        } else {
          return Image.network(
            cartItem.imageUrl,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.5,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.broken_image,
                size: 50,
              );
            },
          );
        }
      },
    );
  }

  Widget _buildInfoSection(CartItem cartItem) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cartItem.title ?? "",
            style: GoogleFonts.manrope(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            cartItem.pricing ?? "",
            style: GoogleFonts.manrope(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            cartItem.description ?? "",
            style: GoogleFonts.manrope(
              fontSize: 16.0,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget _buildAddToCartSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            // Handle add to cart
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[700],
            padding: const EdgeInsets.symmetric(
              horizontal: 32.0,
              vertical: 12.0,
            ),
            textStyle: const TextStyle(
              fontSize: 16.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Text("Add to Cart"),
        ),
      ),
    );
  }

  Future<bool> _checkImageUrl(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
