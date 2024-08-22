import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:url_launcher/url_launcher.dart';
// Import for kIsWeb check if you plan to use it.
import 'package:flutter/foundation.dart';
import 'package:web_shop/presentation/home/web/map/maps.dart';

class Footer extends StatelessWidget {
  final String companyName;
  final String address;
  final String phone;
  final String email;
  final String facebookUrl;
  final String instagramUrl;
  final String twitterUrl;

  const Footer({
    Key? key,
    required this.companyName,
    required this.address,
    required this.phone,
    required this.email,
    required this.facebookUrl,
    required this.instagramUrl,
    required this.twitterUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final encodedAddress = Uri.encodeComponent(address);

    return Container(
      color: Colors.black87,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
          const SizedBox(height: 20),
          _buildNavigationLinks(context),
          const SizedBox(height: 20),
          // MyMapPage() ,
          SizedBox(height: 20),
          _buildCopyright(),
        ],
      ),
    );
  }

  Widget _buildCompanyInfo(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              companyName,
              style: _textStyle(18, FontWeight.bold, Colors.white),
            ),
            const SizedBox(height: 5),
            Text(
              address,
              style: _textStyle(14, FontWeight.normal, Colors.white70),
            ),
            Text(
              'Telefon: $phone',
              style: _textStyle(14, FontWeight.normal, Colors.white70),
            ),
            Text(
              'Email: $email',
              style: _textStyle(14, FontWeight.normal, Colors.white70),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialMediaIcons(context) {
    return Row(
      children: [
        _buildSocialMediaIcon(facebookUrl, Icons.facebook, 'Facebook', context),
        _buildSocialMediaIcon(
            instagramUrl, Icons.camera_alt, 'Instagram', context),
        _buildSocialMediaIcon(twitterUrl, Icons.telegram, 'Twitter', context),
      ],
    );
  }

  Widget _buildSocialMediaIcon(
      String url, IconData icon, String tooltip, BuildContext context) {
    return url.isNotEmpty
        ? IconButton(
            icon: Icon(icon, color: Colors.white),
            onPressed: () => _launchUrl(url, context),
            tooltip: tooltip,
          )
        : Container(); // Empty Container if no URL
  }

  Widget _buildNavigationLinks(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCompanyInfo(context),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _footerLink('Asosiy sahifa'),
            _footerLink('Mahsulotlar'),
            _footerLink('Haqida'),
            _footerLink('Bog\'lanish'),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _footerLink('Shartlar va qoidalar'),
            _footerLink('Maxfiylik siyosati'),
            _footerLink('Qo\'llab-quvvatlash'),
          ],
        ),
        _buildSocialMediaIcons(context),
      ],
    );
  }

  Widget _buildMap() {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: OSMViewer(
        controller: SimpleMapController(
          initPosition: GeoPoint(
            latitude: 47.4358055,
            longitude: 8.4737324,
          ),
          markerHome: const MarkerIcon(
            icon: Icon(Icons.home),
          ),
        ),
        zoomOption: const ZoomOption(
          initZoom: 16,
          minZoomLevel: 11,
        ),
      ),
    );
  }

  Widget _buildCopyright() {
    return Center(
      child: Text(
        '© ${DateTime.now().year} $companyName. Barcha huquqlar himoyalangan.',
        style: _textStyle(14, FontWeight.normal, Colors.white70),
      ),
    );
  }

  Widget _footerLink(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        text,
        style: _textStyle(14, FontWeight.normal, Colors.white),
      ),
    );
  }

  TextStyle _textStyle(double fontSize, FontWeight fontWeight, Color color) {
    return TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);
  }

  Future<void> _launchUrl(String url, context) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      // Inform the user about the failure
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch the URL: $url')),
      );
      print(e);
    }
  }
}
