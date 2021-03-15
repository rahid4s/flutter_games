import 'package:stacked/stacked.dart';
import 'package:observable_ish/observable_ish.dart';

class DataService with ReactiveServiceMixin {
  DataService() {
    listenToReactiveValues([_isLoggedIn]);
  }

  RxValue<bool> _isLoggedIn = RxValue<bool>(initial: false);
  bool get isLoggedIn => _isLoggedIn.value;

  void updateLogInStatus({required isLoggedIn}) {
    _isLoggedIn.value = isLoggedIn;
  }

}
