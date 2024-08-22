class AppLatLong {
  final double lat;
  final double long;

  const AppLatLong({required this.lat, required this.long});
}

class MoscowLocation extends AppLatLong {
  const MoscowLocation({
    super.lat = 55,
    super.long = 37,
  });
}
