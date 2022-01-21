import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/async_subject.dart';
import 'package:akademi_al_mobile_app/src/subjects/async_subjects/view/scenes/async_classrooms_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubjectTile extends StatelessWidget {
  final AsyncSubject subject;

  const SubjectTile({Key key, this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Future.delayed(Duration.zero, () {
          Navigator.of(context).push(AsyncClassroomsList.route(subject));
        });
      },
      child: new Card(
        elevation: 0,
        child: GridTile(
          child: Column(
            children: [
              Container(
                height: 89.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  gradient: LinearGradient(
                      colors: [AntColors.blue8, AntColors.blue6],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                ),
                child: Center(
                  child: Icon(
                    RemixIcons.MapForm[subject.icon.replaceAll("-", "_")],
                    size: 40.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.centerLeft,
                child: BaseText(
                    overflow: TextOverflow.ellipsis,
                    letterSpacing: 0,
                    fontSize: 14.sp,
                    weightType: FontWeight.w600,
                    textColor: AntColors.gray9,
                    text: subject.name),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
