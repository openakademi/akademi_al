import 'package:akademi_al_mobile_app/components/button/button.dart';
import 'package:akademi_al_mobile_app/components/button/lib/main_button.dart';
import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/profile_picture/lib/profile_picture.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/components/uploader/uploader.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/file_entity.dart';
import 'package:akademi_al_mobile_app/packages/models/onboarding/profile_picture_file.dart';
import 'package:akademi_al_mobile_app/packages/models/user/user_avatar_entity.dart';
import 'package:akademi_al_mobile_app/packages/user_settings_repository/lib/user_settings_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ChangeAvatar extends StatefulWidget {
  final UserAvatarEntity userAvatarEntity;
  final Function updatedAvatar;

  const ChangeAvatar({Key key, this.userAvatarEntity, this.updatedAvatar}) : super(key: key);

  @override
  _ChangeAvatarState createState() => _ChangeAvatarState();
}

class _ChangeAvatarState extends State<ChangeAvatar> {
  String profilePicture;
  String profilePictureType;
  ProfilePictureFile profilePictureFile;
  bool changed = false;
  bool submitting = false;

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        leading: Center(
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              RemixIcons.close_line,
              color: AntColors.blue6,
              size: 24.sp,
              textDirection: TextDirection.ltr,
            ),
          ),
        ),
        title: BaseText(
          text: s.third_onboarding_page_title,
          type: TextTypes.p1,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 136.h,
              color: AntColors.gray2,
              child: Padding(
                padding: EdgeInsets.only(left: 20.0.w, top: 32.h),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 16.0.h),
                          child: BaseText(
                            text: s.third_onboarding_page_title,
                            type: TextTypes.h3,
                            lineHeight: 1.3,
                            textColor: AntColors.gray9,
                          ),
                        ),
                        BaseText(
                          text: s.choose_profile_picture_description,
                          textColor: AntColors.gray8,
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.0.h, left: 8.w),
                      child: ProfilePicture(
                        shape: BoxShape.circle,
                        size: 40.sp,
                        profilePicture: profilePicture,
                        profilePictureType: profilePictureType,
                        file: profilePictureFile,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 24.h),
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16.h,
                crossAxisSpacing: 20.w,
                children: List.generate(43, (index) {
                  if (index == 0) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0.sp),
                        side: BorderSide(
                          color: profilePictureType == "static"
                              ? profilePicture == "student${index}.svg" ||
                                      profilePicture == "student${index}.png"
                                  ? AntColors.blue6
                                  : AntColors.gray3
                              : AntColors.blue6,
                        ),
                      ),
                      child: Stack(
                        children: [
                          profilePictureFile != null ? Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.only(top: 16.0.h, right:16.w),
                              child: Icon(
                                RemixIcons.upload_2_line,
                                color: AntColors.blue6,
                                size: 16.sp,
                              ),
                            ),
                          ): Container(),
                          Center(
                            child: Uploader(
                              authenticationRepository:
                                  RepositoryProvider.of<AuthenticationRepository>(
                                      context),
                              onUpload: (ProfilePictureFile file) {
                                setState(() {
                                  profilePictureFile = file;
                                  profilePictureType = "upload";
                                  profilePicture = file.id;
                                  changed = true;
                                });
                              },
                              file: profilePictureFile,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0.sp),
                          side: BorderSide(
                            color: profilePicture == "student${index}.svg" ||
                                    profilePicture == "student${index}.png"
                                ? AntColors.blue6
                                : AntColors.gray3,
                          ),
                        ),
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              profilePicture = index < 9
                                  ? "student$index.svg"
                                  : "student$index.png";
                              profilePictureType = "static";
                              profilePictureFile = null;
                              changed = true;
                            });
                          },
                          tileColor: profilePicture == "student$index.svg" ||
                                  profilePicture == "student$index.png"
                              ? AntColors.blue1
                              : Colors.white,
                          title: Stack(children: [
                            Center(
                                child: index < 9
                                    ? SvgPicture.asset(
                                        "assets/avatars/student$index.svg",
                                        width: 78.sp,
                                        height: 78.sp)
                                    : Image.asset(
                                        "assets/avatars/student$index.png",
                                        width: 78.sp,
                                        height: 78.sp,
                                      )),
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.0.h),
                                child: Container(
                                  width: 16.0.sp,
                                  height: 16.0.sp,
                                  decoration: new BoxDecoration(
                                    color:
                                        profilePicture == "student$index.svg" ||
                                                profilePicture ==
                                                    "student$index.png"
                                            ? AntColors.blue6
                                            : Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: profilePicture ==
                                                  "student$index.svg" ||
                                              profilePicture ==
                                                  "student$index.png"
                                          ? AntColors.blue6
                                          : AntColors.gray5,
                                    ),
                                  ),
                                  child: profilePicture ==
                                              "student$index.svg" ||
                                          profilePicture == "student$index.png"
                                      ? Icon(
                                          RemixIcons.check_line,
                                          color: Colors.white,
                                          size: 10.sp,
                                        )
                                      : null,
                                ),
                              ),
                            )
                          ]),
                        ));
                  }
                }),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: _getBottomSheet(s),
    );
  }

  _getBottomSheet(S s) {
    return Container(
      constraints: BoxConstraints(minHeight: 0, maxHeight: 108.h),
      decoration: BoxDecoration(color: AntColors.blue1, boxShadow: [
        BoxShadow(
          color: AntColors.boxShadow,
          spreadRadius: 0,
          blurRadius: 4,
          offset: Offset(0, -2),
        )
      ]),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: MainButton(
            text: s.save,
            size: ButtonSize.Medium,
            height: 52.h,
            disabled: !changed || submitting,
            onPress: () async {
              setState(() {
                submitting = true;
              });
              final authenticationRepository = RepositoryProvider.of<AuthenticationRepository>(
                  context);
              UserSettingsApiProvider userSettingsApiProvider = UserSettingsApiProvider(
                authenticationRepository
              );
              await userSettingsApiProvider.updateAvatar(UserAvatarEntity(
                profilePicture: profilePicture,
                profilePictureType: profilePictureType,
                profilePictureFile: profilePictureFile != null ? File(
                    id: profilePictureFile.id,
                    name: profilePictureFile.name,
                    contentType: profilePictureFile.contentType,
                    size: profilePictureFile.size,
                    filePath: profilePictureFile.filePath,
                    createdBy: profilePictureFile.createdBy,
                    updatedBy: profilePictureFile.updatedBy) : null
              ));
              widget.updatedAvatar();
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    profilePictureType = widget.userAvatarEntity?.profilePictureType;
    profilePicture = widget.userAvatarEntity?.profilePicture;
    profilePictureFile =  widget.userAvatarEntity?.profilePictureFile != null ? ProfilePictureFile(
        id: widget.userAvatarEntity.profilePictureFile.id,
        name: widget.userAvatarEntity.profilePictureFile.name,
        contentType: widget.userAvatarEntity.profilePictureFile.contentType,
        size: widget.userAvatarEntity.profilePictureFile.size,
        filePath: widget.userAvatarEntity.profilePictureFile.filePath,
        createdBy: widget.userAvatarEntity.profilePictureFile.createdBy,
        updatedBy: widget.userAvatarEntity.profilePictureFile.updatedBy) : null;
    super.initState();
  }
}
