import 'package:flutter/material.dart';

import 'package:first_app/gradient_container.dart';

const List<Color> colors = [
  Color.fromARGB(255, 238, 186, 103),
  Color.fromARGB(190, 5, 240, 111),
];

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer(
          colors,
        ),
      ),
    ),
  );
}
