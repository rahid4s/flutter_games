import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:dart_extensions/dart_extensions.dart';
import '../../bloc/constant/color.dart';
import '../../bloc/constant/color.dart';
import '../../bloc/constant/color.dart';
import '../../bloc/constant/data.dart';
import '../../bloc/constant/style.dart';
import '../../bloc/service/theme_manager.dart';
import '../../bloc/util/responsive_screen.dart';
import '../shared/misc.dart';
import 'dashboard_model.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardModel>.reactive(
      viewModelBuilder: () => DashboardModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              verticalSpace(value: 50.h),
              'Flutter Games By $kDevName'
                  .text
                  .textStyle(TextStyle(
                    shadows:
                        isDarkTheme(context) ? kTextShadowDark : kTextShadow,
                  ))
                  .maxLines(1)
                  .size(48.sp)
                  .wider
                  .make()
                  .centered(),
              verticalSpace(value: 50.h),
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    ListTile(
                      onTap: model.goToSnakeGame,
                      leading: Icon(
                        PhosphorIcons.tag_simple,
                        color: kcAccent,
                      ),
                      title: 'Snake Classic'
                          .text
                          .size(36.sp)
                          .medium
                          .color(kcAccent)
                          .make(),
                    ),
                  ],
                ).box.width(context.percentWidth * 70).make(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
