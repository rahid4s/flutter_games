import 'package:flutter_boilerplate_app/bloc/constant/data.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

import 'package:easy_localization/easy_localization.dart';
import 'page_not_found_model.dart';

class PageNotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PageNotFoundModel>.reactive(
      viewModelBuilder: () => PageNotFoundModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DelayedDisplay(
                delay: Duration(milliseconds: 500),
                child: Lottie.asset(kAssetAnimPath + '404.json',
                    fit: BoxFit.contain,
                    repeat: false,
                    width: context.percentWidth * 40),
              ),
              DelayedDisplay(
                delay: Duration(seconds: 1),
                child: Text(
                  "page_not_found".tr(),
                  maxLines: 1,
                  style: Theme.of(context).textTheme.headline6,
                ).text.make(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
