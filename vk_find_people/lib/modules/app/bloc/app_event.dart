import 'package:equatable/equatable.dart';
import 'package:vk_find_people/modules/app/models/access_token_data.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

class StartApplication extends AppEvent {}

class AuthenticationFailed extends AppEvent {}

class SaveAccessToken extends AppEvent {
  final AccessTokenData accessTokenData;

  const SaveAccessToken({
    required this.accessTokenData,
  });

  @override
  List<Object?> get props => [accessTokenData];
}
