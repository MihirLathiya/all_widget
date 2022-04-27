import 'dart:io';
import 'dart:math';
import 'package:all_widget/view/authantication/log_in_screen.dart';
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

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  ShowPasswordController showPasswordController =
      Get.put(ShowPasswordController());

  TextEditingController firstName = TextEditingController();

  TextEditingController lastName = TextEditingController();

  TextEditingController userName = TextEditingController();

  TextEditingController password = TextEditingController();

  final formKey = GlobalKey<FormState>();

  File? image;

  final picker = ImagePicker();

  Future setImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(
        () {
          image = File(pickedFile.path);
        },
      );
    }
  }

  Future<String?> uploadImage(String? fileName) async {
    dio.FormData data = dio.FormData.fromMap({
      'avatar':
          await dio.MultipartFile.fromFile(image!.path, filename: fileName)
    });
    dio.Response response = await dio.Dio().post(
        'https://codelineinfotech.com/student_api/User/user_avatar_upload.php',
        data: data);
    return response.data['url'];
  }

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
                GestureDetector(
                  onTap: () {
                    setImage();
                  },
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    height: 150,
                    width: 150,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    child: image == null
                        ? Image.network(
                            'https://wallpapercave.com/wp/wp6017359.jpg',
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            image!,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: firstName,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter FirstName';
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'First Name',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: lastName,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter LastName';
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Last Name',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
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
                    Get.to(() => LogInScreen());
                  },
                  child: Ts(
                    text: 'LogIn',
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
    String? imageUrl =
        await uploadImage('${Random().nextInt(1000)}${image!.path}');

    if (formKey.currentState!.validate()) {
      SignUpModel info = SignUpModel();
      info.firstName = firstName.text;
      info.lastName = lastName.text;
      info.username = userName.text;
      info.password = password.text;
      info.avatar = '$imageUrl';
      bool? status = await SignUpService.signUp(
        reqBody: info.toJson(),
      );
      if (status == true) {
        storage.write('userName', userName.text).whenComplete(
              () => Get.off(
                () => const PokemonScreen(),
              ),
            );
      }
    }
  }
}
