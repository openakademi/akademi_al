import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/async_subject.dart';
import 'package:akademi_al_mobile_app/packages/models/user/classroom_entity.dart';
import 'package:akademi_al_mobile_app/src/subjects/async_classroom_item/view/components/async_classroom_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AsyncClassroomTile extends StatelessWidget {

  final ClassroomEntity classroom;

  const AsyncClassroomTile({Key key, this.classroom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(AsyncClassroomItem.route(classroom.id, classroom.fileUrl, null));
      },
      child: new Card(
        elevation: 0,
        child: GridTile(
          child: Column(
            children: [
              Container(
                height: 89.h,
                decoration: BoxDecoration(
                  image: classroom.fileUrl != null ? DecorationImage(
                    image: NetworkImage(classroom.fileUrl),
                    fit: BoxFit.cover,
                  ): null,
                  borderRadius: BorderRadius.circular(6.0),
                  gradient: LinearGradient(
                      colors: [AntColors.blue8, AntColors.blue6],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                ),
                child: Center(
                  child: classroom.fileUrl == null ? Icon(
                    RemixIcons.image_line,
                    size: 40.sp,
                    color: Colors.white,
                  ): null
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
                        text: classroom.name),
                  ))
            ],
          ),
        ),
      ),
    );

  }


}