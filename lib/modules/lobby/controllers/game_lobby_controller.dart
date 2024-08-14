import 'package:binary_quiz/game/settings/max_rounds_setting.dart';
import 'package:binary_quiz/modules/ingame/controllers/in_game_controller.dart';
import 'package:binary_quiz/modules/ingame/views/in_game_page.dart';
import 'package:get/get.dart';

import '../../../game/game.dart';
import '../../../tools/my_tool.dart';
import '../../home/controllers/home_controller.dart';

class GameLobbyController extends GetxController {
  Game getGame() {
    return Get.find<HomeController>().selectedGame.value!;
  }

  void startGame() {
    int? maxRounds = getGame().getSetting(MaxRoundsSetting)?.getValue();
    if (maxRounds == null || maxRounds < 1) {
      MyTool.snackbar(
          title: 'module.lobby.invalid_setting.max_rounds.title'.tr,
          body: 'module.lobby.invalid_setting.max_rounds.content'.tr);
      return;
    }

    InGameController gameController = InGameController(getGame());

    Get.to(() => GetBuilder(
        builder: (controller) => InGamePage(), init: gameController));
  }
}
