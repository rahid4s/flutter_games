import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_app/app/app.locator.dart';
import 'package:flutter_boilerplate_app/bloc/constant/color.dart';
import 'package:flutter_boilerplate_app/bloc/util/responsive_screen.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:stacked_services/stacked_services.dart';

/// The type of snackbar to show
enum SnackbarType {
  info,
  success,
  error,
}

void setupSnackbarUi() {
  final service = locator<SnackbarService>();

  // Registers a config to be used when calling showSnackbar
  service.registerSnackbarConfig(SnackbarConfig(
    backgroundColor: Colors.black.withOpacity(.6),
    textColor: Colors.white,
    mainButtonTextColor: kcAccent,
  ));

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.info,
    config: SnackbarConfig(
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      borderRadius: ScreenSpec.marginSmall,
      icon: Icon(LineAwesomeIcons.info, color: Colors.white),
      animationDuration: Duration(milliseconds: 2000),
      shouldIconPulse: true,
    ),
  );

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.success,
    config: SnackbarConfig(
      backgroundColor: kcSuccess,
      textColor: Colors.white,
      borderRadius: ScreenSpec.marginSmall,
      icon: Icon(LineAwesomeIcons.check, color: Colors.white),
      animationDuration: Duration(milliseconds: 2000),
      shouldIconPulse: true,
    ),
  );

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.error,
    config: SnackbarConfig(
      backgroundColor: kcError,
      textColor: Colors.white,
      borderRadius: ScreenSpec.marginSmall,
      icon: Icon(LineAwesomeIcons.times, color: Colors.white),
      animationDuration: Duration(milliseconds: 1500),
      shouldIconPulse: true,
    ),
  );
}

Future showSnackbar({
  required String text,
  SnackbarType type = SnackbarType.info,
}) async {
  await locator<SnackbarService>().showCustomSnackBar(
    title: type == SnackbarType.success
        ? 'Success'
        : type == SnackbarType.error
            ? 'Error'
            : 'Info',
    message: text,
    variant: type,
    duration: Duration(milliseconds: 2000),
  );
}
