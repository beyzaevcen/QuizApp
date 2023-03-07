import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiz_app/screens/home_page.dart';
import 'package:quiz_app/utils/theme.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('scoreBox');

  EasyLoading.instance
    ..indicatorColor = CColors.white
    ..indicatorSize = 80
    ..errorWidget = const Icon(Icons.warning)
    ..indicatorType = EasyLoadingIndicatorType.circle;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: FlutterEasyLoading(
          child: HomePage(),
        ));
  }
}
