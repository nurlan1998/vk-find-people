import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_find_people/modules/app/bloc/router/app_router_bloc.dart';
import 'package:vk_find_people/modules/app/bloc/router/app_router_state.dart';
import 'package:vk_find_people/modules/app/observers/navigation_observer.dart';
import 'package:vk_find_people/modules/app/routing/routing.gr.dart';
import 'package:vk_find_people/modules/app/service_locator.dart';

const textTheme = TextTheme(
  bodyText1: TextStyle(color: Colors.black),
  bodyText2: TextStyle(color: Colors.black),
  button: TextStyle(color: Colors.black),
  headline6: TextStyle(color: Colors.black),
);

class MaterialApplication extends StatefulWidget {
  const MaterialApplication({Key? key}) : super(key: key);

  @override
  State<MaterialApplication> createState() => _MaterialApplicationState();
}

class _MaterialApplicationState extends State<MaterialApplication> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: ServiceLocator.get<AppRouterBloc>(),
      listener: (context, state) {
        if(state is AppRouterCallback) {
          state.callback(_router);
        }
      },
      child: MaterialApp.router(
        title: 'asd',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: const Color(0xff2787F5),
          scaffoldBackgroundColor: Colors.white,
          buttonTheme: const ButtonThemeData(
            buttonColor: Color(0xff2787F5),
          ),
          appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: const Color(0xfff2f3f5),
            textTheme: textTheme.copyWith(
              headline6: textTheme.headline6!.copyWith(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
              statusBarColor: Colors.transparent,

              systemNavigationBarColor: Colors.white,
              systemNavigationBarDividerColor: Colors.white,
              systemNavigationBarIconBrightness: Brightness.dark,
            ),
          ),
          dialogTheme: DialogTheme(
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(
              color: Colors.black.withOpacity(0.7),
            ),
            contentTextStyle: const TextStyle(
              color: Colors.black,
            ),
          ),
          textTheme: textTheme,
        ),
        routeInformationParser: _router.defaultRouteParser(),
        routerDelegate: _router.delegate(navigatorObservers: () => [
          NavigationObserver()
        ]),
      ),
    );
  }
}
