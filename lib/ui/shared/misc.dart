import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_app/bloc/util/responsive_screen.dart';

Widget horizontalSpace({double? value}) {
  return SizedBox(width: value ?? ScreenSpec.margin);
}

Widget horizontalSpaceSmall() {
  return SizedBox(width: ScreenSpec.marginSmall);
}

Widget horizontalSpaceLarge() {
  return SizedBox(width: ScreenSpec.marginLarge);
}

Widget verticalSpace({double? value}) {
  return SizedBox(height: value ?? ScreenSpec.margin);
}

Widget verticalSpaceSmall() {
  return SizedBox(height: ScreenSpec.marginSmall);
}

Widget verticalSpaceLarge() {
  return SizedBox(height: ScreenSpec.marginLarge);
}

const Widget empty = SizedBox.shrink();
