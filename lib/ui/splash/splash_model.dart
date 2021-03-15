import 'package:flutter_boilerplate_app/app/app.locator.dart';
import 'package:flutter_boilerplate_app/app/app.router.dart';
import 'package:flutter_boilerplate_app/bloc/data_model/splash_data_model.dart';
import 'package:flutter_boilerplate_app/bloc/service/hive_db_manager.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashModel extends BaseViewModel {
  NavigationService _navigation = locator<NavigationService>();

  final int initialDelay = 1;
  var splashBox;
  SplashDataModel? splashData;
  bool isNewUser = true;

  init() async {
    await readSplashData();

    Future.delayed(Duration(seconds: initialDelay + 5), () {
      _navigation.replaceWith(Routes.dashboardPage);
    });
  }

  Future readSplashData() async {
    splashBox = await openHiveBox(boxName: 'splashBox');
    splashData = getHiveBox(box: splashBox, key: 0) as SplashDataModel;
    isNewUser = splashData?.isNew ?? true;
    notifyListeners();
    if (isNewUser) {
      if (splashData == null)
        addHiveBox(box: splashBox, data: SplashDataModel(isNew: false));
      else
        putHiveBoxAt(
            box: splashBox, index: 0, data: SplashDataModel(isNew: false));
    }
  }

  @override
  void dispose() {
    closeHiveBox(box: splashBox);
    super.dispose();
  }
}
