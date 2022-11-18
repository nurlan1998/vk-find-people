import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_find_people/modules/app/bloc/router/app_router_event.dart';
import 'package:vk_find_people/modules/app/bloc/router/app_router_state.dart';

class AppRouterBloc extends Bloc<AppRouterEvent, AppRouterState> {
  AppRouterBloc() : super(AppRouterInitial());

  @override
  Stream<AppRouterState> mapEventToState(
      AppRouterEvent event,
      ) async* {
    if (event is RoutingEvent) {
      yield AppRouterCallback(callback: event.callback);
    }
  }
}