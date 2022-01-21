import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/models/enrollment/enrollment_entity.dart';
import 'package:akademi_al_mobile_app/packages/models/user/classroom_entity.dart';
import 'package:akademi_al_mobile_app/src/home/bloc/home_bloc.dart';
import 'package:akademi_al_mobile_app/src/home/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VirtualClassTile extends StatelessWidget {
  final ClassroomEntity classroom;
  final String classroomId;
  final EnrollmentEntity enrollment;
  final bool strech;
  final Function onClick;
  final bool forceClick;

  const VirtualClassTile(
      {Key key, this.classroom, this.enrollment, this.strech = false, this.classroomId, this.onClick, this.forceClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return GestureDetector(
      onTap: () {
        if(!strech) {
          if(onClick != null) {
            onClick();
          } else {
            context.read<HomeBloc>().add(NavigationItemChanged(
                NavigationItemKey.VIRTUAL_CLASSROOM, classroomId, enrollment));
          }
        }
        if(forceClick != null && forceClick) {
          onClick();
        }
      },
      child: Container(
        // height: 245.h,
        width: !strech ? 284.w : double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(6.0),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: !strech ? 297.w : double.infinity,
              height: 155.h,
              decoration: BoxDecoration(
                  color: AntColors.blue6,
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage(
                        strech
                            ? "assets/images/classrooms/classrooms.png"
                            : "assets/images/classrooms_medium/classrooms_medium.png",
                      )),
                  borderRadius: BorderRadius.all(
                    Radius.circular(6.0),
                  )),
              child:
                  classroom.requireApproval != null && classroom.requireApproval
                      ? Column(
                          children: [
                            Icon(
                              RemixIcons.login_box_line,
                              color: AntColors.blue6,
                              size: 24.sp,
                            ),
                            BaseText(
                              text: s.waiting_for_approval,
                              type: TextTypes.d2,
                              textColor: AntColors.gray8,
                            ),
                            BaseText(
                              text: s.send_on(enrollment.enrolledAt),
                              type: TextTypes.d2,
                              textColor: AntColors.gray7,
                            )
                          ],
                        )
                      : classroom.fileUrl != null
                          ? Image.network(
                              classroom.fileUrl,
                              width: strech ? 297.w : double.infinity,
                              height: 155.h,
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, a) {
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
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                child: BaseText(
                  text: classroom.organization?.name,
                  type: TextTypes.d1,
                  textColor: AntColors.gray7,
                ),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            BaseText(
              text: classroom.name,
              type: TextTypes.p2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 4.h,
            ),
            Row(
              children: [
                Icon(
                  RemixIcons.user_2_line,
                  size: 14.sp,
                  color: AntColors.gray7,
                ),
                SizedBox(
                  width: 6.3.w,
                ),
                BaseText(
                  type: TextTypes.d2,
                  text:
                      "${classroom.userCreatedBy.firstName} ${classroom.userCreatedBy.lastName}",
                  textColor: AntColors.gray7,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
