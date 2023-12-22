import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuthRepository {
  Stream<User?> get user;
  Future<User?> signup({
    required String email,
    required String password,
  });
  Future<User?> login({
    required String email,
    required String password,
  });

  Future<void> signOut()async{}
}


