import 'package:all_widget/services/pokemon_services.dart';
import 'package:get/get.dart';

import '../model/pokemon_model.dart';

class PokemonController extends GetxController {
  var isLoading = true.obs;
  PokemonModel? pokemonData;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    isLoading(true);
    try {
      var data = await PokemonServices.pokemonServices();
      if (data != null) {
        pokemonData = data;
      }
    } finally {
      isLoading(false);
    }
  }
}
