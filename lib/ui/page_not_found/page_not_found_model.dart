import 'package:flutter_boilerplate_app/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PageNotFoundModel extends BaseViewModel {
  NavigationService _navigation = locator<NavigationService>();

  init() async {
    await Future.delayed(Duration(seconds: 5));
    goBack();
  }

  goBack() {
    _navigation.back();
  }
}
