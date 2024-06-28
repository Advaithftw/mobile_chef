import 'package:flutter/material.dart';

class Ingredient {
  final String id;
  final String title;
  final List<Color> gradientColors; 

  const Ingredient({
    required this.id,
    required this.title,
    required this.gradientColors, 
  });
}
