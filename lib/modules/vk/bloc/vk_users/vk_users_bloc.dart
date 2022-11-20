import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_find_people/modules/vk/bloc/vk_users/vk_users_event.dart';
import 'package:vk_find_people/modules/vk/bloc/vk_users/vk_users_state.dart';
import 'package:vk_find_people/modules/vk/models/vk_list_users.dart';
import 'package:vk_find_people/modules/vk/models/vk_user.dart';

import '../../repository.dart';

class VkUsersBloc extends Bloc<VkUsersEvent,VkUsersState> {
  final VkRepository repository;

  VkUsersBloc({
    required this.repository,
  }) : super(VkUsersLoading());

  @override
  Stream<VkUsersState> mapEventToState(VkUsersEvent event) async* {
    if(event is GetFriends) {
      yield VkUsersLoading();
      try {
        final response = await repository.getFriends(userId: event.userId);
        yield VkUsersSuccess(userInfo: VkListUsers.fromJson(response));
      }catch(e) {
        VkUsersError(exception: e);
      }
    }

    if(event is GetUsers) {
      yield VkUsersLoading();
      try{
        final response = await repository.getAllUsers(field: event.field);
        yield VkUsersSuccess(userInfo: VkListUsers.fromJson(response));
      }catch(e) {
        yield VkUsersError(exception: e);
      }
    }
  }
}