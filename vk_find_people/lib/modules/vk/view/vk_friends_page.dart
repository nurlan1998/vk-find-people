import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_find_people/modules/app/widgets/page_background.dart';
import 'package:vk_find_people/modules/app/widgets/page_error.dart';
import 'package:vk_find_people/modules/app/widgets/page_loading.dart';
import 'package:vk_find_people/modules/vk/bloc/vk_users/vk_users_event.dart';
import 'package:vk_find_people/modules/vk/bloc/vk_users/vk_users_state.dart';

import '../../app/service_locator.dart';
import '../../auth/auth.dart';
import '../bloc/vk_users/vk_users_bloc.dart';
import '../models/vk_user.dart';
import '../repository.dart';

class VkFriendsPage extends StatefulWidget {
  const VkFriendsPage({Key? key}) : super(key: key);

  @override
  State<VkFriendsPage> createState() => _VkFriendsPageState();
}

class _VkFriendsPageState extends State<VkFriendsPage> {
  final _bloc = VkUsersBloc(repository: ServiceLocator.get<VkRepository>());

  VkUser? get userProfile => Auth.user;

  @override
  void initState() {
    super.initState();
    _bloc.add(GetFriends(userId: userProfile!.id));
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          if (state is VkUsersLoading) {
            return const PageLoading();
          }
          if (state is VkUsersError) {
            return PageError(exception: state.exception);
          }
          if (state is VkUsersSuccess) {
            return PageBackground(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListView.builder(
                    itemCount: state.userInfo.listUsersItem.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Image.network(
                                      state.userInfo.listUsersItem[index]
                                          .photo200!,
                                      width: double.infinity,
                                      height: 300,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(children: <Widget>[
                                      const Text(
                                        'Имя пользователя:',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        state.userInfo.listUsersItem[index]
                                            .firstName,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      )
                                    ]),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              const SizedBox(height: 10),
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  state.userInfo.listUsersItem[index].photo200!,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                  state.userInfo.listUsersItem[index].firstName)
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            );
          }
          return Container();
        });
  }

  void showProfile() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: <Widget>[
            Image.network(userProfile!.photo200!),
          ],
        );
      },
    );
  }
}
