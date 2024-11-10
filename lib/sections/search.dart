import 'package:flutter/material.dart';
import '../models/drink.dart';
import '../services/api_service.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _controller = TextEditingController();
  Future<List<Drink>>? _futureDrinks;

  void _searchDrinks() {
    setState(() {
      _futureDrinks = ApiService().searchDrinksByName(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('¡Busca tu coctel!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Buscar por nombre',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _searchDrinks,
                ),
              ),
              onSubmitted: (value) => _searchDrinks(),
            ),
            const SizedBox(height: 20),
            _futureDrinks == null
                ? const Text('Encuentra tu bebida favorita en el mejor catálogo más completo')
                : FutureBuilder<List<Drink>>(
                    future: _futureDrinks,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No se encontraron bebidas'));
                      } else {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final drink = snapshot.data![index];
                              return ListTile(
                                leading: Image.network(drink.strDrinkThumb),
                                title: Text(drink.strDrink),
                              );
                            },
                          ),
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
