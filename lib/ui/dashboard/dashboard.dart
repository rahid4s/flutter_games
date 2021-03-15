import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_app/ui/shared/image_builder.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:dart_extensions/dart_extensions.dart';
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
      builder: (context, model, child) {
        return Scaffold(
          body: SafeArea(
            child: ScreenTypeLayout(
              isBoxed: true,
              mobile: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  verticalSpaceLarge(),
                  'Flutter Games By $kDevName'
                      .text
                      .textStyle(context.textTheme.headline4!.copyWith(
                        shadows: isDarkTheme(context)
                            ? kTextShadowDark
                            : kTextShadow,
                      ))
                      .maxLines(1)
                      .wider
                      .make()
                      .centered(),
                  verticalSpaceLarge(),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      padding: EdgeInsets.zero,
                      itemCount: model.kGameList.length,
                      itemBuilder: (context, index) {
                        return GridTile(
                          child: showImage(
                            imgUrl: model.kGameList[index].imgPath,
                            imgType: ImageType.Asset,
                          ),
                          footer: model.kGameList[index].title.text
                              .textStyle(context.textTheme.headline6!)
                              .thin
                              .wider
                              .center
                              .color(kcAccent)
                              .make(),
                        ).p(ScreenSpec.margin).onFeedBackTap(
                              () => model.goToGame(
                                  type: model.kGameList[index].type),
                            );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
