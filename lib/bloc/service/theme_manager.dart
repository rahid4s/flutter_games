import 'package:flutter/material.dart';
import 'package:stacked_themes/stacked_themes.dart';

Future initThemeManager() async {
  /// has to be called before runApp
  await ThemeManager.initialise();
}

changeTheme({required BuildContext context, required bool isDark}) {
  return getThemeManager(context)
      .setThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
}

bool isDarkTheme({required BuildContext context}) {
  if (getThemeManager(context).selectedThemeMode == ThemeMode.system) {
    return MediaQuery.of(context).platformBrightness == Brightness.dark;
  } else {
    return getThemeManager(context).isDarkMode;
  }


  
}

/*extension extendedThemeManager on ThemeManager {
  bool isDarkTheme(BuildContext context) {
    if (getThemeManager(context).selectedThemeMode == ThemeMode.system) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    } else {
      return this.selectedThemeMode == ThemeMode.dark;
    }
  }
}*/
