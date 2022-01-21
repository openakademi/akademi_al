import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/user/user.dart';
import 'package:akademi_al_mobile_app/packages/models/user/user_avatar_entity.dart';
import 'package:akademi_al_mobile_app/packages/organization_repository/organization_repository.dart';
import 'package:akademi_al_mobile_app/packages/uploader_repository/lib/uploader_repository.dart';
import 'package:akademi_al_mobile_app/packages/user_settings_repository/lib/user_settings_api_provider.dart';
import 'package:akademi_al_mobile_app/src/authentication/authentication.dart';
import 'package:akademi_al_mobile_app/src/home/bloc/home_bloc.dart';
import 'package:akademi_al_mobile_app/src/home/models/models.dart';
import 'package:akademi_al_mobile_app/src/select_organization/view/scenes/select_organization.dart';
import 'package:akademi_al_mobile_app/src/synchronization/bloc/synchronization_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'scenes/change_avatar/view/change_avatar.dart';
import 'scenes/change_password.dart';
import 'scenes/profile_dialog.dart';

class MainUserAvatar extends StatefulWidget {
  final double height;
  final double width;

  const MainUserAvatar({
    Key key,
    this.height = 32,
    this.width = 32,
  }) : super(key: key);

  @override
  MainUserAvatarState createState() => MainUserAvatarState();
}

class MainUserAvatarState extends State<MainUserAvatar> {
  User userEntity;
  UserAvatarEntity userAvatarEntity;
  String organizationName;

  @override
  void initState() {
    super.initState();
    _getAvatar();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var connectivityResult = await (Connectivity().checkConnectivity());

        if(connectivityResult != ConnectivityResult.none) {
          _showMyDialog();

        }
      },
      child: Padding(
        padding: EdgeInsets.only(right: 6.w),
        child: userAvatarEntity != null
            ? SizedBox(
                height: 32.sp,
                child: Container(
                    width: widget.width.sp,
                    height: widget.height.sp,
                    decoration: BoxDecoration(
                        color: AntColors.blue6,
                        borderRadius: BorderRadius.all(
                          Radius.circular(6.0),
                        )),
                    child: userAvatarEntity.profilePictureType == "static"
                        ? Container(
                            height: widget.height.sp,
                            width: widget.width.sp,
                            child: userAvatarEntity.profilePicture
                                    .contains(".svg")
                                ? SvgPicture.asset(
                                    "assets/avatars/${userAvatarEntity.profilePicture}",
                                    width: 32.sp,
                                    height: 32.sp)
                                : Image.asset(
                                    "assets/avatars/${userAvatarEntity.profilePicture}",
                                    fit: BoxFit.scaleDown,
                                  ))
                        : Container(
                            height: widget.height.sp,
                            width: widget.width.sp,
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: userAvatarEntity.fileUrl,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
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
            : _getEmptyAvatar(),
      ),
    );
  }

  _getEmptyAvatar() {
    return Container(
      decoration: BoxDecoration(
          color: AntColors.blue6,
          borderRadius: BorderRadius.all(
            Radius.circular(6.0),
          )),
      height: widget.height.sp,
      width: widget.width.sp,
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

  Future<UserAvatarEntity> _getAvatar() async {
    final authenticationRepository =
        RepositoryProvider.of<AuthenticationRepository>(context);
    final userId = await authenticationRepository.getCurrentUserId();
    final user = await authenticationRepository.getCurrentUser();
    final organizationRepository = OrganizationRepository(
        authenticationRepository: authenticationRepository);

    final selectedOrganizationName =
        await organizationRepository.getSelectedOrganizationName();

    userEntity = user;
    final UserSettingsApiProvider userSettingsApiProvider =
        UserSettingsApiProvider(authenticationRepository);
    final UserAvatarEntity userAvatarEntityReponse =
        await userSettingsApiProvider.getAvatar(userId);
    if (userAvatarEntityReponse != null &&
        userAvatarEntityReponse.profilePictureType != "static") {
      UploaderRepository uploaderRepository =
          new UploaderRepository(authenticationRepository);
      var s3FilePath = await uploaderRepository.getS3UrlForAction(
          "${userAvatarEntityReponse.profilePictureFile.filePath}/${userAvatarEntityReponse.profilePictureFile.name}",
          S3ActionType.DOWNLOAD);
      userAvatarEntityReponse.fileUrl = s3FilePath;
    }

    setState(() {
      userAvatarEntity = userAvatarEntityReponse;
      organizationName = selectedOrganizationName;
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            content: ProfileDialog(
                userAvatarEntity: userAvatarEntity,
                userEntity: userEntity,
                organizationName: organizationName,
                logout: _logOut,
                changeOrganization: _changeOrganization,
                changeUserPhoto: _changeUserPhoto,
                changePassword: _changePassword,
                myProfile: _myProfile,
            ),
            );
      },
    );
  }

  _myProfile() {
    context
        .read<HomeBloc>()
        .add(NavigationItemChanged(NavigationItemKey.USER_PROFILE, "", null));
  }

  _logOut() {
    context.read<SynchronizationBloc>().add(DeleteSynchronization());
    context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested());
  }

  _changeOrganization() {
    Navigator.of(context).pushAndRemoveUntil<void>(
      SelectOrganization.route(true),
      (route) => false,
    );
  }

  _changeUserPhoto() {
    showCupertinoModalBottomSheet(
        context: this.context,
        expand: true,
        elevation: 40,
        backgroundColor: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        builder: (BuildContext builder) {
          return ChangeAvatar(
              userAvatarEntity: userAvatarEntity,
              updatedAvatar: _updatedAvatar);
        });
  }

  _changePassword() {
    showCupertinoModalBottomSheet(
        context: this.context,
        isDismissible: false,
        enableDrag: false,
        expand: true,
        elevation: 40,
        backgroundColor: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        builder: (BuildContext builder) {
          return ChangePassword();
        });
  }

  _updatedAvatar() {
    _getAvatar();
  }
}
