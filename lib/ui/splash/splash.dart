import 'package:delayed_display/delayed_display.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_app/ui/shared/misc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../bloc/constant/data.dart';
import 'splash_model.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashModel>.reactive(
        viewModelBuilder: () => SplashModel(),
        onModelReady: (model) => model.init(),
        builder: (context, model, child) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              kLogoSvg,
                              //color: Colors.white54,
                              semanticsLabel: 'Logo',
                              height: 250.h,
                              width: 250.h,
                            ),
                            verticalSpace(),
                            DelayedDisplay(
                              delay: Duration(seconds: model.initialDelay),
                              child: Text(
                                "splash_hi".tr(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                            verticalSpace(),
                            DelayedDisplay(
                              delay: Duration(seconds: model.initialDelay + 1),
                              child: Text(
                                model.isNewUser
                                    ? "splash_welcome".tr()
                                    : "splash_welcome_back".tr(),
                                maxLines: 1,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  verticalSpace(),
                  DelayedDisplay(
                    slidingBeginOffset: Offset(0.35, 0),
                    delay: Duration(seconds: model.initialDelay + 2),
                    child: "splash_caption"
                        .tr(namedArgs: {'app': kAppName})
                        .text
                        .maxLines(1)
                        .make(),
                  ),
                  verticalSpaceLarge(),
                ],
              ),
            ),
          );
        });
  }
}
