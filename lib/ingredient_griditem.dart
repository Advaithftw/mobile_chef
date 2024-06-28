import 'package:flutter/material.dart';
import 'package:mobile_chef/ingredient.dart';

class IngredientGridItem extends StatefulWidget {
  final Ingredient ingredient;
  final Function(bool, Ingredient) onSelected;

  const IngredientGridItem({
    Key? key,
    required this.ingredient,
    required this.onSelected,
  }) : super(key: key);

  @override
  _IngredientGridItemState createState() => _IngredientGridItemState();
}

class _IngredientGridItemState extends State<IngredientGridItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        widget.onSelected(isSelected, widget.ingredient);
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.ingredient.gradientColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          border: Border.all(
            color: isSelected ? const Color.fromARGB(255, 0, 0, 0) : Colors.transparent,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.ingredient.title,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            Checkbox(
              value: isSelected,
              onChanged: (bool? value) {
                setState(() {
                  isSelected = value ?? false;
                });
                widget.onSelected(isSelected, widget.ingredient);
              },
            ),
          ],
        ),
      ),
    );
  }
}
