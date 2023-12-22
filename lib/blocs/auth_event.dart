
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class AuthEvent extends Equatable{
  const AuthEvent();

  List<Object?> get props => [];

}

class AuthUserChanged extends AuthEvent{

  final User user;

  const AuthUserChanged({required this.user});


  @override
  // TODO: implement props
  List<Object?> get props => [user];

}
