import 'package:flutter_boilerplate_app/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DashboardModel extends BaseViewModel {
  NavigationService _navigation = locator<NavigationService>();

  init() {}

  void goToSnakeGame() {
    //_navigation.navigateTo(Routes.snakeGame);
  }
}
