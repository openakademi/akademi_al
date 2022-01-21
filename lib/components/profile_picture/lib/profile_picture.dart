import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/onboarding/profile_picture_file.dart';
import 'package:akademi_al_mobile_app/packages/uploader_repository/lib/uploader_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePicture extends StatelessWidget {
  final double size;
  final BoxShape shape;
  final ProfilePictureFile file;
  final String profilePictureType;
  final String profilePicture;

  const ProfilePicture(
      {Key key,
      this.size,
      this.shape = BoxShape.rectangle,
      this.file,
      this.profilePictureType,
      this.profilePicture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: _getUsernameOrIcon(context),
        builder: (context, snapshot) {
          return CircleAvatar(
            radius: this.size,
            backgroundColor: AntColors.blue6,
            backgroundImage: this.file != null &&
                    this.profilePictureType == "upload" &&
                    snapshot.hasData &&
                    snapshot.data.length > 2
                ? NetworkImage(snapshot.data)
                : _getChild(),
            child: profilePicture != null && profilePicture.isNotEmpty
                ? this.profilePicture.split(".").last == "svg"
                    ? SvgPicture.asset(
                        "assets/avatars/${this.profilePicture}",
                      )
                    : null
                : snapshot.hasData
                    ? snapshot.data.length > 2
                        ? Container()
                        : BaseText(
                            text: snapshot.data,
                            textColor: Colors.white,
                            type: TextTypes.d1,
                          )
                    : CircularProgressIndicator(),
          );
        });
  }

  Future<String> _getUsernameOrIcon(BuildContext context) async {
    var authenticationRepository =
        RepositoryProvider.of<AuthenticationRepository>(context);
    var user = await authenticationRepository.getCurrentUser();

    final capitals = "${user.firstName[0]}${user.lastName[0]}";

    if (this.file != null && this.profilePictureType == "upload") {
      UploaderRepository uploaderRepository =
          new UploaderRepository(authenticationRepository);
      final userId = await authenticationRepository.getCurrentUserId();
      var s3FilePath = await uploaderRepository.getS3UrlForAction(
          "avatar/$userId/${this.file.name}", S3ActionType.DOWNLOAD);
      return s3FilePath;
    }

    print("here");
    return capitals;
  }

  _getChild() {
    if (profilePictureType == "static") {
      return this.profilePicture.split(".").last == "svg"
          ? null
          : AssetImage(
              "assets/avatars/${this.profilePicture}",
            );
    } else {
      return null;
    }
  }
}
