import 'package:flutter/cupertino.dart';

import '../app/models/access_token_data.dart';
import '../vk/models/vk_user.dart';

class Auth {
  Auth._();

  static Future<void> destroy() async {
    await AccessTokenData.fromCache()?.remove();
    user = null;
  }

  static set user(VkUser? user) {
    _valueNotifier.value = user;
  }

  static VkUser? get user => _valueNotifier.value;

  static final _valueNotifier = ValueNotifier<VkUser?>(null);
}