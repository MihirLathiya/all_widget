import 'package:all_widget/services/mack_up_service.dart';
import 'package:get/get.dart';

import '../model/mack_up_model.dart';

class MackUpController extends GetxController {
  var isLoading = true.obs;
  List<MackUpModel>? mackUpData;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    isLoading(true);
    try {
      var data = await MackUpService.mackUpService();
      if (data != null) {
        mackUpData = data;
      }
    } finally {
      isLoading(false);
    }
  }
}
