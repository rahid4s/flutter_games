import 'package:flutter/material.dart';

enum ScreenType { Mobile, Tablet, Desktop }

const num kDesktopScreenSize = 950;
const num kTabletScreenSize = 600;

class ResponsiveApp extends StatelessWidget {
  const ResponsiveApp({
    Key? key,
    required this.app,
    required this.context,
  }) : super(key: key);

  final app;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(//return LayoutBuilder
        builder: (context, constraints) {
      return OrientationBuilder(//return OrientationBuilder
          builder: (context, orientation) {
        // calculate margins
        ScreenSpec(constraints: constraints, orientation: orientation);
        return app;
      });
    });
  }
}

class ScreenSpec {
  /// [Screen] sizing information in px
  final double _blockSize = 100;
  static late double blocks;
  static double marginExtraSmall = 5;
  static double marginSmall = 10;
  static double margin = 15;
  static double marginLarge = 20;
  static double marginExtraLarge = 30;
  static double marginCircle = 1000;

  ScreenSpec(
      {required BoxConstraints constraints, required Orientation orientation}) {
    double _screenHeight;

    if (orientation == Orientation.portrait) {
      _screenHeight = constraints.maxHeight;
    } else {
      _screenHeight = constraints.maxWidth;
    }

    blocks = _screenHeight / _blockSize;
    marginSmall = blocks;
    marginExtraSmall = blocks / 2;
    margin = blocks * 1.5;
    marginLarge = blocks * 3;
    marginExtraLarge = blocks * 4;
  }
}

ScreenType getScreenType({required BuildContext context}) {
  double deviceWidth = MediaQuery.of(context).size.shortestSide;

  if (deviceWidth <= kTabletScreenSize) {
    return ScreenType.Mobile;
  } else if (deviceWidth <= kDesktopScreenSize) {
    return ScreenType.Tablet;
  } else
    return ScreenType.Desktop;
}

dynamic getValueByScreenType({
  required BuildContext context,
  dynamic? mobileValue,
  dynamic? tabletValue,
  dynamic? desktopValue,
}) {
  assert(mobileValue != null && tabletValue != null && desktopValue != null,
      'Must provide at least one ScreenType value');

  ScreenType type = getScreenType(context: context);

  if (type == ScreenType.Desktop)
    return desktopValue ?? tabletValue ?? mobileValue;
  else if (type == ScreenType.Tablet)
    return tabletValue ?? mobileValue;
  else
    return mobileValue;
}

class ScreenTypeLayout extends StatelessWidget {
  final Widget? mobile;
  final Widget? tablet;
  final Widget? desktop;

  /// [isBoxed] shrinks the widget in middle
  final bool isBoxed;

  ScreenTypeLayout({
    Key? key,
    this.mobile,
    this.tablet,
    this.desktop,
    this.isBoxed = false,
  })  : assert(mobile != null || tablet != null || desktop != null,
            'ScreenTypeLayout requires at least one ScreenType widget.'),
        super(key: key);

  final double tabletBoxSizeMin = 600;
  final double desktopBoxSizeMin = 760;
  final double widthMultiplier = .7;

  @override
  Widget build(BuildContext context) {
    return _ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceType == ScreenType.Tablet) {
          if (tablet != null) {
            return tablet as Widget;
          } else {
            if (isBoxed) {
              var boxSize =
                  sizingInformation.screenSize.width * widthMultiplier;
              return Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: boxSize < tabletBoxSizeMin
                          ? tabletBoxSizeMin
                          : boxSize),
                  child: mobile,
                ),
              );
            } else {
              return mobile as Widget;
            }
          }
        }

        if (sizingInformation.deviceType == ScreenType.Desktop) {
          if (desktop != null) {
            return desktop as Widget;
          } else if (tablet != null) {
            if (isBoxed) {
              var boxSize =
                  sizingInformation.screenSize.width * widthMultiplier;
              return Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: boxSize < desktopBoxSizeMin
                          ? desktopBoxSizeMin
                          : boxSize),
                  child: tablet,
                ),
              );
            } else {
              return tablet as Widget;
            }
          } else {
            if (isBoxed) {
              var boxSize =
                  sizingInformation.screenSize.width * widthMultiplier;

              return Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: boxSize < desktopBoxSizeMin
                          ? desktopBoxSizeMin
                          : boxSize),
                  child: mobile,
                ),
              );
            } else {
              return mobile as Widget;
            }
          }
        }
        return mobile as Widget;
      },
    );
  }
}

class _ResponsiveBuilder extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    _SizingInformation sizingInformation,
  ) builder;

  const _ResponsiveBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, boxConstraints) {
      var sizingInformation = _SizingInformation(
        deviceType: getScreenType(context: context),
        screenSize: MediaQuery.of(context).size,
        localWidgetSize:
            Size(boxConstraints.maxWidth, boxConstraints.maxHeight),
      );
      return builder(context, sizingInformation);
    });
  }
}

class _SizingInformation {
  final ScreenType deviceType;
  final Size screenSize;
  final Size localWidgetSize;

  _SizingInformation({
    required this.deviceType,
    required this.screenSize,
    required this.localWidgetSize,
  });

  @override
  String toString() {
    return 'ScreenType:$deviceType ScreenSize:$screenSize LocalWidgetSize:$localWidgetSize';
  }
}
