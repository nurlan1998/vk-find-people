import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_find_people/modules/app/service_locator.dart';
import 'package:vk_find_people/modules/app/widgets/page_background.dart';
import 'package:vk_find_people/modules/vk/bloc/vk_users/vk_users_bloc.dart';
import 'package:vk_find_people/modules/vk/bloc/vk_users/vk_users_event.dart';
import 'package:vk_find_people/modules/vk/bloc/vk_users/vk_users_state.dart';
import 'package:vk_find_people/modules/vk/repository.dart';

import '../models/vk_list_users.dart';

class VkSearchPage extends StatefulWidget {
  const VkSearchPage({Key? key}) : super(key: key);

  @override
  State<VkSearchPage> createState() => _VkSearchPageState();
}

class _VkSearchPageState extends State<VkSearchPage> {
  final _bloc = VkUsersBloc(repository: ServiceLocator.get<VkRepository>());
  TextEditingController searchController = TextEditingController();

  List<VkListUsersItem>? usersInfo;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _bloc,
      listener: (context, state) {
        if (state is VkUsersError) {}
        if (state is VkUsersSuccess) {
          usersInfo = state.userInfo.listUsersItem;
        }
      },
      builder: (context, state) {
        final InputBorder border = OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300]!));

        return PageBackground(
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 10),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: TextField(
                    controller: searchController,
                    onChanged: (String value) {
                      if (value.isNotEmpty && value.length > 2) {
                        _bloc.add(GetUsers(field: value));
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10.0),
                      border: border,
                      enabledBorder: border,
                      suffixIcon: searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                setState(() {
                                  searchController.clear();
                                  FocusScope.of(context).unfocus();
                                  usersInfo = [];
                                });
                              })
                          : const Icon(Icons.search),
                      hintText: '',
                    ),
                ),
              ),
              const SizedBox(height: 10),
              if (usersInfo != null)
                for (var x in usersInfo!)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        const SizedBox(height: 10),
                        CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(x.photo200!)),
                        const SizedBox(width: 10),
                        Text(x.firstName)
                      ],
                    ),
                  ),
            ],
          ),
        );
      },
    );
  }
}
