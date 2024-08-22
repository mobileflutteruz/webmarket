import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatelessWidget {
  final Map<String, String> locale;

  AboutPage({required this.locale});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale['about_page']!,
          style: GoogleFonts.roboto(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            SizedBox(height: 20),
            Center(
              child: Text(
                locale['share_setup'] ?? 'Share your setup with',
                style: GoogleFonts.roboto(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Text(
                '#AboutUs',
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: MediaQuery.of(context).size.height * 0.4, // Adjusted container height
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildImageContainer(context, 'assets/images/77.jpg'),
                  _buildImageContainer(context, 'assets/images/66.jpg'),
                ],
              ),
              
            ),
                SizedBox(height: 20),
             Text(
              locale['about_us_title'] ?? 'Biz haqimizda',
              style: GoogleFonts.roboto(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              locale['about_us_content'] ?? 'Bizning kompaniya haqida qisqacha ma\'lumot...',
              style: GoogleFonts.roboto(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            SizedBox(height: 20),
            Text(
              locale['our_mission_title'] ?? 'Bizning maqsadimiz',
              style: GoogleFonts.roboto(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              locale['our_mission_content'] ?? 'Bizning asosiy maqsadimiz va missiyamiz...',
              style: GoogleFonts.roboto(
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageContainer(BuildContext context, String asset) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4, // Adjusted image width
      height: MediaQuery.of(context).size.height * 0.6, // Adjusted image height
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          asset,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
