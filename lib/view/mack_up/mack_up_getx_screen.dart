import 'package:all_widget/controller/mack_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../common/text.dart';

class MackHomePage extends StatelessWidget {
  // const MackHomePage({Key? key}) : super(key: key);
  MackUpController mackUpController = Get.put(MackUpController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Ts(
          text: 'MackUp',
          color: Colors.black,
          size: 20,
        ),
        backgroundColor: Colors.grey.shade50,
      ),
      body: Obx(() {
        if (mackUpController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          var info = mackUpController.mackUpData;

          return MasonryGridView.count(
            padding: const EdgeInsets.only(top: 10),
            itemCount: info?.length,
            physics: const BouncingScrollPhysics(),
            crossAxisCount: 2,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.network('${info![index].imageLink}'),
                      ),
                      Ts(
                        text: '${info[index].name}',
                        maxLine: 2,
                        overFlow: TextOverflow.ellipsis,
                        weight: FontWeight.w700,
                        size: 18,
                      ),
                      const SizedBox(
                        height: 10,
                        width: 10,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Ts(
                          text: '\$ ${info[index].price}',
                          size: 15,
                          weight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                        width: 10,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
