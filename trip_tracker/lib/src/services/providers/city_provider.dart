import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:telestat_test/src/services/location_service.dart';

final cityProvider = FutureProvider.autoDispose<String>((ref) async {
  var currentLocation =
      await ref.watch(locationServiceProvider).getCurrentLocation();

  try {
    var placemarks = await placemarkFromCoordinates(
        currentLocation!.latitude, currentLocation.longitude);

    var placemark = placemarks[0];
    var adress = '${placemark.street}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}';

    return adress;
  } catch (e) {
    return 'Your current location';
  }
});
