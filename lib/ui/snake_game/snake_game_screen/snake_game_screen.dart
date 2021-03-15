import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_app/bloc/constant/data.dart';
import 'package:flutter_boilerplate_app/bloc/util/responsive_screen.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';
import 'snake_game_board.dart';
import 'snake_game_screen_model.dart';

class SnakeGameScreen extends StatelessWidget {
  const SnakeGameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SnakeGameScreenModel>.reactive(
      viewModelBuilder: () => SnakeGameScreenModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: ScreenTypeLayout(
            isBoxed: true,
            boxWidthMultiplier: .4,
            mobile: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: SnakeGameBoard(),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 150,
                    child: Center(
                      child: Text(
                          'kdAppName\n\nScore : ${model.score}    S.Path: ${model.shortestPath}'),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
            .box
            .bgImage(
              DecorationImage(
                  image: AssetImage(kAssetImgPath + 'bg_snake.png'),
                  //repeat: ImageRepeat.repeat,
                  fit: BoxFit.cover),
            )
            .make(),
      ),
    );
  }
}
