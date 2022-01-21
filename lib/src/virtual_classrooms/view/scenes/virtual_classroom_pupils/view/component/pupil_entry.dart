import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/components/user_avatar/user_avatar.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/models/enrollment/enrollment_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PupilEntry extends StatelessWidget {
  final EnrollmentEntity pupil;
  final String currentUserId;

  const PupilEntry({Key key, this.pupil, this.currentUserId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return Container(
      height: 48.h,
      child: Row(
        children: [
          SizedBox(
            width: 20.w,
          ),
          UserAvatar(
            userId: pupil.userId,
            enrollmentEntity: pupil,
          ),
          SizedBox(
            width: 12.w,
          ),
          BaseText(
            text: "${pupil.user.firstName} ${pupil.user.lastName}",
            type: TextTypes.d1,
          ),
          SizedBox(
            width: 8.w,
          ),
          currentUserId == pupil.userId
              ? BaseText(
                  type: TextTypes.d1,
                  text: s.me,
                )
              : Container()
        ],
      ),
    );
  }
}
