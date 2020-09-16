part of 'signup_cubit.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.username = const Username.pure(),
    this.status = FormzStatus.pure,
  });

  final Email email;
  final Password password;
  final FormzStatus status;
  final Username username;

  @override
  List<Object> get props => [username, email, password, status];

  SignUpState copyWith({
    Email email,
    Password password,
    Username username,
    FormzStatus status,
  }) {
    return SignUpState(
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
