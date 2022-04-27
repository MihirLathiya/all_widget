import 'package:all_widget/view/authantication/log_in_screen.dart';
import 'package:all_widget/view/authantication/sign_up_screen.dart';
import 'package:all_widget/view/mack_up/mack_up_getx_screen.dart';
import 'package:all_widget/view/mack_up/mack_up_home_screen.dart';
import 'package:all_widget/view/pokemon/pokemo_future_screen.dart';
import 'package:all_widget/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
