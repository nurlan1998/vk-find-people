import 'package:flutter/material.dart';
import 'package:vk_find_people/modules/app/base/material_application.dart';
import 'package:vk_find_people/modules/app/cache.dart';
import 'package:vk_find_people/modules/app/logging/log.dart';
import 'package:vk_find_people/modules/app/routing/routing.gr.dart';
import 'package:vk_find_people/modules/app/service_locator.dart';

void main() async {
  Log.initialize();
  await ServiceLocator.initialize();
  await Cache.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApplication();
  }
}