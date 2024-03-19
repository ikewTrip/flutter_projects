import 'package:favourite_places/models/place.dart';
import 'package:flutter/material.dart';

class DetailedPlaceScreen extends StatelessWidget {
  const DetailedPlaceScreen({super.key, required this.place});

  final Place place;

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ],
      ),
    );
  }
}
