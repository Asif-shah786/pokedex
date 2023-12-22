import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/pokemon_model.dart';
import '../repositories/pokemon_repository.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (BuildContext context) => HomeScreen(),
    );
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Pokemon> _pokemons;
  late List<int> _favoriteIds;

  @override
  void initState() {
    super.initState();
    _pokemons = [];
    _favoriteIds = [];
  }

  Future<void> _fetchPokemons(BuildContext context) async {
    final repository = context.read<PokeApiRepository>();
    try {
      final List<Pokemon> pokemons = await repository.fetchPokemons();
      setState(() {
        _pokemons = pokemons;
      });
    } catch (e) {
      // Handle error
      print('Failed to fetch pokemons: $e');
    }
  }

  Future<void> _toggleFavoriteStatus(
      int pokemonId, bool isFavorite, BuildContext context) async {
    final repository = context.read<PokeApiRepository>();
    try {
      // await repository.toggleFavoritePokemon(pokemonId, isFavorite);
      setState(() {
        if (isFavorite) {
          _favoriteIds.add(pokemonId);
        } else {
          _favoriteIds.remove(pokemonId);
        }
      });
    } catch (e) {
      // Handle error
      print('Failed to toggle favorite status: $e');
    }
  }

  bool _isFavorite(int pokemonId) {
    return _favoriteIds.contains(pokemonId);
  }

  @override
  Widget build(BuildContext context) {
    PokeApiRepository pokeApiRepository = PokeApiRepository();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Pokémon List'),
        centerTitle: true,
      ),
      body: _pokemons.isEmpty
          ? Center(
              child: ElevatedButton(
              onPressed: () {
                context.read<PokeApiRepository>().fetchPokemons();
              },
              child: Text('Load Pokemon'),
            ))
          : ListView.builder(
              itemCount: _pokemons.length,
              itemBuilder: (context, index) {
                final pokemon = _pokemons[index];
                return Text(pokemon.name);
                // return ListTile(
                //   title: Text(pokemon.name),
                //   trailing: IconButton(
                //     icon: _isFavorite(int.parse(pokemon.id))
                //         ? Icon(Icons.favorite, color: Colors.red)
                //         : Icon(Icons.favorite_border),
                //     onPressed: () {
                //       _toggleFavoriteStatus(int.parse(pokemon.id),
                //           !_isFavorite(int.parse(pokemon.id)), context);
                //     },
                //   ),
                // );
              },
            ),
    );
  }
}
