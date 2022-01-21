import 'dart:async';
import 'dart:io';

import 'package:akademi_al_mobile_app/components/button/button.dart';
import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/extentions/file_extensions.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/onboarding/profile_picture_file.dart';
import 'package:akademi_al_mobile_app/packages/uploader_repository/lib/uploader_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class Uploader extends StatefulWidget {
  final Function onUpload;
  final AuthenticationRepository authenticationRepository;
  UploaderRepository uploaderRepository;
  final ProfilePictureFile file;

  Uploader({Key key, this.onUpload, this.authenticationRepository, this.file})
      : super(key: key) {
    uploaderRepository = new UploaderRepository(authenticationRepository);
  }

  @override
  State<StatefulWidget> createState() {
    return _UploaderState(loading: file != null, file: file);
  }
}

class _UploaderState extends State<Uploader> {
  File _image;
  final picker = ImagePicker();
  bool loading = false;
  StreamController<String> controller;
  ProfilePictureFile file;
  bool uploading = false;

  _UploaderState({this.loading, this.file});

  @override
  void initState() {
    super.initState();
    controller = new StreamController<String>();
    loadImage();
  }

  showModal(BuildContext context) {
    final s = S.of(context);
    showModalBottomSheet(
        context: context,
        elevation: 4,
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
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 16.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 2,
                          child: MainButton(
                            onPress: () {
                              setState(() {
                                // selectedDate = null;
                                getImage(ImageSource.camera);
                                Navigator.pop(context);
                              });
                            },
                            size: ButtonSize.Small,
                            text: "Kamera",
                            prefixIcon: Icon(RemixIcons.camera_fill, color: Colors.white, size: 18.sp,),
                          ),
                        ),
                        Spacer(flex: 1),
                        Flexible(
                          flex: 2,
                          child: MainButton(
                            onPress: () {
                              setState(() {
                                getImage(ImageSource.gallery);
                                Navigator.pop(context);
                              });
                            },
                            ghost: true,
                            prefixIcon: Icon(RemixIcons.image_fill, color: AntColors.blue6, size: 18.sp,),
                            size: ButtonSize.Small,
                            text: "Galeri",
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

  Future getImage(ImageSource source) async {
    setState(() {
      uploading = true;
    });
    final pickedFile = await picker.getImage(
        source: source, preferredCameraDevice: CameraDevice.front);
    if (pickedFile != null && pickedFile.path != null) {
      File croppedFile = await ImageCropper.cropImage(
          sourcePath: pickedFile.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          maxWidth: 100,
          maxHeight: 100,
          compressQuality: 60);
      if(croppedFile == null) {
        setState(() {
          uploading = false;
        });
        return;
      } else {
        final userId =
        await this.widget.authenticationRepository.getCurrentUserId();
        final s3Path = await this.widget.uploaderRepository.getS3UrlForAction(
            "avatar/$userId/${croppedFile.name}", S3ActionType.UPLOAD);
        await this.widget.uploaderRepository.uploadFile(croppedFile, s3Path);
        setState(() {
          controller.add("");
          uploading = false;
          _image = File(croppedFile.path);
          file = new ProfilePictureFile(
              id: Uuid().v4().toString(),
              name: croppedFile.name,
              contentType: "image/jpeg",
              size: croppedFile.lengthSync(),
              filePath: "avatar/$userId",
              createdBy: userId,
              updatedBy: userId);
          this.widget.onUpload(file);
        });
      }
    }
    setState(() {
      uploading = false;
    });
  }

  loadImage() async {
    if (loading) {
      final existingFile = await this
          .widget
          .uploaderRepository
          .getS3UrlForAction(
              "${this.widget.file.filePath}/${this.widget.file.name}",
              S3ActionType.DOWNLOAD);
      setState(() {
        loading = false;
      });
      controller.add(existingFile);
    } else {
      controller.add("");
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return GestureDetector(
      onTap: () {
        showModal(context);
      },
      child: StreamBuilder<String>(
          stream: controller.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if(uploading) {
                return CircularProgressIndicator();
              }
              if (snapshot.data == "") {
                return Container(
                  height: 60.h,
                  child: loading
                      ? CircularProgressIndicator(
                          // backgroundColor: Colors.white,
                        )
                      : _image != null
                          ? Image.file(_image)
                          : SizedBox(
                              height: 60.h,
                              // width: 55.h,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    RemixIcons.upload_2_line,
                                    color: AntColors.blue6,
                                    size: 24.sp,
                                  ),
                                  BaseText(
                                    padding: EdgeInsets.zero,
                                    type: TextTypes.p1,
                                    textColor: AntColors.blue6,
                                    text: s.upload,
                                  )
                                ],
                              ),
                            ),
                );
              } else {
                return Container(
                    height: 60.h,
                    child: Image.network(
                      snapshot.data,
                      fit: BoxFit.fill,
                    ));
              }
            } else {
              return Container(
                width: 0,
              );
            }
          }),
    );
  }
}
