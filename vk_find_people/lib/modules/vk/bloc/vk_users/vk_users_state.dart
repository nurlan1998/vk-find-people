import 'package:equatable/equatable.dart';
import 'package:vk_find_people/modules/vk/models/vk_list_users.dart';
import 'package:vk_find_people/modules/vk/models/vk_user.dart';

class VkUsersState extends Equatable {
  const VkUsersState();

  @override
  List<Object> get props => [];
}

class InitialVkUsersState extends VkUsersState {}

class VkUsersLoading extends VkUsersState {}

class VkUsersError extends VkUsersState {
  final dynamic exception;

  const VkUsersError({
    this.exception,
  });

  @override
  List<Object> get props => [exception];
}

class VkUsersSuccess extends VkUsersState {
  final VkListUsers userInfo;

  const VkUsersSuccess({
    required this.userInfo,
  });

  @override
  List<Object> get props => [userInfo];
}
