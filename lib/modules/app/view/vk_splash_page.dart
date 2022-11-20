import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_find_people/modules/app/bloc/app_event.dart';
import 'package:vk_find_people/modules/app/bloc/app_state.dart';
import 'package:vk_find_people/modules/app/models/access_token_data.dart';
import 'package:vk_find_people/modules/app/routing/routing.dart';
import 'package:vk_find_people/modules/app/routing/routing.gr.dart';
import 'package:vk_find_people/modules/app/service_locator.dart';
import 'package:vk_find_people/modules/app/widgets/page_error.dart';
import 'package:vk_find_people/modules/app/widgets/page_loading.dart';
import 'package:vk_find_people/modules/vk/repository.dart';

import '../bloc/app_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _bloc = AppBloc(repository: ServiceLocator.get<VkRepository>());

  @override
  void initState() {
    super.initState();
    _bloc.add(StartApplication());
  }

  Future<void> _startAuthentication() async {
    final result = await AutoRouter.of(context).pushNamed(Routes.vkAuthPage);
    if(result is Map) {
      if(result.containsKey('access_token')) {
        final accessTokenData = AccessTokenData.fromJson(result);
        _bloc.add(SaveAccessToken(accessTokenData: accessTokenData));
        return;
      }
    }
    _bloc.add(AuthenticationFailed());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _bloc,
      listener: (context, state) {
        if (state is AppAuthorized) {
          context.router.replace(const VkDashboardRoute());
        }
        if (state is AppUnauthorized) {
          _startAuthentication();
        }
      },
      builder: (context, state) {
        if(state is AppLoading) {
          return const PageLoading();
        }
        if (state is AppStartupFailed) {
          return PageError(exception: state.exception);
        }
        return Container();
      },
    );
  }
}
