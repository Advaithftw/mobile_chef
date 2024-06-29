import 'package:flutter/material.dart';
import 'package:mobile_chef/ingredient.dart';
import 'package:mobile_chef/ingredient_griditem.dart';
import 'package:mobile_chef/ingredientsdata.dart';
import 'package:mobile_chef/recipe.dart';
import 'package:mobile_chef/recipes_data.dart';
import 'package:mobile_chef/recipescreen.dart';

class IngredientsScreen extends StatefulWidget {
  const IngredientsScreen({Key? key}) : super(key: key);

  @override
  _IngredientsScreenState createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> {
  final Set<String> selectedIngredientIds = {};

  void _onIngredientSelected(bool selected, Ingredient ingredient) {
    setState(() {
      if (selected) {
        selectedIngredientIds.add(ingredient.id);
      } else {
        selectedIngredientIds.remove(ingredient.id);
      }
    });
  }

  void _showRecipes() {
    List<String> selectedIngredientNames = availableIngredients
        .where((ingredient) => selectedIngredientIds.contains(ingredient.id))
        .map((ingredient) => ingredient.title)
        .toList();

    List<Recipe> recipes = getRecipes(selectedIngredientNames);

    if (recipes.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecipeDetailScreen(
            recipe: recipes.first,
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("No Recipes Found"),
          content: Text("No recipes match the selected ingredients."),
          backgroundColor: Colors.grey,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 203, 160, 50),
                Color.fromARGB(255, 200, 98, 20),
              ],
            ),
          ),
        ),
        title: const Text("Pick Your Ingredients"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/recipe.png'), 
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 1,
                childAspectRatio: 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: availableIngredients
                    .map((ingredient) => IngredientGridItem(
                          ingredient: ingredient,
                          isSelected: selectedIngredientIds.contains(ingredient.id),
                          onSelected: _onIngredientSelected,
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 110, 104, 104),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: ElevatedButton(
                onPressed: _showRecipes,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 11, 9, 9),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Text(
                  "Get Recipes",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,color: Color.fromARGB(255, 224, 129, 14)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



List<Recipe> getRecipes(List<String> selectedIngredients) {
  List<Recipe> matchedRecipes = allRecipes.where((recipe) {
    return selectedIngredients.every(
        (ingredient) => recipe.ingredients.contains(ingredient));
  }).toList();

  return matchedRecipes;
}
