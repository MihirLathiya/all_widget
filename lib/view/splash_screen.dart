import 'dart:async';

import 'package:all_widget/common/text.dart';
import 'package:all_widget/constant.dart';
import 'package:all_widget/view/authantication/log_in_screen.dart';
import 'package:all_widget/view/pokemon/pokemo_future_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? info1;
  Timer? timer;

  Future getData() async {
    var info = storage.read('userName');
    setState(
      () {
        info1 = info;
      },
    );
  }

  @override
  void initState() {
    getData().whenComplete(
      () => Timer(
        const Duration(seconds: 2),
        () => info1 == null
            ? Get.off(
                () => LogInScreen(),
              )
            : Get.off(
                const PokemonScreen(),
              ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Ts(
          text: 'Welcome',
          size: 20,
        ),
      ),
    );
  }
}
