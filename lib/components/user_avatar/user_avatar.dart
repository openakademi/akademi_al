import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/enrollment/enrollment_entity.dart';
import 'package:akademi_al_mobile_app/packages/models/user/user_avatar_entity.dart';
import 'package:akademi_al_mobile_app/packages/uploader_repository/lib/uploader_repository.dart';
import 'package:akademi_al_mobile_app/packages/user_settings_repository/lib/user_settings_api_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class UserAvatar extends StatefulWidget {
  final String userId;
  final double height;
  final double width;
  final EnrollmentEntity enrollmentEntity;

  const UserAvatar(
      {Key key,
      this.userId,
      this.height = 32,
      this.width = 32,
      this.enrollmentEntity})
      : super(key: key);

  @override
  _UserAvatarState createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserAvatarEntity>(
        future: _getAvatar(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
                decoration: BoxDecoration(
                    color: AntColors.blue6,
                    borderRadius: BorderRadius.all(
                      Radius.circular(6.0),
                    )),
                child: snapshot.data.profilePictureType == "static"
                    ? Container(
                        height: widget.height.sp,
                        width: widget.width.sp,
                        child: snapshot.data.profilePicture.contains(".svg")
                            ? SvgPicture.asset(
                                "assets/avatars/${snapshot.data.profilePicture}",
                                width: 78.sp,
                                height: 78.sp)
                            : Image.asset(
                                "assets/avatars/${snapshot.data.profilePicture}",
                                fit: BoxFit.scaleDown,
                              ))
                    : Container(
                        height: widget.height.sp,
                        width: widget.width.sp,
                        decoration: BoxDecoration(
                            color: AntColors.blue6,
                            borderRadius: BorderRadius.all(
                              Radius.circular(6.0),
                            )),
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: snapshot.data.fileUrl,
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
                      ));
          } else {
            return _getEmptyAvatar();
          }
        });
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
      child: widget.enrollmentEntity != null
          ? Center(
              child: BaseText(
                type: TextTypes.d1,
                textColor: Colors.white,
                text:
                    "${widget.enrollmentEntity.user.firstName[0]}${widget.enrollmentEntity.user.lastName[0]}",
              ),
            )
          : Center(),
    );
  }

  Future<UserAvatarEntity> _getAvatar() async {
    final authenticationRepository =
        RepositoryProvider.of<AuthenticationRepository>(context);
    final UserSettingsApiProvider userSettingsApiProvider =
        UserSettingsApiProvider(authenticationRepository);
    final UserAvatarEntity userAvatarEntity =
        await userSettingsApiProvider.getAvatar(widget.userId);
    if (userAvatarEntity != null &&
        userAvatarEntity.profilePictureType != "static") {
      UploaderRepository uploaderRepository =
          new UploaderRepository(authenticationRepository);
      final userId = await authenticationRepository.getCurrentUserId();
      var s3FilePath = await uploaderRepository.getS3UrlForAction(
          "${userAvatarEntity.profilePictureFile.filePath}/${userAvatarEntity.profilePictureFile.name}",
          S3ActionType.DOWNLOAD);
      userAvatarEntity.fileUrl = s3FilePath;
    }
    return userAvatarEntity;
  }
}
