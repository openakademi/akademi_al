import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:flutter/material.dart';

import 'button_utils.dart';

class MainTextButton extends StatelessWidget {
  final Function onPress;
  final String text;
  final Widget customText;
  final ButtonSize size;

  const MainTextButton(
      {Key key, this.onPress, this.text, this.customText, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      child: customText != null
          ? customText
          : new BaseText(
              text: text,
              textColor: AntColors.blue6,
            ),
      style: new ButtonStyle(
          padding: size != null
              ? MaterialStateProperty.all(ButtonSizeToEdgeInsets[size])
              : MaterialStateProperty.all(EdgeInsets.zero),
          enableFeedback: false,
          elevation: MaterialStateProperty.all(0),
          overlayColor: MaterialStateProperty.all(Colors.transparent)),
    );
  }
}
