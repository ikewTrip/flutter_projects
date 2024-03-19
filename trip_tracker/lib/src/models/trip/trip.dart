import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuud = Uuid();
final formatter = DateFormat.yMd();

class Trip {
  Trip(
      {required this.title,
      required this.description,
      required this.departurePlace,
      required this.arrivalPlace,
      required this.date,
      id})
      : id = id ?? uuud.v4();

  final String id;
  String title;
  String description;
  String departurePlace;
  String arrivalPlace;
  DateTime date;

  String get formatedDate {
    return formatter.format(date);
  }

  String toJson() {
    return json.encode({
      'id': id,
      'title': title,
      'description': description,
      'departurePlace': departurePlace,
      'arrivalPlace': arrivalPlace,
      'date': date.toIso8601String(),
    });
  }

  static Trip fromJson(String jsonString) {
    final Map<String, dynamic> map = json.decode(jsonString);
    return Trip(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      departurePlace: map['departurePlace'],
      arrivalPlace: map['arrivalPlace'],
      date: DateTime.parse(map['date']),
    );
  }
}
