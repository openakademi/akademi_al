import 'package:akademi_al_mobile_app/components/button/button.dart';
import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/models/user/user.dart';
import 'package:akademi_al_mobile_app/packages/models/user/user_avatar_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfileDialog extends StatelessWidget {
  final UserAvatarEntity userAvatarEntity;
  final User userEntity;
  final String organizationName;
  final Function logout;
  final Function changeOrganization;
  final Function changeUserPhoto;
  final Function changePassword;
  final Function myProfile;

  const ProfileDialog(
      {Key key,
      this.userAvatarEntity,
      this.userEntity,
      this.organizationName,
      this.logout,
      this.changeOrganization,
      this.changeUserPhoto,
      this.changePassword,
      this.myProfile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 32.h,
        ),
        _getUserAvatar(),
        MainTextButton(
          onPress: () {
            Navigator.of(context).pop();
            changeUserPhoto();
          },
          text: s.change_profile_picture,
        ),
        BaseText(
          text: "${userEntity.firstName} ${userEntity.lastName}",
          type: TextTypes.h4,
          align: TextAlign.center,
        ),
        SizedBox(
          height: 8.h,
        ),
        BaseText(
          text: userEntity.email,
          textColor: AntColors.gray7,
        ),
        SizedBox(
          height: 24.h,
        ),
        Divider(
          height: 1,
        ),
        Container(
          child: Center(
            child: MainTextButton(
              onPress: () {
                Navigator.of(context).pop();
                myProfile();
              },
              customText: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    RemixIcons.user_line,
                    color: AntColors.blue6,
                    size: 18.sp,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  BaseText(
                    text: s.my_profile,
                    textColor: AntColors.blue6,
                    weightType: FontWeight.w500,
                  )
                ],
              ),
            ),
          ),
        ),
        Divider(
          height: 1,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            changePassword();
          },
          child: Container(
            child: Center(
              child: MainTextButton(
                customText: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      RemixIcons.key_2_line,
                      color: AntColors.blue6,
                      size: 18.sp,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    BaseText(
                      text: s.change_password,
                      textColor: AntColors.blue6,
                      weightType: FontWeight.w500,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Divider(
          height: 1,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            changeOrganization();
          },
          child: Column(
            children: [
              Container(
                child: Center(
                  child: MainTextButton(
                    customText: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          RemixIcons.swap_line,
                          color: AntColors.blue6,
                          size: 18.sp,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        BaseText(
                          text: s.change_portal,
                          textColor: AntColors.blue6,
                          weightType: FontWeight.w500,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              organizationName != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          RemixIcons.building_4_line,
                          color: AntColors.gray6,
                          size: 14.sp,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        BaseText(
                          text: organizationName,
                          type: TextTypes.d2,
                        ),
                      ],
                    )
                  : Container(),
              SizedBox(
                height: 16.h,
              )
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            logout();
          },
          child: Container(
            child: Center(
              child: MainTextButton(
                customText: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      RemixIcons.logout_box_line,
                      color: AntColors.blue6,
                      size: 18.sp,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    BaseText(
                      text: s.logout,
                      weightType: FontWeight.w500,
                      textColor: AntColors.blue6,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _getUserAvatar() {
    return userAvatarEntity != null
        ? SizedBox(
            height: 80.h,
            child: Container(
                width: 80.w,
                height: 80.h,
                decoration: BoxDecoration(
                    color: AntColors.blue6,
                    borderRadius: BorderRadius.all(
                      Radius.circular(6.0),
                    )),
                child: userAvatarEntity.profilePictureType == "static"
                    ? Container(
                        height: 80.h,
                        width: 80.w,
                        child: userAvatarEntity.profilePicture.contains(".svg")
                            ? SvgPicture.asset(
                                "assets/avatars/${userAvatarEntity.profilePicture}",
                                width: 32.sp,
                                height: 32.sp)
                            : Image.asset(
                                "assets/avatars/${userAvatarEntity.profilePicture}",
                                fit: BoxFit.scaleDown,
                              ))
                    : Container(
                        height: 80.h,
                        width: 80.w,
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: userAvatarEntity.fileUrl,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                              image: DecorationImage(image: imageProvider),
                            ),
                          ),
                          placeholder: (context, url) => _getEmptyAvatar(),
                          errorWidget: (context, url, error) =>
                              _getEmptyAvatar(),
                        ),
                      )))
        : _getEmptyAvatar();
  }

  _getEmptyAvatar() {
    return Container(
      decoration: BoxDecoration(
          color: AntColors.blue6,
          borderRadius: BorderRadius.all(
            Radius.circular(6.0),
          )),
      height: 80.h,
      width: 80.w,
      child: userEntity != null
          ? Center(
              child: BaseText(
                type: TextTypes.d1,
                textColor: Colors.white,
                text: "${userEntity.firstName[0]}${userEntity.lastName[0]}",
              ),
            )
          : Center(),
    );
  }
}
