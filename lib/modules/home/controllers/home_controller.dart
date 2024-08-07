import 'package:binary_quiz/services/game_service.dart';
import 'package:get/get.dart';

import '../../../game/game.dart';


class HomeController extends GetxController {
  final Rxn<Game> selectedGame = Rxn<Game>();

  bool isSelected(Game game) {
    return selectedGame.value == game;
  }

  void setSelectedGame(Game game) {
    selectedGame.value = game;
  }

  void unselectGame() {
    selectedGame.value = null;
  }

  void unselectGameByGame(Game game) {
    if (!isSelected(game)) return;
    unselectGame();
  }

  bool hasSelectedGame() {
    return selectedGame.value != null;
  }

  List<Game> getAvailableGames() {
    return Get.find<GameService>().games;
  }

}