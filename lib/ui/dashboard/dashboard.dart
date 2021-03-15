import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'dashboard_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardModel>.reactive(
      viewModelBuilder: () => DashboardModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text(
            'Dashboard',
            style: TextStyle(fontSize: 50.h),
          ).text.make(),
        ),
      ),
    );
  }
}
