

import 'package:akademi_al_mobile_app/src/subjects/async_classroom_item/view/components/async_classroom_item.dart';
import 'package:flutter/material.dart';
import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/models/enrollment/enrollment_entity.dart';
import 'package:akademi_al_mobile_app/packages/models/user/classroom_entity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AsyncClassTile extends StatelessWidget {

  final ClassroomEntity classroom;
  final EnrollmentEntity enrollment;

  const AsyncClassTile({Key key, this.classroom, this.enrollment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(AsyncClassroomItem.route(enrollment.classroomId, classroom.fileUrl, null));
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(6.0),
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: AntColors.blue1,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                        image: AssetImage(
                          "assets/images/classrooms_small/classrooms_small.png",
                        )),
                    borderRadius: BorderRadius.all(
                      Radius.circular(6.0),
                    )),
                height: 89.h,
                child:  classroom.fileUrl != null
                    ? Image.network(
                  classroom.fileUrl,
                  fit: BoxFit.fill,
                  errorBuilder:
                      (context, error, a) {
                    return Icon(
                      RemixIcons.image_2_line,
                      size: 30.sp,
                      color: AntColors.blue6,
                    );
                  },
                )
                    : Center(
                    child: Icon(
                      RemixIcons.image_2_line,
                      size: 30.sp,
                      color: AntColors.blue6,
                    )),
              ),
              SizedBox(
                height: 16.h,
              ),
              Container(
                color: AntColors.gray3,
                child: classroom.organization?.name != null ? BaseText(
                  text: classroom.organization?.name,
                  type: TextTypes.d1,
                  textColor: AntColors.gray7,
                  overflow: TextOverflow.ellipsis,
                ) : Container(),
              ),
              Row(
                children: [
                  Expanded(
                    child: BaseText(
                      text: classroom.name,
                      type: TextTypes.p2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}