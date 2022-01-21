import 'dart:async';
import 'dart:io';

import 'package:akademi_al_mobile_app/components/button/button.dart';
import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/extentions/file_extensions.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/file_entity.dart'
    as FileEntity;
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:akademi_al_mobile_app/packages/models/classroom/assignment_user_commit.dart';
import 'package:akademi_al_mobile_app/packages/models/classroom/create_assignment_user_commit.dart';
import 'package:akademi_al_mobile_app/packages/uploader_repository/lib/uploader_repository.dart';
import 'package:akademi_al_mobile_app/packages/user_commits/user_commits_repository.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_item/bloc/lesson_item_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AssignmentUploader extends StatefulWidget {
  final Lessons lesson;
  final AssignmentUserCommit assignmentUserCommit;

  const AssignmentUploader({Key key, this.lesson, this.assignmentUserCommit})
      : super(key: key);

  @override
  _AssignmentUploaderState createState() => _AssignmentUploaderState();
}

class _AssignmentUploaderState extends State<AssignmentUploader> {
  final picker = ImagePicker();
  AuthenticationRepository authenticationRepository;
  UploaderRepository uploaderRepository;
  StreamController<String> controller;
  AssignmentUserCommit assignmentUserCommit;
  List<FileEntity.File> filesUploaded;
  UserCommitsRepository userCommitsRepository;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return FutureBuilder<List<Widget>>(
        future: _getPreviewFiles(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                assignmentUserCommit != null && assignmentUserCommit.isCommitted ?
                    BaseText(
                      align: TextAlign.start,
                      text: s.submitted_assignment,
                      type: TextTypes.d1,
                      textColor: AntColors.gray7,
                    )
                    :Container(),
                SizedBox(
                  height: 8.h,
                ),
                ...snapshot.data,
                SizedBox(
                  height: 8.h,
                ),
                assignmentUserCommit != null && assignmentUserCommit.isCommitted != null && !assignmentUserCommit.isCommitted ? BaseText(
                  text: s.click_on_commit_assignment,
                  type: TextTypes.d1,
                ): Divider(height: 1,),
                assignmentUserCommit != null && assignmentUserCommit.isCommitted != null && !assignmentUserCommit.isCommitted ? SizedBox(
                  height: 40.h,
                ) : SizedBox(
                  height: 8.h,
                ),
                assignmentUserCommit != null && assignmentUserCommit.isCommitted
                    ? Container()
                    : MainButton(
                        size: ButtonSize.Small,
                        width: 44.h,
                        height: 44.h,
                        ghost: true,
                        disabled: loading,
                        prefixIcon: Icon(
                          RemixIcons.add_line,
                          color: loading ? AntColors.gray6 : AntColors.blue6,
                          size: 18.sp,
                        ),
                        onPress: () {
                          showModal(context);
                        },
                        text: s.upload_assignment,
                      ),
                assignmentUserCommit != null &&
                        assignmentUserCommit.isEvaluated != null &&
                        assignmentUserCommit.isEvaluated
                    ? Container(
                        height: 64,
                        decoration: BoxDecoration(
                          border: Border.all(color: AntColors.gray5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(6.0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                          child: Row(children: [
                            Icon(
                              RemixIcons.shield_star_line,
                              color: AntColors.blue6,
                              size: 24.sp,
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Expanded(
                              child: BaseText(
                                text: s.grade_evaluation(
                                    assignmentUserCommit.grade != null ? assignmentUserCommit.grade :""),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ]),
                        ),
                      )
                    : Container()
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  @override
  void initState() {
    super.initState();
    authenticationRepository =
        RepositoryProvider.of<AuthenticationRepository>(context);
    uploaderRepository = UploaderRepository(authenticationRepository);
    controller = new StreamController<String>();
    assignmentUserCommit = widget.assignmentUserCommit;
    filesUploaded = assignmentUserCommit != null
        ? assignmentUserCommit.assignmentUserCommitFiles
            .map((e) => e.file)
            .toList()
        : [];
    assignmentUserCommit = widget.assignmentUserCommit;
    userCommitsRepository = UserCommitsRepository(
        authenticationRepository: authenticationRepository);
  }


  @override
  void didUpdateWidget(AssignmentUploader oldWidget) {
    super.didUpdateWidget(oldWidget);
    assignmentUserCommit = widget.assignmentUserCommit;
  }

  _saveAssignmentUserCommit(String userId, FileEntity.File newFile) async {
    setState(() {
      loading = true;
    });
    List<AssignmentUserCommitFile> newFileList = [];
    AssignmentUserCommitFile newAssignmentFile =
        AssignmentUserCommitFile(id: Uuid().v4().toString(), file: newFile);

    if (assignmentUserCommit != null &&
        assignmentUserCommit.assignmentUserCommitFiles != null) {
      newFileList = assignmentUserCommit.assignmentUserCommitFiles
          .map((e) => AssignmentUserCommitFile(
              id: Uuid().v4().toString(),
              file: FileEntity.File(
                  id: Uuid().v4().toString(),
                  createdBy: userId,
                  updatedBy: userId,
                  name: e.file.name,
                  filePath: e.file.filePath,
                  contentType: e.file.contentType,
                  size: e.file.size)))
          .toList();
    }

    if (newFileList != null && newFile != null) {
      newFileList.add(newAssignmentFile);
    }

    final newAssignmentUserCommit = AssignmentUserCommit(
        id: Uuid().v4().toString(),
        userId: userId,
        description: "",
        isCommitted: false,
        isEvaluated: false,
        lessonId: widget.lesson.id,
        assignmentUserCommitFiles: newFileList);

    final savedAssignmentUserCommit = await userCommitsRepository
        .createAssignmentUserCommit(newAssignmentUserCommit);
    context
        .read<LessonItemBloc>()
        .add(NewAssignmentUserCommit(savedAssignmentUserCommit));
    setState(() {
      assignmentUserCommit = savedAssignmentUserCommit;
      filesUploaded = savedAssignmentUserCommit != null
          ? savedAssignmentUserCommit.assignmentUserCommitFiles
              .map((e) => e.file)
              .toList()
          : [];
      loading = false;
    });
  }

  showModal(BuildContext context) {
    final s = S.of(context);
    showModalBottomSheet(
        context: context,
        elevation: 4,
        barrierColor: Color.fromRGBO(22, 24, 35, 0.4),
        builder: (context) {
          return Container(
            height: 206.h,
            color: Color(0xFF737373),
            child: Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 24.0.h),
                        child: Center(
                          child: Container(
                            width: 56.w,
                            height: 6.h,
                            decoration: BoxDecoration(
                                color: AntColors.gray3,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          padding: EdgeInsets.only(
                              top: 16.h, bottom: 16.h, right: 16.w),
                          icon: Icon(RemixIcons.close_fill),
                          iconSize: 24.sp,
                          color: AntColors.gray6,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  ),
                  BaseText(
                    text: s.upload,
                    fontSize: 20.sp,
                    letterSpacing: -1,
                    lineHeight: 1.3,
                    weightType: FontWeight.w600,
                    align: TextAlign.center,
                  ),
                  Divider(
                    color: AntColors.gray6,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.0.w, vertical: 16.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: MainButton(
                            onPress: () async {
                              Navigator.pop(context);
                              await _getFile();
                            },
                            size: ButtonSize.Small,
                            text: "File",
                            prefixIcon: Icon(
                              RemixIcons.file_add_line,
                              color: Colors.white,
                              size: 18.sp,
                            ),
                          ),
                        ),
                        // Spacer(flex: 1),
                        SizedBox(
                          width: 20.w,
                        ),
                        Expanded(
                          flex: 2,
                          child: MainButton(
                            onPress: () {
                              setState(() {
                                getImage(ImageSource.camera);
                                Navigator.pop(context);
                              });
                            },
                            ghost: true,
                            prefixIcon: Icon(
                              RemixIcons.camera_fill,
                              color: AntColors.blue6,
                              size: 18.sp,
                            ),
                            size: ButtonSize.Small,
                            text: "Kamera",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _getPreviewFiles() {
    return Future.wait(filesUploaded.map((e) async {
      if (e.contentType.contains("image")) {
        var s3FilePath = await uploaderRepository.getS3UrlForAction(
            "${e.filePath}/${e.name}", S3ActionType.DOWNLOAD);
        return _UploadedItem(
          child: Center(
            child: Row(
              children: [
                SizedBox(
                  width: 8.w,
                ),
                CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: s3FilePath,
                  imageBuilder: (context, imageProvider) => Container(
                    height: 48.h,
                    width: 48.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      image: DecorationImage(image: imageProvider),
                    ),
                  ),
                  placeholder: (context, url) => Container(),
                  errorWidget: (context, url, error) => Container(),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                  child: BaseText(
                    text: e.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: 24.w,
                ),
              ],
            ),
          ),
          onRemove: () async {
            await _removeFile(e);
          },
          assignmentUserCommit: assignmentUserCommit,
        );
      } else {
        return _UploadedItem(
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 8.w,
                ),
                Container(
                  height: 48.h,
                  width: 48.h,
                  decoration: BoxDecoration(
                    color: AntColors.blue1,
                    border: Border.all(color: AntColors.gray5),
                    borderRadius: BorderRadius.all(
                      Radius.circular(6.0),
                    ),
                  ),
                  child:
                      Icon(RemixIcons.file_text_line, color: AntColors.blue6),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                  child: BaseText(
                    text: e.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: 24.w,
                ),
              ],
            ),
          ),
          onRemove: () async {
            await _removeFile(e);
          },
          assignmentUserCommit: assignmentUserCommit,
        );
      }
    }));
  }

  _removeFile(FileEntity.File fileToRemove) async {
    setState(() {
      loading = true;
    });

    final index = assignmentUserCommit.assignmentUserCommitFiles
        .indexWhere((element) => element.fileId == fileToRemove.id);

    setState(() {
      if (index >= 0) {
        assignmentUserCommit.assignmentUserCommitFiles.removeAt(index);
      }
    });
    final userId = await this.authenticationRepository.getCurrentUserId();

    await _saveAssignmentUserCommit(userId, null);
  }

  Future _getFile() async {
    setState(() {
      loading = true;
    });

    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path);
      final userId = await this.authenticationRepository.getCurrentUserId();
      final s3Path = await this.uploaderRepository.getS3UrlForAction(
          "lesson/${widget.lesson.id}/student/$userId/assignment/${file.name}",
          S3ActionType.UPLOAD);
      await this.uploaderRepository.uploadFile(file, s3Path);
      var fileEntity = new FileEntity.File(
          id: Uuid().v4().toString(),
          name: file.name,
          contentType: file.type,
          size: file.lengthSync(),
          filePath: "lesson/${widget.lesson.id}/student/$userId/assignment",
          createdBy: userId,
          updatedBy: userId);
      setState(() {
        filesUploaded.add(fileEntity);
      });

      await _saveAssignmentUserCommit(userId, fileEntity);
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  Future getImage(ImageSource source) async {
    setState(() {
      loading = true;
    });
    final pickedFile = await picker.getImage(
        source: source, preferredCameraDevice: CameraDevice.front);
    if (pickedFile != null && pickedFile.path != null) {
      File croppedFile = File(pickedFile.path);
      final userId = await this.authenticationRepository.getCurrentUserId();
      final s3Path = await this.uploaderRepository.getS3UrlForAction(
          "lesson/${widget.lesson.id}/student/$userId/assignment/${croppedFile.name}",
          S3ActionType.UPLOAD);
      final length = await croppedFile.length();
      await this.uploaderRepository.uploadFile(croppedFile, s3Path);
      var fileEntity = new FileEntity.File(
          id: Uuid().v4().toString(),
          name: croppedFile.name,
          contentType: "image/jpeg",
          size: croppedFile.lengthSync(),
          filePath: "lesson/${widget.lesson.id}/student/$userId/assignment",
          createdBy: userId,
          updatedBy: userId);
      setState(() {
        controller.add("");
        filesUploaded.add(fileEntity);
      });
      await _saveAssignmentUserCommit(userId, fileEntity);
      // this.widget.onUpload(file);
    } else {
      setState(() {
        loading = false;
      });
    }
  }
}

class _UploadedItem extends StatelessWidget {
  final Widget child;
  final Function onRemove;
  final AssignmentUserCommit assignmentUserCommit;

  const _UploadedItem(
      {Key key, this.child, this.onRemove, this.assignmentUserCommit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          border: Border.all(color: AntColors.gray5),
          borderRadius: BorderRadius.all(
            Radius.circular(6.0),
          ),
        ),
        child: Stack(
          children: [
            assignmentUserCommit != null && assignmentUserCommit.isCommitted != null && ! assignmentUserCommit.isCommitted ? Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  if (onRemove != null) {
                    onRemove();
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 8.0.h, right: 8.w),
                  child: Icon(RemixIcons.close_line,
                      size: 16.sp, color: AntColors.gray7),
                ),
              ),
            ): Container(),
            Center(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
