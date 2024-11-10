import 'package:flutter/material.dart';
import '../models/drink.dart';
import '../services/api_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Drink>> futureOrdinaryDrinks;
  late Future<List<Drink>> futureCocktails;

  @override
  void initState() {
    super.initState();
    futureOrdinaryDrinks = ApiService().fetchDrinksByCategory('Ordinary_Drink');
    futureCocktails = ApiService().fetchDrinksByCategory('Cocktail');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text('Bebidas Normales', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            FutureBuilder<List<Drink>>(
              future: futureOrdinaryDrinks,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No se encontraron las bebidas'));
                } else {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final drink = snapshot.data![index];
                      return Card(
                        child: Column(
                          children: [
                            Expanded(
                              child: Image.network(drink.strDrinkThumb, fit: BoxFit.cover),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(drink.strDrink, textAlign: TextAlign.center),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            const Text('Cocteles', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            FutureBuilder<List<Drink>>(
              future: futureCocktails,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No se encontraron las bebidas'));
                } else {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final drink = snapshot.data![index];
                      return Card(
                        child: Column(
                          children: [
                            Expanded(
                              child: Image.network(drink.strDrinkThumb, fit: BoxFit.cover),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(drink.strDrink, textAlign: TextAlign.center),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
