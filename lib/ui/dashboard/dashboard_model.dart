import 'package:flutter_boilerplate_app/app/app.locator.dart';
import 'package:flutter_boilerplate_app/app/app.router.dart';
import 'package:flutter_boilerplate_app/bloc/constant/data.dart';
import 'package:flutter_boilerplate_app/bloc/data_model/game_list_model.dart';
import 'package:flutter_boilerplate_app/ui/shared/toast.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DashboardModel extends BaseViewModel {
  NavigationService _navigation = locator<NavigationService>();

  final List<GameListModel> kGameList = [
    GameListModel(
        type: GameType.Snake,
        title: 'Snake Classic',
        imgPath: kAssetImgPath + 'ic_snake.png'),
    GameListModel(
        type: GameType.FlappyBird,
        title: 'Flappy Bird',
        imgPath: kPlaceholderImg),
  ];

  init() {}

  void goToSnakeGame() {
    _navigation.navigateTo(Routes.snakeGameScreen);
  }

  goToGame({required GameType type}) {
    switch (type) {
      case GameType.Snake:
        goToSnakeGame();
        break;
      case GameType.FlappyBird:
        showToastInfo('Coming Soon');
        break;
      default:
    }
  }
}
