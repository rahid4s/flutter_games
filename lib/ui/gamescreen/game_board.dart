import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_app/bloc/constant/style.dart';
import 'package:flutter_boilerplate_app/bloc/util/responsive_screen.dart';
import 'package:flutter_boilerplate_app/ui/shared/loading_indicator.dart';
import 'package:stacked/stacked.dart';

import '../../bloc/constant/color.dart';
import 'game_screen_model.dart';

class GameBoard extends ViewModelWidget<GameScreenModel> {

  @override
  Widget build(BuildContext context, GameScreenModel model) {
    return GestureDetector(
      onVerticalDragUpdate: (DragUpdateDetails dragDetails) =>
          model.handleVerticalDragInput(details: dragDetails),
      onHorizontalDragUpdate: (DragUpdateDetails dragDetails) =>
          model.handleHorizontalDragInput(details: dragDetails),
      child: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (RawKeyEvent event) =>
            model.handleKeyboardInputEvent(event: event),
        autofocus: true,
        child: Container(
          color: kcGameBoardBg,
          padding: EdgeInsets.all(model.boardSpacing),
          alignment: Alignment.center,
          child: LayoutBuilder(
            builder: (context, constraints) {
              model.calculateBlocks(constraints: constraints);
              return model.isBusy
                  ? loading()
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: model.blockCountX,
                      ),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: model.blockCountTotal,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(model.boardSpacing),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: getScreenType(context: context) ==
                                    ScreenType.Mobile
                                ? ksBorderRadiusRoundExtraSmall
                                : ksBorderRadiusRoundSmall,
                            color: model.isFood(index)
                                ? kcFood
                                : model.getColor(index),
                          ),
                          child: Text(index.toString()),
                        );
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}
