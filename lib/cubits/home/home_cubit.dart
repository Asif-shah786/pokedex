import 'package:bloc/bloc.dart';
import 'package:pokedex/repositories/pokemon_repository.dart';
import 'package:equatable/equatable.dart';

import '../../models/pokemon_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final PokeApiRepository pokemonRepository;

  HomeCubit({required this.pokemonRepository}) : super(HomeInitial());

  void loadPokemons() async {
    try {
      final List<Pokemon> pokemons = await pokemonRepository.fetchPokemons();
      emit(HomeLoadSuccess(pokemons));
    } catch (e) {
      emit(HomeLoadFailure());
    }
  }

  void toggleFavoriteStatus(int pokemonId) {
    final currentState = state;
    if (currentState is HomeLoadSuccess) {
      final updatedPokemons = currentState.pokemons.map((pokemon) {
        // if (pokemon.id == pokemonId) {
          // return pokemon.copyWith(isFavorite: !pokemon.isFavorite);
        // }
        return pokemon;
      }).toList();
      emit(HomeLoadSuccess(updatedPokemons));
    }
  }
}
