import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web_shop/presentation/admin/add_data_page.dart';

class MHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('No products found'));
          }

          final products = snapshot.data!.docs;

          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return _buildProductItem(products[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => AddDataPage()));
        },
      ),
    );
  }

  Widget _buildProductItem(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;
    final title = data['title'] as String;
    final pricing = data['pricing'].toString(); // Ensure it's a string
    final description = data['description'] ;
    final images =
        List<String>.from(data['images']); // Ensure it's a List<String>

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: images.isNotEmpty
                ? Center(
                  child: Image.network(images[0],
                      fit: BoxFit.cover),
                ) // Display the first image
                : const SizedBox.shrink(), // Handle no image case
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(pricing),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Text(description, maxLines: 2, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}
