import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/skeleton_list/skeleton_list.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/components/user_avatar/user_avatar.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/enrollment/enrollment_entity.dart';
import 'package:akademi_al_mobile_app/packages/models/user/classroom_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'component/pupil_entry.dart';

class VirtualClassroomPupils extends StatelessWidget {
  final List<EnrollmentEntity> pupils;
  final UserCreatedBy teacher;
  final String teacherId;

  const VirtualClassroomPupils(
      {Key key, this.pupils, this.teacher, this.teacherId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    pupils.sort((a, b) {
      return a.user.firstName.compareTo(b.user.firstName);
    });
    final S s = S.of(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: AntColors.blue1,
            height: 40.h,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20.0.w),
                child: BaseText(
                  text: s.teacher,
                  type: TextTypes.h6,
                  align: TextAlign.start,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Container(
            height: 48.h,
            child: Row(
              children: [
                SizedBox(
                  width: 20.w,
                ),
                UserAvatar(
                  userId: teacherId,
                ),
                SizedBox(
                  width: 12.w,
                ),
                BaseText(
                  text: "${teacher.firstName} ${teacher.lastName}",
                  type: TextTypes.d1,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Container(
            color: AntColors.blue1,
            height: 40.h,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20.0.w),
                child: BaseText(
                  text: s.pupils,
                  type: TextTypes.h6,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          FutureBuilder<String>(
              future: _isCurrentUser(context),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Flexible(
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 8.h,
                          );
                        },
                          shrinkWrap: true,
                          itemCount: pupils.length,
                          itemBuilder: (context, index) {
                            final EnrollmentEntity pupil = pupils[index];
                            return PupilEntry(
                              pupil: pupil,
                              currentUserId: snapshot.data,
                            );
                          }));
                } else {
                  return Flexible(child: SkeletonList());
                }
              })
        ],
      ),
    );
  }

  Future<String> _isCurrentUser(context) async {
    final AuthenticationRepository authenticationRepository =
        RepositoryProvider.of<AuthenticationRepository>(context);
    final userId = await authenticationRepository.getCurrentUserId();
    return userId;
  }
}
