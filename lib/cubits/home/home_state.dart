part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoadSuccess extends HomeState {
  final List<Pokemon> pokemons;

  HomeLoadSuccess(this.pokemons);

  @override
  List<Object> get props => [pokemons];
}

class HomeLoadFailure extends HomeState {}
