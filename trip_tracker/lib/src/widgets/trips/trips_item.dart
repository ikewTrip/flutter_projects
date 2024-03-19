import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:telestat_test/src/models/trip/trip.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:telestat_test/src/services/providers/trip_provider.dart';
import 'package:telestat_test/src/widgets/trips/trip_modal.dart';

class TripsItem extends ConsumerWidget {
  final Trip trip;

  const TripsItem({
    super.key,
    required this.trip,
  });

  void _showEditModal(BuildContext context, Trip trip, WidgetRef ref) async {
    var modalTrip = await showModalBottomSheet<Trip>(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return TripModal(trip: trip);
      },
    );

    if (modalTrip != null) {
      ref.read(tripsProvider.notifier).editTrip(modalTrip);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (ctx) {
              _showEditModal(context, trip, ref);
            },
            icon: Icons.edit,
            label: 'Edit',
          ),
          SlidableAction(
            onPressed: (ctx) {
              ref.read(tripsProvider.notifier).deleteTrip(trip);
            },
            icon: Icons.delete,
            backgroundColor: Colors.red,
            label: 'Delete',
          ),
        ],
      ),
      child: Card(
        child: ListTile(
          onTap: () {},
          leading: SizedBox(
            width: 80,
            child: Text(
              trip.title,
              style: Theme.of(context).textTheme.bodyMedium,
              softWrap: true,
            ),
          ),
          title: Text(
            '${trip.departurePlace} - ${trip.arrivalPlace}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Text(trip.description),
          trailing: Text(trip.formatedDate),
        ),
      ),
    );
  }
}
