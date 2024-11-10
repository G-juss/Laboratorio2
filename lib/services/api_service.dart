import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/drink.dart';

class ApiService {
  static const String _baseUrl = 'https://www.thecocktaildb.com/api/json/v1/1';

  Future<List<Drink>> fetchDrinksByFirstLetter(String letter) async {
    final response = await http.get(Uri.parse('$_baseUrl/search.php?f=$letter'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['drinks'];
      return data.map((json) => Drink.fromJson(json)).toList();
    } else {
      throw Exception('No se cargaron las bebidas');
    }
  }
}
