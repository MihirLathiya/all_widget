import 'package:all_widget/common/text.dart';
import 'package:all_widget/controller/pokemon_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class PokemonHomeScreen extends StatelessWidget {
  // const PokemonHomeScreen({Key? key}) : super(key: key);

  PokemonController pokemonController = Get.put(PokemonController());

  PokemonHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Ts(
          text: 'Pokemon',
          color: Colors.black,
          size: 20,
        ),
        backgroundColor: Colors.grey.shade50,
      ),
      body: Obx(
        () {
          var info = pokemonController.pokemonData?.pokemon;
          if (pokemonController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
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
          }
        },
      ),
    );
  }
}
