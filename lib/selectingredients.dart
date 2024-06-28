import 'package:flutter/foundation.dart';

class SelectedIngredientsProvider with ChangeNotifier {
  final List<String> _selectedIngredients = [];

  List<String> get selectedIngredients => _selectedIngredients;

  void toggleIngredient(String ingredient) {
    if (_selectedIngredients.contains(ingredient)) {
      _selectedIngredients.remove(ingredient);
    } else {
      _selectedIngredients.add(ingredient);
    }
    notifyListeners();
  }
}
