import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telestat_test/src/models/trip/trip.dart';

final List<Trip> trips = [
  Trip(
    title: 'Holiday',
    description: 'Hollidays in Kyiv and meeting with friends there',
    departurePlace: 'Kamianske',
    arrivalPlace: 'Kyiv',
    date: DateTime.now(),
  ),
  Trip(
    title: 'Work adventure',
    description: 'Meeting with partners in Lviv',
    departurePlace: 'Kamianske',
    arrivalPlace: 'Lviv',
    date: DateTime.now(),
  ),
  Trip(
    title: 'A walk with a dog',
    description: 'A walk with a dog in the park near the house',
    departurePlace: 'Home',
    arrivalPlace: 'Park',
    date: DateTime.now(),
  ),
];

class TripsNotifier extends StateNotifier<List<Trip>> {
  TripsNotifier() : super(const []) {
    _loadTrips();
  }

  SharedPreferences? prefs;

  void _loadTrips() async {
    prefs = await SharedPreferences.getInstance();
    final List<String>? sharedTrips = prefs!.getStringList('trips');
    
    if (sharedTrips == null) {
      state = trips;
      var stringTrips = state.map((e) => e.toJson()).toList();
      prefs!.setStringList('trips', stringTrips);
    } else {
      state = sharedTrips.map((e) => Trip.fromJson(e)).toList();
    }
  }

  void addTrip(Trip trip) {
    final newPlace = Trip(
      title: trip.title,
      description: trip.description,
      departurePlace: trip.departurePlace,
      arrivalPlace: trip.arrivalPlace,
      date: trip.date,
    );

    prefs!.setStringList('trips', [...state, newPlace].map((e) => e.toJson()).toList());
    state = [newPlace, ...state];
  }

  void editTrip(Trip trip) {
    state = state.map((e) {
      if (e.id == trip.id) {
        return trip;
      }
      return e;
    }).toList();
    prefs!.setStringList('trips', state.map((e) => e.toJson()).toList());
  }

  void deleteTrip(Trip trip) {
    state = state.where((element) => element.id != trip.id).toList();
    prefs!.setStringList('trips', state.map((e) => e.toJson()).toList());
  }
}

final tripsProvider = StateNotifierProvider<TripsNotifier, List<Trip>>(
  (ref) => TripsNotifier(),
);
