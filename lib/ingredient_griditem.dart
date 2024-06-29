import 'package:flutter/material.dart';
import 'package:mobile_chef/ingredient.dart';

class IngredientGridItem extends StatelessWidget {
  final Ingredient ingredient;
  final bool isSelected;
  final Function(bool, Ingredient) onSelected;

  const IngredientGridItem({
    Key? key,
    required this.ingredient,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelected(!isSelected, ingredient);
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: ingredient.gradientColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.grey,
            width: 2.0,
          ),
        ),
        child: Center(
          child: Text(
            ingredient.title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
