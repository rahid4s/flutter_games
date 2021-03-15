import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boilerplate_app/bloc/constant/data.dart';
import 'package:flutter_boilerplate_app/bloc/util/color_swatch_maker.dart';
import 'package:flutter_boilerplate_app/ui/shared/show_snackbar.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_themes/stacked_themes.dart';
import 'app/app.locator.dart';
import 'app/app.router.dart';
import 'bloc/constant/color.dart';
import 'bloc/constant/dimen.dart';
import 'bloc/service/hive_db_manager.dart';
import 'bloc/util/responsive_screen.dart';
import 'bloc/service/theme_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // * must be the first line
  await EasyLocalization.ensureInitialized();
  await initThemeManager();
  await initHive();
  setupLocator();
  setupSnackbarUi();

  /* SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: kcNavigationBar,
    statusBarColor: kcStatusBar,
  )); */

  runApp(EasyLocalization(
    supportedLocales: [
      Locale('en', 'US'),
    ],
    path: 'assets/translations',
    fallbackLocale: Locale('en', 'US'),
    /* child: DevicePreview(
      enabled: false,
      builder: (context) => App(),
    ), */
    child: App(),
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _lightTheme = ThemeData(
      brightness: Brightness.light,
      primarySwatch: createMaterialColorFrom(kcPrimary),
      primaryColorBrightness: Brightness.light,
      primaryColorDark: kcPrimaryDark,
      accentColor: kcAccent,
      canvasColor: kcCanvas,
      splashColor: kcSplash,
      errorColor: kcError,
      dividerColor: kcDivider,
      iconTheme: IconThemeData(color: ktcPrimary),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme.of(context).copyWith(
        brightness: Brightness.dark,
      ),
      textTheme: GoogleFonts.ubuntuTextTheme(Theme.of(context).textTheme.apply(
            displayColor: ktcPrimary,
            bodyColor: ktcSecondary,
          )),
    );

    var _darkTheme = ThemeData(
      brightness: Brightness.dark,
      primarySwatch: createMaterialColorFrom(kcPrimaryDark),
      primaryColorBrightness: Brightness.dark,
      primaryColorDark: kcPrimaryDark,
      accentColor: kcAccentDark,
      canvasColor: kcCanvasDark,
      splashColor: kcSplashDark,
      errorColor: kcError,
      dividerColor: kcDividerDark,
      iconTheme: IconThemeData(color: ktcPrimary),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme.of(context).copyWith(
        brightness: Brightness.dark,
      ),
      textTheme: GoogleFonts.ubuntuTextTheme(Theme.of(context).textTheme.apply(
            displayColor: ktcPrimaryDark,
            bodyColor: ktcSecondaryDark,
          )),
    );

    return ThemeBuilder(
      defaultThemeMode: ThemeMode.system,
      statusBarColorBuilder: (theme) => kcStatusBar,
      lightTheme: _lightTheme,
      darkTheme: _darkTheme,
      builder: (context, regularTheme, darkTheme, themeMode) {
        return ScreenUtilInit(
          designSize: kAppDesignSpec,
          allowFontScaling: kAppFontScaling,
          builder: () => ResponsiveApp(
            context: context,
            app: MaterialApp(
              title: kAppName,
              theme: regularTheme,
              darkTheme: darkTheme,
              themeMode: themeMode,
              debugShowCheckedModeBanner: false,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              locale: context.locale,
              //locale: DevicePreview.locale(context),
              //builder: DevicePreview.appBuilder,
              navigatorKey: StackedService.navigatorKey,
              onGenerateRoute: StackedRouter().onGenerateRoute,
            ),
          ),
        );
      },
    );
  }
}
