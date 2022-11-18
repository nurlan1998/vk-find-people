import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart' as hive;

import 'models/access_token_data.dart';

class Cache {
  Cache._();

  static Future<void> initialize() async {
    await Hive.initFlutter();
    hive.Hive.registerAdapter(AccessTokenDataAdapter());
    await openBox<AccessTokenData>();
    await openBox<bool>();
  }

  static Future<void> openBox<T>() async {
    await Hive.openBox<T>(T.toString());
  }

  static Box<T> box<T>() {
    return Hive.box<T>(T.toString());
  }
}