import 'package:akademi_al_mobile_app/components/button/button.dart';
import 'package:akademi_al_mobile_app/components/button/lib/main_button.dart';
import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/models/user/classroom_entity.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VirtualClassroomDetails extends StatelessWidget {
  final ClassroomEntity classroomEntity;
  final Function unregisterFunction;

  const VirtualClassroomDetails(
      {Key key, this.classroomEntity, this.unregisterFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        leading: Container(),
        title: BaseText(
          text: s.more_about_classroom,
          textColor: AntColors.gray9,
          weightType: FontWeight.w600,
        ),
        actions: [
          IconButton(
              icon: Icon(
                RemixIcons.close_fill,
                size: 24.sp,
                color: AntColors.gray6,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ],
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(left: 20.0, top: 40.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseText(
                  text: s.virtual_classroom_name,
                  type: TextTypes.h5,
                  textColor: AntColors.gray8),
              SizedBox(
                height: 8.h,
              ),
              BaseText(text: classroomEntity.name, textColor: AntColors.gray8),
              SizedBox(
                height: 20.h,
              ),
              BaseText(
                  text: s.virtual_class_code,
                  type: TextTypes.h5,
                  textColor: AntColors.gray8),
              SizedBox(
                height: 8.h,
              ),
              Row(
                children: [
                  BaseText(
                      text: classroomEntity.code, textColor: AntColors.gray8),
                  SizedBox(
                    width: 12.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(
                          new ClipboardData(text: classroomEntity.code));
                      Flushbar(
                        flushbarPosition: FlushbarPosition.BOTTOM,
                        messageText: BaseText(
                          type: TextTypes.d1,
                          weightType: FontWeight.w600,
                          text: s.classroom_code_copied,
                          textColor: Colors.white,
                        ),
                        backgroundColor: AntColors.green6,
                        duration: Duration(seconds: 5),
                      )..show(context);
                    },
                    child: Icon(
                      RemixIcons.file_copy_line,
                      color: AntColors.gray8,
                      size: 20.sp,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              BaseText(
                  text: s.school,
                  type: TextTypes.h5,
                  textColor: AntColors.gray8),
              SizedBox(
                height: 8.h,
              ),
              BaseText(
                  text: classroomEntity.organization.name,
                  textColor: AntColors.gray8),
              SizedBox(
                height: 20.h,
              ),
              BaseText(
                  text: s.grade,
                  type: TextTypes.h5,
                  textColor: AntColors.gray8),
              SizedBox(
                height: 8.h,
              ),
              BaseText(
                  text: classroomEntity.gradeSubject.grade.name,
                  textColor: AntColors.gray8),
              SizedBox(
                height: 20.h,
              ),
              BaseText(
                  text: s.subject,
                  type: TextTypes.h5,
                  textColor: AntColors.gray8),
              SizedBox(
                height: 8.h,
              ),
              BaseText(
                  text: classroomEntity.gradeSubject.subject.name,
                  textColor: AntColors.gray8),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 108.h,
        decoration: BoxDecoration(color: AntColors.blue1, boxShadow: [
          BoxShadow(
            color: AntColors.boxShadow,
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(0, -2),
          )
        ]),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: MainButton(
              text: s.unregister,
              size: ButtonSize.Medium,
              height: 52.h,
              onPress: () {
                _showMaterialDialog(context, s);
                // unregisterFunction();
                // Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ),
    );
  }

  _closeAndGoHome(context) {
    unregisterFunction();
    Navigator.of(context).pop();
  }

  _showMaterialDialog(context, S s) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              contentPadding: EdgeInsets.all(16.h),
              content: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    RemixIcons.question_fill,
                    color: AntColors.gold6,
                    size: 24.sp,
                  ),
                  SizedBox(
                    width: 18.w,
                  ),
                  Expanded(
                    child: BaseText(
                      padding: EdgeInsets.zero,
                      text: s.sure_want_to_unregister_from_classroom(
                          classroomEntity.name),
                    ),
                  )
                ],
              ),
              actions: <Widget>[
                MainButton(
                  text: s.cancel,
                  ghost: true,
                  size: ButtonSize.Zero,
                  height: 32.h,
                  width: 76.w,
                  onPress: () {
                    Navigator.of(context).pop();
                  },
                ),
                MainButton(
                  text: s.yes_unregister,
                  size: ButtonSize.Zero,
                  width: 136.w,
                  height: 32.h,
                  onPress: () {
                    Navigator.of(context).pop();
                    _closeAndGoHome(context);
                  },
                )
              ],
            ));
  }
}
