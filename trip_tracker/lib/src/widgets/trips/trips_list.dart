import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:telestat_test/src/services/providers/trip_provider.dart';
import 'package:telestat_test/src/widgets/trips/trips_item.dart';

class TripsList extends ConsumerWidget {
  const TripsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trips = ref.watch(tripsProvider);

    return ListView.builder(
      itemCount: trips.length,
      itemBuilder: (context, index) {
        return TripsItem(trip: trips[index]);
      },
    );
  }
}
