import 'dart:io';

import 'package:akademi_al_mobile_app/components/button/button.dart';
import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:akademi_al_mobile_app/extentions/cupertino_extensions.dart' as CupertinoExtention;

class TextInput extends StatefulWidget {
  final Function onChanged;
  final String labelText;
  final String hintText;
  final String errorText;
  final bool isPassword;
  final double height;
  final double width;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final String initialValue;
  final bool isDatePicker;
  final TextStyle hintStyle;
  final String text;

  TextInput(
      {Key key,
      this.onChanged,
      this.labelText,
      this.errorText,
      this.isPassword = false,
      this.height,
      this.width,
      this.suffixIcon,
      this.initialValue,
      this.isDatePicker = false,
      this.prefixIcon,
      this.hintText, this.hintStyle,
      this.text
      })
      : super(key: key);

  @override
  _TextInputState createState() {
    return _TextInputState();
  }
}

class _TextInputState extends State<TextInput> {
  bool _focused = false;
  bool _visiblePassword = false;
  TextEditingController _controller;
  DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null && widget.initialValue.isNotEmpty) {
      String initialValue = widget.initialValue;
      if (widget.isDatePicker) {
        var formatter = new DateFormat.y('sq');
        DateTime initialDate = DateTime.tryParse(widget.initialValue);
        initialValue = formatter.format(initialDate).toString();
      }
      _controller = new TextEditingController(text: initialValue);
    } else {
      _controller = new TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            if (widget.isDatePicker) {
              _selectDate(context);
            }
          },
          child: Container(
            height: widget.height,
            width: widget.width,
            decoration: BoxDecoration(
                color: Colors.white,
                border: widget.errorText != null
                    ? Border.all(color: AntColors.red6)
                    : _focused
                        ? Border.all(color: AntColors.blue6)
                        : Border.all(color: AntColors.gray5),
                borderRadius: BorderRadius.all(
                  Radius.circular(6.0),
                )),
            child: Center(
              child: FocusScope(
                child: Focus(
                  onFocusChange: (focus) => {
                    setState(() {
                      _focused = !_focused;
                    })
                  },
                  child: TextField(
                    onChanged: widget.onChanged,
                    obscureText: widget.isPassword && !_visiblePassword,
                    controller: _controller,
                    enabled: !widget.isDatePicker,
                    enableSuggestions: false,
                    autofillHints: widget.isDatePicker ? null :[],
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      border: InputBorder.none,
                      hintText: widget.hintText,
                      hintStyle: widget.hintStyle ?? TextStyle(
                        color: AntColors.gray7,
                        fontSize: 12.sp,
                        height: 1.3,
                        letterSpacing: -0.25.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      focusedBorder: null,
                      enabledBorder: null,
                      labelText: widget.labelText,
                      prefixIcon: widget.prefixIcon,
                      suffixIcon: widget.isDatePicker
                          ? Icon(
                              RemixIcons.calendar_line,
                              color: AntColors.gray7,
                              size: 20.sp,
                            )
                          : widget.isPassword
                              ? IconButton(
                                  splashRadius: 20.sp,
                                  icon: Icon(
                                    _visiblePassword
                                        ? RemixIcons.eye_line
                                        : RemixIcons.eye_off_line,
                                    color: AntColors.gray7,
                                    size: 20.sp,
                                  ),
                                  onPressed: () => {
                                        setState(() {
                                          _visiblePassword =
                                              !_visiblePassword;
                                        })
                                      })
                              : widget.suffixIcon,
                      contentPadding: EdgeInsets.only(
                          left: 16.0.sp, top: 7.0.sp, bottom: 7.0.sp),
                      labelStyle: _focused
                          ?   TextStyle(
                              color: AntColors.gray7,
                              fontSize: 12.sp,
                              height: 1.3,
                              letterSpacing: -0.25.sp,
                              fontWeight: FontWeight.w400,
                            )
                          : TextStyle(
                              color: AntColors.gray6,
                              fontSize: 16.sp,
                              height: 1.5,
                              letterSpacing: -0.5.sp,
                              fontWeight: FontWeight.w400,),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        if (widget.errorText != null)
          BaseText(
            text: widget.errorText,
            fontSize: 12.0.sp,
            lineHeight: 1.3.sp,
            textColor: AntColors.red6,
            padding: EdgeInsets.only(left: 16.0.sp),
            letterSpacing: -0.25.sp,
          )
      ],
    );
  }

  buildCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
              height: 334.h,
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 200,
                    child: CupertinoExtention.CupertinoDatePicker(
                      mode: CupertinoExtention.CupertinoDatePickerMode.date,
                      onDateTimeChanged: (picked) {
                        if (picked != null && picked != selectedDate)
                          setState(() {
                            selectedDate = picked;
                          });
                      },
                      initialDateTime: selectedDate,
                      minimumYear: 1920,
                      maximumYear: DateTime.now().year,
                      // maximumDate: DateTime.now(),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 24.0.h, left: 21.w, right: 21.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 2,
                          child: MainTextButton(
                            onPress: () {
                              setState(() {
                                // selectedDate = null;
                                Navigator.pop(context);
                              });
                            },
                            size: ButtonSize.Small,
                            customText: BaseText(
                              text: "Anullo",
                              weightType: FontWeight.w500,
                              textColor: AntColors.blue6,
                            ),
                          ),
                        ),
                        Spacer(flex: 1),
                        Flexible(
                          flex: 2,
                          child: MainButton(
                            onPress: () {
                              setState(() {
                                var isAndroid =  Platform.isAndroid;
                                var formatter = isAndroid ? new DateFormat.yMMMMd('sq') : new DateFormat.y('sq');
                                if(!isAndroid) {
                                  selectedDate = DateTime(selectedDate.year);
                                }

                                widget.onChanged(selectedDate.toString());
                                _controller.text =
                                    formatter.format(selectedDate).toString();
                                Navigator.pop(context);
                              });
                            },
                            size: ButtonSize.Small,
                            text: "Zgjidh",
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ));
        });
  }

  _selectDate(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
        return buildMaterialDatePicker(context);
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      case TargetPlatform.iOS:
        return buildCupertinoDatePicker(context);
      case TargetPlatform.macOS:
    }
  }

  buildMaterialDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate != null ? selectedDate : DateTime.now(),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDatePickerMode: DatePickerMode.day,
      helpText: "Zgjidh",
      cancelText: "Anullo",
      confirmText: 'Zgjidh',
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            // primarySwatch: MaterialColor(1, {1: AntColors.blue6}),
            splashColor: AntColors.blue6
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        var formatter = new DateFormat.yMMMMd('sq');
        widget.onChanged(picked.toString());
        _controller.text = formatter.format(picked).toString();
        selectedDate = picked;
      });
    }
  }

  @override
  void didUpdateWidget(TextInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.text != widget.text) {
      _controller.text = widget.text;
    }
  }
}
