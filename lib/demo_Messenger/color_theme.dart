import 'package:flutter/material.dart';

class ColorProvider {
  // Method that returns a color based on some condition or input
  Color getColor(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      case 'pink':
        return Colors.pinkAccent;
      case 'green':
        return Colors.greenAccent;
      case 'yellow':
        return Colors.blueAccent;
      case 'orange':
        return Colors.orangeAccent;
      case 'red':
        return Colors.redAccent;
      default:
        return Colors.grey; // Default color if no match is found
    }
  }
}