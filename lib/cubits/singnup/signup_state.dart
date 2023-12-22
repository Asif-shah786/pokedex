part of 'signup_cubit.dart';

enum SignupStatus { initial, submitting, success, error }

class SignupState extends Equatable {
  final String email, password;
  final SignupStatus status;
  final User? user;

  const SignupState(
      {required this.email,
      required this.password,
      required this.status,
      this.user});

  factory SignupState.initial() {
    return const SignupState(
        email: '', password: '', status: SignupStatus.initial, user: null);
  }

  @override
  bool get stringify => true;

  @override
  // TODO: implement props
  List<Object?> get props => [email, password, status, user];

  SignupState copyWith({
    String? email,
    String? password,
    SignupStatus? status,
    User? user,
  }) {
    return SignupState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        user: user ?? this.user);
  }

  bool get isValid => email.isNotEmpty && password.isNotEmpty;
}
