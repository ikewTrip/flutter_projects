import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:telestat_test/src/models/trip/trip.dart';
import 'package:telestat_test/src/services/providers/city_provider.dart';
import 'package:telestat_test/src/services/providers/trip_provider.dart';
import 'package:telestat_test/src/services/providers/weather_provider.dart';
import 'package:telestat_test/src/widgets/trips/trip_modal.dart';
import 'package:telestat_test/src/widgets/trips/trips_list.dart';
import 'package:telestat_test/src/widgets/weather/current_weather.dart';

class TravelTrackerScreen extends ConsumerWidget {
  const TravelTrackerScreen({super.key});

  void _showAddModal(BuildContext context, WidgetRef ref) async {
    var modalTrip = await showModalBottomSheet<Trip>(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return const TripModal();
      },
    );

    if (modalTrip != null) {
      ref.read(tripsProvider.notifier).addTrip(modalTrip);
    }
  }

  @override
  Widget build(context, ref) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    final trips = ref.watch(tripsProvider);

    var content = [
      const CurrentWeather(),
      const SizedBox(height: 20, width: 20),
      trips.isEmpty
          ? const Expanded(
              child: Center(
                child: Text(
                  'Trips ain`t added yet!',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            )
          : const Expanded(
              child: TripsList(),
            ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Tracker'),
        actions: [
          IconButton(
            onPressed: () {
              ref.refresh(currentWeatherProvider);
              ref.refresh(cityProvider);
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {
              _showAddModal(context, ref);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: height > width
            ? Column(
                children: content,
              )
            : Row(
                children: content,
              ),
      ),
    );
  }
}
