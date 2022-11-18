import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vk_find_people/modules/app/widgets/page_background.dart';

import '../../auth/auth.dart';
import '../models/vk_user.dart';

class VkProfilePage extends StatefulWidget {
  const VkProfilePage({Key? key}) : super(key: key);

  @override
  State<VkProfilePage> createState() => _VkProfilePageState();
}

class _VkProfilePageState extends State<VkProfilePage> {

  VkUser? get userProfile => Auth.user;

  @override
  Widget build(BuildContext context) {
    return PageBackground(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          CircleAvatar(radius: 80,backgroundImage: NetworkImage(userProfile!.photo200!)),
          const SizedBox(height: 10),
          Text(userProfile?.displayName ?? '')
        ],
      ),
    );
  }
}
