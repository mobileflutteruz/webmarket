import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  final String id;
  final String title;
  final String pricing;
  final String imageUrl;
  final String description;

  CartItem({
    required this.id,
    required this.title,
    required this.pricing,
    required this.imageUrl,
    required this.description,
  });

  factory CartItem.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return CartItem(
      id: doc.id,
      title: data['title'] ?? '',
      pricing: data['pricing'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      description: data['description'] ?? '',
    );
  }
}
