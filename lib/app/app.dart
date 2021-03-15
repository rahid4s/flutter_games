import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_themes/stacked_themes.dart';

import '../bloc/service/data_service.dart';
import '../ui/dashboard/dashboard.dart';
import '../ui/page_not_found/page_not_found.dart';
import '../ui/splash/splash.dart';

@StackedApp(
  routes: [
    CupertinoRoute(page: SplashPage, initial: true),
    CupertinoRoute(page: DashboardPage),

    /// 404 Not Found Page
    CupertinoRoute(page: PageNotFoundPage, path: '*'),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: ThemeService),
    LazySingleton(classType: DataService),
  ],
)
class App {
  /** This class has no purpose 
   * besides housing the annotation that generates the required functionality
   * **/
}
