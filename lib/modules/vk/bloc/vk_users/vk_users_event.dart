import 'package:equatable/equatable.dart';

abstract class VkUsersEvent extends Equatable {
  const VkUsersEvent();

  @override
  List<Object> get props => [];
}

class GetFriends extends VkUsersEvent {
  final int userId;

  const GetFriends({
    required this.userId,
  });

  @override
  List<Object> get props => [userId];
}

class GetUsers extends VkUsersEvent {
  final String field;

  const GetUsers({
    required this.field,
  });

  @override
  List<Object> get props => [field];
}
