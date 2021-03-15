import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_app/bloc/constant/color.dart';
import 'package:flutter_boilerplate_app/bloc/util/responsive_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget loading(
    {bool center = true, Color color = kcAccent, double size = 20}) {
  Widget loader = CircularProgressIndicator();
  int type = Random().nextInt(5) + 1;

  if (type == 1) {
    loader = SpinKitWanderingCubes(
      color: color,
      size: size,
    );
  } else if (type == 2) {
    loader = SpinKitFadingFour(
      color: color,
      size: size,
    );
  } else if (type == 3) {
    loader = SpinKitThreeBounce(
      color: color,
      size: size,
    );
  } else if (type == 4) {
    loader = SpinKitChasingDots(
      color: color,
      size: size,
    );
  } else {
    loader = SpinKitSquareCircle(
      color: color,
      size: size,
    );
  }

  var child = Padding(
    padding: EdgeInsets.symmetric(
        horizontal: ScreenSpec.marginSmall, vertical: ScreenSpec.margin),
    child: loader,
  );
  return center ? Center(child: child) : child;
}
