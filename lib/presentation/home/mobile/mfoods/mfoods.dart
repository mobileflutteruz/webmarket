import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MFoodsPage extends StatefulWidget {
  const MFoodsPage({super.key});

  @override
  State<MFoodsPage> createState() => _MFoodsPageState();
}

class _MFoodsPageState extends State<MFoodsPage> {
  List<String> imageUrls = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  Future<void> fetchImages() async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      ListResult result = await storage.ref().listAll();
      List<String> urls = await Future.wait(result.items.map((ref) => ref.getDownloadURL()).toList());
      setState(() {
        imageUrls = urls;
        isLoading = false;
      });
    } catch (e) {
      print('Failed to load images: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Foods'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(
                           imageUrls[index],
                          // placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                          // errorWidget: (context, url, error) => const Icon(Icons.error),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Image $index',
                          style: GoogleFonts.manrope(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
