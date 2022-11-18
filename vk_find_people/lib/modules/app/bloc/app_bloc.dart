import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:vk_find_people/modules/app/bloc/app_event.dart';
import 'package:vk_find_people/modules/app/bloc/app_state.dart';
import 'package:vk_find_people/modules/app/cache.dart';
import 'package:vk_find_people/modules/app/models/access_token_data.dart';
import 'package:vk_find_people/modules/auth/auth.dart';
import 'package:vk_find_people/modules/vk/models/vk_user.dart';
import 'package:vk_find_people/modules/vk/models/vk_user_info.dart';
import 'package:vk_find_people/modules/vk/repository.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  late final Box accessTokenBox;
  final VkRepository repository;

  AppBloc({
    required this.repository,
  }) : super(AppLoading()) {
    accessTokenBox = Cache.box<AccessTokenData>();
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is StartApplication) {
      yield AppLoading();

      await Future<void>.delayed(const Duration(milliseconds: 1300));
      try {
        final token = AccessTokenData.fromCache();

        if (token != null) {
          final userResponse = await repository.getUser(userId: token.userId);
          final profileResponse = await repository.getProfileInfo();

          final userJson = (userResponse as List).first;
          final profile =
              VkUser.fromJson(profileResponse, VkUserInfo.fromJson(userJson));

          Auth.user = profile;

          yield AppAuthorized();
        } else {
          yield AppUnauthorized();
          return;
        }
      } catch (e) {
        yield AppStartupFailed(exception: e);
      }
    }

    if (event is SaveAccessToken) {
      await accessTokenBox.put(
        AccessTokenData.cacheBoxKey,
        event.accessTokenData,
      );
      add(StartApplication());
    }

    if (event is AuthenticationFailed) {
      yield AppAuthenticationUserCancelled();
    }
  }
}
