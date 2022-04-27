import 'package:get/get.dart';

class ShowPasswordController extends GetxController {
  var isShow = true.obs;
  isShowing() async {
    isShow.value = !isShow.value;
  }
}
