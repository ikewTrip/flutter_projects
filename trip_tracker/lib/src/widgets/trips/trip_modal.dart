import 'package:flutter/material.dart';
import 'package:telestat_test/src/models/trip/trip.dart';

class TripModal extends StatefulWidget {
  const TripModal({super.key, this.trip});

  final Trip? trip;

  @override
  State<TripModal> createState() => _TripModalState();
}

class _TripModalState extends State<TripModal> {
  final _formKey = GlobalKey<FormState>();

  var _enteredTitle = '';
  var _enteredDescription = '';
  var _enteredDeparturePlace = '';
  var _enteredArrivalPlace = '';
  DateTime? _enteredDate;

  @override
  void initState() {
    if (widget.trip != null) {
      _enteredTitle = widget.trip!.title;
      _enteredDescription = widget.trip!.description;
      _enteredDeparturePlace = widget.trip!.departurePlace;
      _enteredArrivalPlace = widget.trip!.arrivalPlace;
      _enteredDate = widget.trip!.date;
    }
    super.initState();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year + 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: lastDate);
    setState(() {
      _enteredDate = pickedDate;
    });
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.trip == null ? 'Add Trip' : 'Edit Trip',
            style: Theme.of(context).textTheme.titleMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: _enteredTitle,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _enteredTitle = value!;
                  },
                ),
                TextFormField(
                  initialValue: _enteredDescription,
                  decoration: const InputDecoration(labelText: 'Description'),
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _enteredDescription = value!;
                  },
                ),
                TextFormField(
                  initialValue: _enteredDeparturePlace,
                  decoration:
                      const InputDecoration(labelText: 'Departure Place'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).nextFocus();
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a departure place';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _enteredDeparturePlace = value!;
                  },
                ),
                TextFormField(
                  initialValue: _enteredArrivalPlace,
                  decoration: const InputDecoration(labelText: 'Arrival Place'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an arrival place';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _enteredArrivalPlace = value!;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      _enteredDate == null
                          ? 'No date selected'
                          : formatter.format(_enteredDate!),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      if (widget.trip == null) {
                        final newTrip = Trip(
                          title: _enteredTitle,
                          description: _enteredDescription,
                          departurePlace: _enteredDeparturePlace,
                          arrivalPlace: _enteredArrivalPlace,
                          date: _enteredDate!,
                        );
                        Navigator.of(context).pop(newTrip);
                      } else {
                        widget.trip!.title = _enteredTitle;
                        widget.trip!.description = _enteredDescription;
                        widget.trip!.departurePlace = _enteredDeparturePlace;
                        widget.trip!.arrivalPlace = _enteredArrivalPlace;
                        widget.trip!.date = _enteredDate!;
                        Navigator.of(context).pop(widget.trip);
                      }
                    }
                  },
                  child: Text(widget.trip == null ? 'Add Trip' : 'Edit Trip'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
