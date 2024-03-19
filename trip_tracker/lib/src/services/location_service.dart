import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Position? _currentPosition;

  Future<bool> _handlePermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {return false;
      }
    }

    return true;
  }

  Future<Position?> getCurrentLocation() async{
    _handlePermission();

    try {
      _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
    } catch (e) {
      print('Error: ${e.toString()}');
    }

    return _currentPosition;
  }
}

final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService();
});