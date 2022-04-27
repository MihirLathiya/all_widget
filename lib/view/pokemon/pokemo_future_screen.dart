import 'package:all_widget/constant.dart';
import 'package:all_widget/services/pokemon_services.dart';
import 'package:all_widget/view/authantication/log_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../../common/text.dart';
import '../../model/pokemon_model.dart';

class PokemonScreen extends StatelessWidget {
  const PokemonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        actions: [
          IconButton(
            onPressed: () {
              storage.remove('userName').whenComplete(
                    () => Get.off(
                      () => LogInScreen(),
                    ),
                  );
            },
            icon: const Icon(
              Icons.login_outlined,
              color: Colors.black45,
            ),
          ),
        ],
        title: Ts(
          text: 'Pokemon',
          color: Colors.black,
          size: 20,
        ),
        backgroundColor: Colors.grey.shade50,
      ),
      body: FutureBuilder(
        future: PokemonServices.pokemonServices(),
        builder: (BuildContext context, AsyncSnapshot<PokemonModel?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var info = snapshot.data?.pokemon;
            return MasonryGridView.count(
              padding: const EdgeInsets.only(top: 10),
              itemCount: info?.length,
              physics: const BouncingScrollPhysics(),
              crossAxisCount: 3,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.network('${info![index].img}'),
                      ),
                      Ts(
                        text: '${info[index].name}',
                        weight: FontWeight.w700,
                        size: 18,
                      ),
                      const SizedBox(
                        height: 10,
                        width: 10,
                      )
                    ],
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
