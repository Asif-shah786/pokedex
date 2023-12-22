import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/pokemon_model.dart';

class PokeApiRepository {
  final String baseUrl = 'https://pokeapi.co/api/v2';


  Future<List<Pokemon>> fetchPokemons() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/pokemon'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data != null && data['results'] != null) {
          final List<dynamic> results = data['results'];

          List<Pokemon> pokemons = results.map((result) {
            return Pokemon(
              name: result['name'] ?? '', // Retrieve the name attribute from the result
              url: result['url'] ?? '', // Retrieve the url attribute from the result
            );
          }).toList();
          print('Pokemons Length : ${pokemons.length}');

          return pokemons;
        } else {
          throw Exception('Invalid data format: results field is null');
        }
      } else {
        throw Exception('Failed to fetch pokemons. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch pokemons: $e');
    }
  }


}
