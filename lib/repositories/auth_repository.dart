import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokedex/repositories/base_auth_repository.dart';

class AuthRepository extends BaseAuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<User?> signup({required String email, required String password}) async  {
    try{
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      final user = credential.user;
      return user;
    }
        catch(_){}
  }

  @override
  Future<User?> login({required String email, required String password}) async  {
    try{
      final credential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      final user = credential.user;
      return user;
    }
    catch(_){}
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }


  @override
  // TODO: implement user
  Stream<User?> get user => _firebaseAuth.userChanges();
}
