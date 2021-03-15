import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_app/bloc/util/responsive_screen.dart';

// * * * * * * * * * * * *
// Abbr:
// ks = const style
// * * * * * * * * * * * *

final BorderRadius ksBorderRadiusRoundExtraSmall =
    BorderRadius.all(Radius.circular(ScreenSpec.marginExtraSmall));
final BorderRadius ksBorderRadiusRoundSmall =
    BorderRadius.all(Radius.circular(ScreenSpec.marginSmall));
final BorderRadius ksBorderRadiusRound =
    BorderRadius.all(Radius.circular(ScreenSpec.margin));
final BorderRadius ksBorderRadiusRoundLarge =
    BorderRadius.all(Radius.circular(ScreenSpec.marginLarge));
final BorderRadius ksBorderRadiusRoundExtraLarge =
    BorderRadius.all(Radius.circular(ScreenSpec.marginExtraLarge));
final BorderRadius ksBorderRadiusCircle =
    BorderRadius.circular(ScreenSpec.marginCircle);
final ksBottomPanelShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
      topLeft: Radius.circular(ScreenSpec.margin),
      topRight: Radius.circular(ScreenSpec.margin)),
);

const kTextShadow = <Shadow>[
  Shadow(
    offset: Offset(1.0, 3.0),
    blurRadius: 5.0,
    color: Color.fromARGB(120, 85, 85, 85),
  ),
];

const kTextShadowDark = <Shadow>[
  Shadow(
    offset: Offset(1.0, 3.0),
    blurRadius: 5.0,
    color: Color.fromARGB(120, 206, 206, 206),
  ),
];
