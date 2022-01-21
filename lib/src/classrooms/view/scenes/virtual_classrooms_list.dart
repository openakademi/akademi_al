import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/models/enrollment/enrollment_entity.dart';
import 'package:akademi_al_mobile_app/src/classrooms/view/components/virtual_class_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VirtualClassroomsList extends StatelessWidget {
  final List<EnrollmentEntity> enrollments;
  final Function openAddClassroomModal;
  final Function onTap;

  const VirtualClassroomsList(
      {Key key, this.enrollments, this.openAddClassroomModal, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("building list");
    final S s = S.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(RemixIcons.arrow_left_line, color: AntColors.blue6),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 1,
        title: BaseText(
          type: TextTypes.h6,
          text: s.virtual_classrooms,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.0.w),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                this.openAddClassroomModal();
              },
              child: Row(
                children: [
                  Icon(
                    RemixIcons.add_circle_line,
                    size: 24.sp,
                    color: AntColors.blue6,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  BaseText(
                    text: s.add,
                    type: TextTypes.p2,
                    textColor: AntColors.blue6,
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(left: 20.0.w, right: 20.w, top: 20.h),
          child: ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 16.h,
                );
              },
              padding: EdgeInsets.zero,
              itemCount: enrollments.length,
              itemBuilder: (context, index) {
                final classroom = enrollments[index].classroom;
                final enrollment = enrollments[index];
                classroom.id = enrollment.classroomId;
                return VirtualClassTile(
                  enrollment: enrollment,
                  classroom: classroom,
                  strech: true,
                  classroomId: enrollment.classroomId,
                  forceClick: true,
                  onClick: () {
                    Navigator.of(context).pop();
                    onTap(classroom);
                  },
                );
              }),
        ),
      ),
    );
  }
}
