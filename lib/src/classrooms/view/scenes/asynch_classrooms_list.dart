import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/models/enrollment/enrollment_entity.dart';
import 'package:akademi_al_mobile_app/src/classrooms/view/components/async_class_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AsynchClassroomsList extends StatelessWidget {
  final List<EnrollmentEntity> enrollments;

  const AsynchClassroomsList({Key key, this.enrollments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          text: s.async_classrooms,
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(left: 20.0.w, right: 20.w, top: 20.h),
          child: GridView.builder(
              itemCount: enrollments.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 24.h,
                  crossAxisSpacing: 20.w,
                  childAspectRatio: 1.01),
              itemBuilder: (context, index) {
                final classroom = enrollments[index].classroom;
                final enrollment = enrollments.toList()[index];
                return AsyncClassTile(
                  enrollment: enrollment,
                  classroom: classroom,
                );
              }),
        ),
      ),
    );
  }
}
