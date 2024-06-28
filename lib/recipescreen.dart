import 'package:flutter/material.dart';
import 'package:mobile_chef/recipe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tts/flutter_tts.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  bool isFavorited = false;
  late FlutterTts flutterTts;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
    flutterTts = FlutterTts();
  }

  Future<void> _loadFavoriteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorited = prefs.getBool(widget.recipe.name) ?? false;
    });
  }

  Future<void> _toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorited = !isFavorited;
      widget.recipe.isFavorite = isFavorited;
    });
    prefs.setBool(widget.recipe.name, isFavorited);
  }

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
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
        title: Text("Recipe Screen"),
        actions: [
          IconButton(
            icon: Icon(
              isFavorited ? Icons.favorite : Icons.favorite_border,
              color: isFavorited ? const Color.fromARGB(255, 216, 20, 6) : Colors.white,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/ingredient.png'), 
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      widget.recipe.imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text(
                        "Ingredients:",
                        style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Colors.white),
                      ),
                      IconButton(
                        icon: const Icon(Icons.volume_up, color: Colors.white),
                        onPressed: () {
                          _speak("Ingredients: " + widget.recipe.ingredients.join(",")+",,,Instructions: " + widget.recipe.instructions);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  for (var ingredient in widget.recipe.ingredients)
                    Text(
                      "- $ingredient",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                    ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text(
                        "Instructions:",
                        style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Colors.white),
                      ),
                      
                      
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    widget.recipe.instructions,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
