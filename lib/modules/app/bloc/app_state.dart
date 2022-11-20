import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  const AppState();

  @override
  List<Object?> get props => [];
}

class AppLoading extends AppState {}

class AppStartupFailed extends AppState {
  final dynamic exception;

  const AppStartupFailed({this.exception});
}

class AppUnauthorized extends AppState {}

class AppAuthorized extends AppState {}

class AppAuthenticationUserCancelled extends AppState {}
