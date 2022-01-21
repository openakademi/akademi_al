import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'button_utils.dart';

class MainButton extends StatelessWidget {
  final String text;
  final Function onPress;
  final ButtonSize size;
  final bool ghost;
  final double width;
  final double height;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final bool disabled;
  final bool loading;
  final Widget iconButton;

  const MainButton(
      {Key key,
      this.onPress,
      this.text,
      this.size = ButtonSize.Medium,
      this.ghost = false,
      this.width,
      this.height,
      this.suffixIcon,
      this.disabled = false,
      this.prefixIcon,
      this.loading,
      this.iconButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: disabled ? null : onPress,
        onLongPress: null,
        minWidth: width,
        height: height,
        color: ghost ? Colors.white : AntColors.blue6,
        padding: ButtonSizeToEdgeInsets[size],
        disabledColor: AntColors.gray3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
            side: BorderSide(
                color: disabled ? AntColors.gray3 : AntColors.blue6)),
        child: loading != null && loading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: ghost ? AntColors.blue6 : Colors.white,
                  strokeWidth: 3,
                ),
              )
            : size == ButtonSize.Zero
                ? Container(
                    width: width,
                    height: height,
                    child: BaseText(
                        padding: EdgeInsets.zero,
                        text: "$text",
                        textColor: disabled
                            ? AntColors.gray6
                            : ghost
                                ? AntColors.blue6
                                : Colors.white,
                        weightType: FontWeight.w500,
                        align: TextAlign.center),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    textBaseline: TextBaseline.alphabetic,
                    crossAxisAlignment: suffixIcon != null || prefixIcon != null
                        ? CrossAxisAlignment.baseline
                        : CrossAxisAlignment.center,
                    children: [
                      if (prefixIcon != null)
                        Padding(
                          padding: EdgeInsets.only(right: 11.5.h),
                          child: prefixIcon,
                        ),
                      iconButton != null ? iconButton :BaseText(
                          text: "$text",
                          textColor: disabled
                              ? AntColors.gray6
                              : ghost
                                  ? AntColors.blue6
                                  : Colors.white,
                          weightType: FontWeight.w500,
                          align: TextAlign.start),
                      if (suffixIcon != null)
                        Padding(
                          padding: EdgeInsets.only(left: 11.6.h),
                          child: suffixIcon,
                        )
                    ],
                  ));
  }
}
