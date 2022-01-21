import 'dart:async';

import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/skeleton_list/grid_skeleton.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/async_subject.dart';
import 'package:akademi_al_mobile_app/packages/models/user/classroom_entity.dart';
import 'package:akademi_al_mobile_app/packages/uploader_repository/lib/uploader_repository.dart';
import 'package:akademi_al_mobile_app/src/subjects/async_subjects/view/components/async_classroom_tile.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AsyncClassroomsList extends StatelessWidget {
  final AsyncSubject asyncSubject;

  const AsyncClassroomsList({Key key, this.asyncSubject}) : super(key: key);

  static Route route(AsyncSubject asyncSubject) {
    return MaterialPageRoute<void>(
        builder: (_) => AsyncClassroomsList(
              asyncSubject: asyncSubject,
            ));
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Center(
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              RemixIcons.arrow_left_line,
              color: AntColors.blue6,
              size: 24.sp,
              textDirection: TextDirection.ltr,
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 13.sp),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: BaseText(
                        align: TextAlign.center,
                        text: asyncSubject.name,
                        fontSize: 32.sp,
                        weightType: FontWeight.w600,
                        // lineHeight: 0.03,
                        letterSpacing: -0.9,
                        textColor: AntColors.gray9,
                      ),
                    ),
                    Center(
                      child: Icon(
                        RemixIcons
                            .MapForm[asyncSubject.icon.replaceAll("-", "_")],
                        size: 40.sp,
                        color: AntColors.blue6,
                      ),
                    ),
                  ]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0.w,
              ),
              child:
                  BaseText(type: TextTypes.d1, text: asyncSubject.description),
            ),
            Divider(
              color: AntColors.gray5,
              thickness: 1,
            ),
            Expanded(
              child: FutureBuilder<List<ClassroomEntity>>(
                  future: _loadClassroomFiles(context),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        itemCount: snapshot.data.length,
                        gridDelegate:
                            new SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 24.h,
                                crossAxisSpacing: 20.w,
                                childAspectRatio: 1.25),
                        itemBuilder: (BuildContext context, int index) {
                          return AsyncClassroomTile(
                            classroom: snapshot.data[index],
                          );
                        },
                      );
                    } else {
                      return SkeletonGrid();
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }

  Future<List<ClassroomEntity>> _loadClassroomFiles(context) async {
    final uploaderRepository = new UploaderRepository(
        RepositoryProvider.of<AuthenticationRepository>(context));

    final classrooms = await Future.wait(asyncSubject.gradeSubjects
        .expand((element) => element.classrooms)
        .map((e) async {
      if(e.file != null) {
        final url = await uploaderRepository.getS3UrlForAction(
            "${e.file.filePath}/${e.file.name}", S3ActionType.DOWNLOAD);
        e.fileUrl = url;
      }
      return e;
    }));
    classrooms.sort((a,b) {return compareAsciiLowerCaseNatural(a.name, b.name);});
    return classrooms;
  }
}
