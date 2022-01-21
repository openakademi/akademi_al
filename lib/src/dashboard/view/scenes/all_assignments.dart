import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/models/classroom/assignment_user_commit.dart';
import 'package:akademi_al_mobile_app/packages/models/user/classroom_entity.dart';
import 'package:akademi_al_mobile_app/src/dashboard/view/components/assignment_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllAssignments extends StatelessWidget {
  final List<ClassroomEntity> allClassrooms;
  final Function navigateToClassrom;
  final List<AssignmentUserCommit> userCommits;

  const AllAssignments({Key key, this.allClassrooms, this.navigateToClassrom, this.userCommits})
      : super(key: key);

  static Route route(
      List<ClassroomEntity> allClassrooms, Function navigateToClassrom, List<AssignmentUserCommit> userCommits) {
    return MaterialPageRoute<void>(
        builder: (_) => AllAssignments(
              allClassrooms: allClassrooms,
              navigateToClassrom: navigateToClassrom,
              userCommits: userCommits,
            ));
  }

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 1,
          title: new BaseText(
            text: s.assignments,
            letterSpacing: -0.4,
            weightType: FontWeight.w600,
            lineHeight: 1.21,
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(RemixIcons.arrow_left_line, color: AntColors.blue6),
            onPressed: () => {Navigator.of(context).pop()},
          ),
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 16.h,
                ),
                ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 16.w,
                      );
                    },
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: allClassrooms.length,
                    itemBuilder: (context, index) {
                      return AssignmentTile(
                        classroom: allClassrooms[index],
                        navigateToClassroom: (classroomId) {
                          Navigator.of(context).pop();
                          if (navigateToClassrom != null) {
                            navigateToClassrom(classroomId);
                          }
                        },
                          userCommits: userCommits,
                      );
                    }),
              ],
            ),
          ),
        ));
  }
}
