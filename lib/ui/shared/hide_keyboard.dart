import 'package:flutter/material.dart';

/// dismiss keyboard
hideKeyboard(/*BuildContext context*/) {
  //FocusScope.of(context).requestFocus(FocusNode());
  FocusManager.instance.primaryFocus!.unfocus();
}
