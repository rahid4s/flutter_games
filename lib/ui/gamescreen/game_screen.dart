import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_app/bloc/util/responsive_screen.dart';
import 'package:stacked/stacked.dart';
import '../../bloc/constant/data.dart';
import 'game_board.dart';
import 'game_screen_model.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GameScreenModel>.reactive(
      viewModelBuilder: () => GameScreenModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: ScreenTypeLayout(
            isBoxed: true,
            boxWidthMultiplier: .4,
            mobile: Column(
              children: [
                Expanded(
                  child: GameBoard(),
                ),
                Container(
                  height: 150,
                  child: Center(
                    child: Text('kdAppName\n\nScore : ${model.score}    S.Path: ${model.shortestPath}'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
