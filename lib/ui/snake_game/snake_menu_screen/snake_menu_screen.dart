import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:dart_extensions/dart_extensions.dart';

import 'snake_menu_screen_model.dart';

class SnakeMenuScreen extends StatelessWidget {

  const SnakeMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SnakeMenuScreenModel>.reactive(
      viewModelBuilder: () => SnakeMenuScreenModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        body: Container(),
      ),
    );
  }
}