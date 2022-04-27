import 'package:all_widget/services/mack_up_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../common/text.dart';
import '../../model/mack_up_model.dart';

class MackUpScreen extends StatelessWidget {
  const MackUpScreen({Key? key}) : super(key: key);

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
      body: FutureBuilder(
        future: MackUpService.mackUpService(),
        builder:
            (BuildContext context, AsyncSnapshot<List<MackUpModel>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var info = snapshot.data;
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
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
