import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_app/bloc/constant/color.dart';
import 'package:flutter_flexible_toast/flutter_flexible_toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showToastInfo(
  String msg, {
  int durationInSeconds = 1,
}) {
  cancelToast();
  FlutterFlexibleToast.showToast(
      message: msg,
      toastLength:
          durationInSeconds == 1 ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG,
      toastGravity: ToastGravity.BOTTOM,
      icon: ICON.INFO,
      radius: 10,
      elevation: 5,
      textColor: Colors.white,
      fontSize: 20.sp,
      backgroundColor: kcAccent,
      timeInSeconds: 2);
}

void showToastSuccess(String msg) {
  cancelToast();
  FlutterFlexibleToast.showToast(
      message: msg,
      toastLength: Toast.LENGTH_SHORT,
      toastGravity: ToastGravity.BOTTOM,
      icon: ICON.SUCCESS,
      radius: 10,
      elevation: 5,
      textColor: Colors.white,
      fontSize: 20.sp,
      backgroundColor: kcSuccess,
      timeInSeconds: 2);
}

void showToastFailed(String msg) {
  cancelToast();
  FlutterFlexibleToast.showToast(
      message: msg,
      toastLength: Toast.LENGTH_LONG,
      toastGravity: ToastGravity.BOTTOM,
      icon: ICON.WARNING,
      radius: 10,
      elevation: 5,
      textColor: Colors.white,
      fontSize: 20.sp,
      backgroundColor: kcWarning,
      timeInSeconds: 2);
}

void showToastLoading(String msg) {
  cancelToast();
  FlutterFlexibleToast.showToast(
      message: msg,
      toastLength: Toast.LENGTH_SHORT,
      toastGravity: ToastGravity.BOTTOM,
      icon: ICON.LOADING,
      radius: 10,
      elevation: 5,
      textColor: Colors.white,
      fontSize: 20.sp,
      backgroundColor: kcAccent,
      timeInSeconds: 2);
}

void cancelToast() {
  FlutterFlexibleToast.cancel();
}
