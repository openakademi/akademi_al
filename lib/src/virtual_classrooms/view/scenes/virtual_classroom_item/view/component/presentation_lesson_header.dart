

import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:akademi_al_mobile_app/packages/uploader_repository/lib/uploader_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PresentationLessonHeader extends StatelessWidget {

  final Lessons lesson;

  const PresentationLessonHeader({Key key, this.lesson}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getPdfDocument(context),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          print("${snapshot.data}");
          return Container(
            height: 209.h,
            child: Center(
              child:
              PDF(
                swipeHorizontal: true,
              ).fromUrl(snapshot.data)
            ),
          );
        } else {
          return Container(
            height: 209.h,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      }
    );
  }

  Future<String>_getPdfDocument(BuildContext context) async {
    final authenticationRepository =
    RepositoryProvider.of<AuthenticationRepository>(context);
    UploaderRepository uploaderRepository =
    new UploaderRepository(authenticationRepository);
    var s3FilePath = await uploaderRepository.getS3UrlForAction(
        "${lesson.file.filePath}/${lesson.file.name}",
        S3ActionType.DOWNLOAD);

    return s3FilePath;
  }
}