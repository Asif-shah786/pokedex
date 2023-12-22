import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/blocs/internet_bloc/internet_bloc.dart';
import 'package:pokedex/blocs/internet_bloc/internet_bloc.dart';
import 'package:pokedex/blocs/internet_bloc/internet_state.dart';
import 'package:pokedex/constants.dart';

import '../blocs/auth/auth_bloc.dart';
import '../models/pokemon_model.dart';
import '../repositories/pokemon_repository.dart';
import '../widgets/show_toast.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (BuildContext context) => const HomeScreen(),
    );
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Pokemon> _pokemons;
  late List<String> _favoriteIds;

  @override
  void initState() {
    super.initState();
    _pokemons = [];
    _favoriteIds = [];
    _fetchPokemons(context);
  }

  void _fetchPokemons(BuildContext context) async {
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
      String pokemonName, bool isFavorite, BuildContext context) async {
    final repository = context.read<PokeApiRepository>();
    try {
      // await repository.toggleFavoritePokemon(pokemonId, isFavorite);
      setState(() {
        if (isFavorite) {
          _favoriteIds.add(pokemonName);
        } else {
          _favoriteIds.remove(pokemonName);
        }
      });
    } catch (e) {
      // Handle error
      print('Failed to toggle favorite status: $e');
    }
  }

  bool _isFavorite(String pokemonName) {
    return _favoriteIds.contains(pokemonName);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetBloc, InternetState>(
      listener: (context, state) {
        if (state is InternetGainedState) {
          showToast(context, 'Internet connection Active', Colors.green);
        } else if (state is InternetLossState) {
          showToast(context, 'No internet connection.', Colors.red);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Pokémon List'),
          actions: [
            TextButton(
                onPressed: () async => await context.read<AuthBloc>().signOut(),
                child: const Text('Logout'))
          ],
          centerTitle: true,
        ),
        body: _pokemons.isEmpty
            ? const Center(
                child: CircularProgressIndicator(
                color: kPrimaryColor,
              ))
            : ListView.builder(
                itemCount: _pokemons.length,
                itemBuilder: (context, index) {
                  final pokemon = _pokemons[index];
                  return ListTile(
                    title: Text(pokemon.name),
                    trailing: IconButton(
                      icon: _isFavorite(pokemon.name)
                          ? const Icon(Icons.favorite, color: Colors.red)
                          : const Icon(Icons.favorite_border),
                      onPressed: () {
                        _toggleFavoriteStatus(
                            pokemon.name, !_isFavorite(pokemon.name), context);
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
