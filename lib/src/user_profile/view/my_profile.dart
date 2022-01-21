import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/user/user.dart';
import 'package:akademi_al_mobile_app/packages/models/user/user_avatar_entity.dart';
import 'package:akademi_al_mobile_app/packages/organization_repository/organization_repository.dart';
import 'package:akademi_al_mobile_app/packages/user_repository/lib/user_repository.dart';
import 'package:akademi_al_mobile_app/src/user_config/view/scenes/change_avatar/view/change_avatar.dart';
import 'package:akademi_al_mobile_app/src/user_profile/view/scenes/change_profile_data/bloc/change_profile_data_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'scenes/change_profile_data/view/change_profile.dart';

class MyProfile extends StatelessWidget {
  final User userEntity;
  final UserAvatarEntity userAvatarEntity;
  final Function reload;

  const MyProfile(
      {Key key, this.userEntity, this.userAvatarEntity, this.reload})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 1,
          leading: Center(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                RemixIcons.close_line,
                color: AntColors.blue6,
                size: 24.sp,
              ),
            ),
          ),
          title: BaseText(
            text: s.my_profile,
            type: TextTypes.p1,
          ),
        ),
        body: Column(
          children: [
            _getTopContainer(context, s),
            SizedBox(
              height: 24.h,
            ),
            _DataEntry(
              onClick: () {
                _changeName(context);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BaseText(
                    text: s.name_label,
                    type: TextTypes.d1,
                    textColor: AntColors.gray7,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  BaseText(
                    text: "${userEntity.firstName} ${userEntity.lastName}",
                  ),
                ],
              ),
            ),
            _DataEntry(
              disabled: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BaseText(
                    text: s.birthday,
                    type: TextTypes.d1,
                    textColor: AntColors.gray6,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  BaseText(
                    text: _getDate(),
                    textColor: AntColors.gray6,
                  ),
                ],
              ),
            ),
            _DataEntry(
              disabled: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BaseText(
                    text: s.email,
                    type: TextTypes.d1,
                    textColor: AntColors.gray6,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  BaseText(
                    text: userEntity.email,
                    textColor: AntColors.gray6,
                  ),
                ],
              ),
            ),
            _DataEntry(
              onClick: () {
                _changeUsername(context);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BaseText(
                    text: s.user_name_profile_label,
                    type: TextTypes.d1,
                    textColor: AntColors.gray7,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  BaseText(
                    text: "${userEntity.username}",
                  ),
                ],
              ),
            ),
            _DataEntry(
              onClick: () {
                _changeNationality(context);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BaseText(
                    text: s.studying_state,
                    type: TextTypes.d1,
                    textColor: AntColors.gray7,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  BaseText(
                    text: _getNationality(s),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  _getNationality(S s) {
    if (userEntity.nationality == "ALBANIA") {
      return s.albania_nationality;
    } else if (userEntity.nationality == "KOSOVO") {
      return s.kosova_nationality;
    } else if (userEntity.nationality == "OTHER") {
      return s.diaspora_nationality;
    }
  }

  _getDate() {
    var formatter = new DateFormat("dd MMMM yyyy");
    var date =
        formatter.format(DateTime.tryParse(userEntity.dateOfBirth)).toString();
    return date;
  }

  _getTopContainer(BuildContext context, S s) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 16.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 20.w,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  _changeUserPhoto(context);
                },
                child: Stack(
                  children: [
                    _getProfileContainer(s),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 4.0, left: 4),
                        child: Icon(
                          RemixIcons.camera_line,
                          color: Colors.white,
                          size: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 16.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BaseText(
                      text: "${userEntity.firstName} ${userEntity.lastName}",
                      type: TextTypes.h4,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    BaseText(
                      text: "${userEntity.email}",
                      textColor: AntColors.gray7,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
            ],
          ),
          Flexible(
            child: Container(),
          ),
          Divider(
            height: 1,
          )
        ],
      ),
    );
  }

  _changeUserPhoto(BuildContext context) {
    showCupertinoModalBottomSheet(
        context: context,
        expand: true,
        elevation: 40,
        backgroundColor: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        builder: (BuildContext builder) {
          return ChangeAvatar(
              userAvatarEntity: userAvatarEntity,
              updatedAvatar: () {
                reload();
              });
        });
  }

  _changeName(BuildContext context) {
    showCupertinoModalBottomSheet(
        context: context,
        expand: true,
        elevation: 40,
        backgroundColor: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        builder: (BuildContext builder) {
          return BlocProvider(
              create: (context) {
                return ChangeProfileDataBloc(
                    userRepository: UserRepository(
                        authenticationRepository:
                            RepositoryProvider.of<AuthenticationRepository>(
                                context)),
                    authenticationRepository:
                    RepositoryProvider.of<AuthenticationRepository>(
                        context),
                  organizationRepository: OrganizationRepository(
                      authenticationRepository:
                      RepositoryProvider.of<AuthenticationRepository>(
                          context)
                  )
                );
              },
              child: ChangeProfile(
                type: ChangeProfileType.NAME,
                userEntity: userEntity,
                reload: () {
                  Navigator.of(context).pop();
                  reload();
                }
              ));
        });
  }

  _changeUsername(BuildContext context) {
    showCupertinoModalBottomSheet(
        context: context,
        expand: true,
        elevation: 40,
        backgroundColor: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        builder: (BuildContext builder) {
          return BlocProvider(
              create: (context) {
                return ChangeProfileDataBloc(
                    userRepository: UserRepository(
                        authenticationRepository:
                        RepositoryProvider.of<AuthenticationRepository>(
                            context)),
                    authenticationRepository:
                    RepositoryProvider.of<AuthenticationRepository>(
                        context),
                    organizationRepository: OrganizationRepository(
                        authenticationRepository:
                        RepositoryProvider.of<AuthenticationRepository>(
                            context)
                    )
                );
              },
              child: ChangeProfile(
                  type: ChangeProfileType.USERNAME,
                  userEntity: userEntity,
                  reload: () {
                    Navigator.of(context).pop();
                    reload();
                  }
              ));
        });
  }

  _changeNationality(BuildContext context) {
    showCupertinoModalBottomSheet(
        context: context,
        expand: true,
        elevation: 40,
        backgroundColor: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        builder: (BuildContext builder) {
          return BlocProvider(
              create: (context) {
                return ChangeProfileDataBloc(
                    userRepository: UserRepository(
                        authenticationRepository:
                        RepositoryProvider.of<AuthenticationRepository>(
                            context)),
                    authenticationRepository:
                    RepositoryProvider.of<AuthenticationRepository>(
                        context),
                    organizationRepository: OrganizationRepository(
                        authenticationRepository:
                        RepositoryProvider.of<AuthenticationRepository>(
                            context)
                    )
                );
              },
              child: ChangeProfile(
                  type: ChangeProfileType.NATIONALITY,
                  userEntity: userEntity,
                  reload: () {
                    Navigator.of(context).pop();
                    reload();
                  }
              ));
        });
  }

  _getProfileContainer(S s) {
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

class _DataEntry extends StatelessWidget {
  final Widget child;
  final Function onClick;
  final bool disabled;

  const _DataEntry({Key key, this.onClick, this.child, this.disabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!disabled) {
          onClick();
        }
      },
      child: Container(
        // height: 80.h,
        constraints: BoxConstraints(
          minHeight: 80.h
        ),
        color: disabled ? AntColors.gray3 : Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 20.w,
            ),
            Expanded(child: child),
              Align(
              alignment: Alignment.center,
              child: Icon(
                RemixIcons.arrow_right_s_line,
                color: disabled ? AntColors.gray5 : AntColors.gray6,
                size: 24.sp,
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
          ],
        ),
      ),
    );
  }
}
