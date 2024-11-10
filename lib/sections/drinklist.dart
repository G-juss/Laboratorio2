import 'package:cocteles/sections/drinkdetails.dart';
import 'package:flutter/material.dart';
import '../models/drink.dart';
import '../services/api_service.dart';

class DrinkList extends StatefulWidget {
  const DrinkList({super.key});

  @override
  _DrinkListState createState() => _DrinkListState();
}

class _DrinkListState extends State<DrinkList> {
  late Future<List<Drink>> futureDrinks;

  @override
  void initState() {
    super.initState();
    futureDrinks = ApiService().fetchDrinksByFirstLetter('a');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Drinks'),
      ),
      body: FutureBuilder<List<Drink>>(
        future: futureDrinks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No drinks found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final drink = snapshot.data![index];
                return ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DrinkDetails(
                      image: drink.strDrinkThumb,
                      text: drink.strDrink)));
                  },
                  leading: Image.network(drink.strDrinkThumb),
                  title: Text(drink.strDrink),
                );
              },
            );
          }
        },
      ),
    );
  }
}
