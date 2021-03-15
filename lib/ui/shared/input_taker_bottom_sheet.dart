import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_app/app/app.locator.dart';
import 'package:flutter_boilerplate_app/bloc/constant/color.dart';
import 'package:flutter_boilerplate_app/bloc/constant/dimen.dart';
import 'package:flutter_boilerplate_app/bloc/constant/style.dart';
import 'package:flutter_boilerplate_app/bloc/util/responsive_screen.dart';
import 'package:stacked_services/stacked_services.dart';
import 'hide_keyboard.dart';
import 'show_snackbar.dart';

Future showInputTakerBottomSheet({
  required BuildContext context,
  String title = 'Your Input',
  bool isMultiLine = true,
  String hint = "Write Something...",
  TextInputType inputType = TextInputType.text,
  bool allowEmptyResult = true,
  String initialValue = '',
}) async {
  return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: ksBottomPanelShape,
      clipBehavior: Clip.hardEdge,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height *
              kFullScreenBottomSheetHeightPercentage,
          child: InputTakerBottomSheetWidget(
            title: title,
            isMultiLine: isMultiLine,
            initialValue: initialValue,
            hint: hint,
            allowEmptyResult: allowEmptyResult,
            inputType: inputType,
          ),
        );
      });
}

class InputTakerBottomSheetWidget extends StatefulWidget {
  InputTakerBottomSheetWidget({
    required this.title,
    required this.isMultiLine,
    required this.hint,
    required this.initialValue,
    required this.allowEmptyResult,
    required this.inputType,
  });

  final String title;
  final String initialValue;
  final String hint;
  final bool isMultiLine;
  final bool allowEmptyResult;
  final TextInputType inputType;

  @override
  _InputTakerBottomSheetWidgetState createState() =>
      _InputTakerBottomSheetWidgetState();
}

class _InputTakerBottomSheetWidgetState
    extends State<InputTakerBottomSheetWidget> {
  FocusNode _node = FocusNode();
  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _textController.text = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(ScreenSpec.margin),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                _buildButton(
                    context: context,
                    func: () {
                      hideKeyboard();
                      locator<NavigationService>().back();
                    },
                    titleColor: kcWarning,
                    title: 'Cancel'),
                Expanded(
                  child: Text(
                    widget.title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: kcCaption),
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.fade,
                  ).text.minFontSize(kMinFontSize).make(),
                ),
                _buildButton(
                    context: context,
                    func: () {
                      hideKeyboard();

                      if (widget.allowEmptyResult) {
                        locator<NavigationService>()
                            .back(result: _textController.text.trim());
                      } else {
                        if (_textController.text.trim().isEmpty) {
                          showSnackbar(text: 'Field can not be empty');
                        } else {
                          locator<NavigationService>()
                              .back(result: _textController.text.trim());
                        }
                      }
                    },
                    title: 'Confirm'),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: TextField(
                  controller: _textController,
                  focusNode: _node,
                  keyboardType: widget.isMultiLine
                      ? TextInputType.multiline
                      : widget.inputType,
                  maxLines: !widget.isMultiLine ? 1 : 50,
                  style: Theme.of(context).textTheme.subtitle2,
                  decoration: InputDecoration(
                    hintText: widget.hint,
                    hintStyle: Theme.of(context).textTheme.caption,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required Function func,
    required String title,
    Color titleColor = kcAccent,
  }) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 0, vertical: ScreenSpec.marginSmall),
      child: MaterialButton(
        onPressed: ()=> func,
        child: Text(
          title,
          maxLines: 1,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: titleColor,
              ),
        ).text.make(),
        shape: RoundedRectangleBorder(
          borderRadius: ksBorderRadiusRound,
        ),
      ),
    );
  }
}
