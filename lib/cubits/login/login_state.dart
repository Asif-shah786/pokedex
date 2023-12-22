part of 'login_cubit.dart';

enum LoginStatus { initial, submitting, success, error }

class LoginState extends Equatable {
  final String email, password;
  final LoginStatus status;
  final User? user;

  const LoginState(
      {required this.email,
      required this.password,
      required this.status,
      this.user});

  factory LoginState.initial() {
    return const LoginState(
        email: '', password: '', status: LoginStatus.initial, user: null);
  }

  @override
  bool get stringify => true;

  @override
  // TODO: implement props
  List<Object?> get props => [email, password, status, user];

  bool get isValid => email.isNotEmpty && password.isNotEmpty;

  LoginState copyWith({
    String? email,
    String? password,
    LoginStatus? status,
    User? user,
  }) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        user: user ?? this.user);
  }
}
