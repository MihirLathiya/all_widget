import 'dart:io';
import 'dart:math';
import 'package:all_widget/model/log_in_model.dart';
import 'package:all_widget/services/log_in_services.dart';
import 'package:all_widget/view/authantication/sign_up_screen.dart';
import 'package:dio/dio.dart' as dio;
import 'package:all_widget/constant.dart';
import 'package:all_widget/model/sign_up_model.dart';
import 'package:all_widget/services/sign_up_service.dart';
import 'package:all_widget/view/pokemon/pokemo_future_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../common/text.dart';
import '../../controller/password_controller.dart';

class LogInScreen extends StatefulWidget {
  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  ShowPasswordController showPasswordController =
      Get.put(ShowPasswordController());

  TextEditingController userName = TextEditingController();

  TextEditingController password = TextEditingController();

  final formKey = GlobalKey<FormState>();

  File? image;

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    print('==========================     Done');

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: userName,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter UserName';
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Username',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => TextFormField(
                    controller: password,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Password';
                      }
                    },
                    obscureText: showPasswordController.isShow.value,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        splashRadius: 20,
                        splashColor: Colors.blue.withAlpha(100),
                        onPressed: () {
                          showPasswordController.isShowing();
                        },
                        icon: showPasswordController.isShow.value
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () async {
                    dataStore();
                  },
                  child: Ts(text: 'SignUp'),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => SignUpScreen());
                  },
                  child: Ts(
                    text: 'SignUp',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  dataStore() async {
    if (formKey.currentState!.validate()) {
      LogInModel info = LogInModel();

      info.username = userName.text;
      info.password = password.text;
      bool? status = await LogInService.logIn(
        reqBody: info.toJson(),
      );
      if (status == true) {
        Get.snackbar('SuccessFull', 'Welcome Back',
            duration: Duration(seconds: 2));

        Get.off(
          () => const PokemonScreen(),
        );
      }
    }
  }
}
