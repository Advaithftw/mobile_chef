import 'package:flutter/material.dart';
import 'package:mobile_chef/favouritesscreen.dart';
import 'package:mobile_chef/ingredients.dart';
import 'package:mobile_chef/recipes_data.dart'; 

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
        title: const Text("Home"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/homepage.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              const Spacer(flex: 2),
              Opacity(
                opacity: 0.9, 
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0), 
                  child: Image.asset(
                    'assets/image.png',
                    fit: BoxFit.contain,
                    height: 200, 
                  ),
                ),
              ),
              const Spacer(flex: 2),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const IngredientsScreen(),
                    ),
                  );
                },
                child: const Text('Select Ingredients'),
              ),
              const Spacer(flex: 1),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                     builder: (context) => Favouritesscreen(allRecipes: allRecipes), 
                    ),
                  );
                },
                child: const Text('Favourite Recipes'),
              ),
              const Spacer(flex: 5),
            ],
          ),
        ),
      ),
    );
  }
}
