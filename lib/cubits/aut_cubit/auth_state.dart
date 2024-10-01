part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSucsses extends AuthState {}

final class AuthFailure extends AuthState {
  final String errMess;

  AuthFailure({required this.errMess});
}
