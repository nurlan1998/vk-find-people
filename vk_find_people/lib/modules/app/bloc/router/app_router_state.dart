import 'package:equatable/equatable.dart';

import 'app_router_event.dart';

abstract class AppRouterState extends Equatable {
  const AppRouterState();

  @override
  List<Object> get props => [];
}

class AppRouterInitial extends AppRouterState {}

class AppRouterCallback extends AppRouterState {
  final AsyncCallbackWithRouter callback;

  const AppRouterCallback({
    required this.callback,
  });

  @override
  List<Object> get props => [callback];
}