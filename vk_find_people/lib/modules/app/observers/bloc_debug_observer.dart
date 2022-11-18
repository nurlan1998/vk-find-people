import 'package:flutter_bloc/flutter_bloc.dart';

import '../logging/log.dart';

class BlocDebugObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);

    Log.d(
      '[BLoc Event] ${bloc.runtimeType} -> $event',
    );
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    Log.d(
      '[BLoc State] ${bloc.runtimeType}, ${transition.currentState} -> ${transition.nextState}',
    );
  }
}