import 'package:geolocator/geolocator.dart';
import 'package:web_shop/domain/model/yandex_model.dart';

abstract class AppLocation {
  Future<AppLatLong> getCurrentLocation();
  Future<bool> requestPermission();
  Future<bool> checkPermission();
}

class LocationService implements AppLocation {
  final AppLatLong defLocation =
      AppLatLong(lat: 55.7558, long: 37.6173); // Moscow coordinates

  @override
  Future<AppLatLong> getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition();
      return AppLatLong(lat: position.latitude, long: position.longitude);
    } catch (e) {
      return defLocation;
    }
  }

  @override
  Future<bool> requestPermission() async {
    try {
      final permission = await Geolocator.requestPermission();
      return permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> checkPermission() async {
    try {
      final permission = await Geolocator.checkPermission();
      return permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse;
    } catch (e) {
      return false;
    }
  }
}
