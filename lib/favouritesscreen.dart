import 'package:flutter/material.dart';
import 'package:mobile_chef/recipe.dart';
import 'package:mobile_chef/recipescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favouritesscreen extends StatefulWidget {
  final List<Recipe> allRecipes;

  const Favouritesscreen({super.key, required this.allRecipes});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<Favouritesscreen> {
  List<Recipe> favoriteRecipes = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteRecipes();
  }

  Future<void> _loadFavoriteRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteRecipes = widget.allRecipes.where((recipe) {
        return prefs.getBool(recipe.name) ?? false;
      }).toList();
    });
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
        title: const Text("Favorites"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0), 
        child: ListView.builder(
          itemCount: favoriteRecipes.length,
          itemBuilder: (context, index) {
            final recipe = favoriteRecipes[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0), 
              child: ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(recipe.imageUrl),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(8.0), 
                  ),
                ),
                title: Text(recipe.name),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeDetailScreen(recipe: recipe),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
