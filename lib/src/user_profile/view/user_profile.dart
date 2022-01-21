import 'package:akademi_al_mobile_app/components/button/button.dart';
import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/skeleton_list/skeleton_list.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/src/user_profile/bloc/user_profile_bloc.dart';
import 'package:akademi_al_mobile_app/src/user_profile/view/scenes/all_subjects_progress.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:multi_charts/multi_charts.dart';

import 'my_profile.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
      if (state.userEntity != null ) {
        return Column(
          children: [
            _getTopContainer(s, state),
            SizedBox(
              height: 26.h,
            ),
            state.asyncCoursesProgress != null ? _getStatistics(state, s): Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                child: Column(
                  children: [
                    BaseText(
                      text: s.subjects_performance,
                      type: TextTypes.h5,
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Image.asset(
                      "assets/images/empty_statistics/empty_statistics.png",
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    BaseText(
                      text: s.no_statistics,
                      type: TextTypes.d1,
                      align: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      } else {
        return SkeletonList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<UserProfileBloc>().add(LoadUserProfile());
  }

  _getTopContainer(S s, UserProfileState state) {
    return Container(
      // height: 184.h,
      color: AntColors.blue1,
      child: Column(
        children: [
          SizedBox(
            height: 16.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 20.w,
              ),
              _getProfileContainer(s, state),
              SizedBox(
                width: 16.w,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BaseText(
                      text:
                          "${state.userEntity.firstName} ${state.userEntity.lastName}",
                      type: TextTypes.h5,
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    BaseText(
                      text: "${state.userEntity.email}",
                      textColor: AntColors.gray7,
                      type: TextTypes.p2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    _showMyProfileDialog(state);
                  },
                  child: Icon(
                    RemixIcons.settings_4_line,
                    color: AntColors.blue6,
                    size: 24.sp,
                  ),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Divider(
            indent: 20.w,
            height: 1,
            endIndent: 20.w,
          ),
          state.allCompletedCourses != null && state.allCompletedCourses > 0
              ? SizedBox(
                  height: 12.h,
                )
              : Container(),
          state.allCompletedCourses != null && state.allCompletedCourses > 0
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20.w,
                    ),
                    Image.asset(
                      "assets/images/score_image/score_image.png",
                      fit: BoxFit.scaleDown,
                      height: 83.h,
                      width: 101.w,
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BaseText(
                          text: "${state.allCompletedCourses}",
                          type: TextTypes.h4,
                        ),
                        BaseText(
                          text: _getTillTodayText(s),
                          type: TextTypes.d2,
                          textColor: AntColors.gray7,
                        )
                      ],
                    )
                  ],
                )
              : Container(),
          Divider(
            height: 1,
          ),
        ],
      ),
    );
  }

  _getTillTodayText(S s) {
    var formatter = new DateFormat("dd MMMM");
    var date = formatter.format(DateTime.now()).toString();
    return s.lesson_completed_till_now(date);
  }

  _getProfileContainer(S s, UserProfileState state) {
    return state.userAvatarEntity != null
        ? SizedBox(
            height: 56.h,
            child: Container(
                width: 56.w,
                height: 56.h,
                decoration: BoxDecoration(
                    color: AntColors.blue6,
                    borderRadius: BorderRadius.all(
                      Radius.circular(6.0),
                    )),
                child: state.userAvatarEntity.profilePictureType == "static"
                    ? Container(
                        height: 56.h,
                        width: 56.w,
                        child: state.userAvatarEntity.profilePicture
                                .contains(".svg")
                            ? SvgPicture.asset(
                                "assets/avatars/${state.userAvatarEntity.profilePicture}",
                                width: 32.sp,
                                height: 32.sp)
                            : Image.asset(
                                "assets/avatars/${state.userAvatarEntity.profilePicture}",
                                fit: BoxFit.scaleDown,
                              ))
                    : Container(
                        height: 56.h,
                        width: 56.w,
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: state.userAvatarEntity.fileUrl,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                              image: DecorationImage(image: imageProvider),
                            ),
                          ),
                          placeholder: (context, url) => _getEmptyAvatar(state),
                          errorWidget: (context, url, error) =>
                              _getEmptyAvatar(state),
                        ),
                      )))
        : _getEmptyAvatar(state);
  }

  _getEmptyAvatar(UserProfileState state) {
    return Container(
      decoration: BoxDecoration(
          color: AntColors.blue6,
          borderRadius: BorderRadius.all(
            Radius.circular(6.0),
          )),
      height: 56.h,
      width: 56.w,
      child: state.userEntity != null
          ? Center(
              child: BaseText(
                type: TextTypes.d1,
                textColor: Colors.white,
                text:
                    "${state.userEntity.firstName[0]}${state.userEntity.lastName[0]}",
              ),
            )
          : Center(),
    );
  }

  _showMyProfileDialog(UserProfileState state) {
    showCupertinoModalBottomSheet(
        context: this.context,
        expand: true,
        elevation: 40,
        backgroundColor: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        builder: (BuildContext builder) {
          return MyProfile(
            userAvatarEntity: state.userAvatarEntity,
            userEntity: state.userEntity,
            reload: () {
              context.read<UserProfileBloc>().add(LoadUserProfile());
            },
          );
        });
  }

  _getStatistics(UserProfileState state, S s) {
    final asyncList = state.asyncCoursesProgress;
    var list = asyncList;
    if (asyncList.length > 8) {
      list = asyncList.sublist(0, 8);
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: asyncList.length > 3
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6.sp)),
                border: Border.all(
                  color: AntColors.gray3,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 22.h,
                  ),
                  BaseText(
                    text: s.subjects_performance,
                    type: TextTypes.h5,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  RadarChart(
                      values: list.map((e) => e.calculatedScore).toList(),
                      labels: list
                          .map((e) =>
                              "${e.name} ${e.calculatedScore.toStringAsFixed(1)}")
                          .toList(),
                      maxValue: 5,
                      fillColor: AntColors.blue6,
                      strokeColor: Color.fromRGBO(32, 99, 227, 0.3),
                      labelColor: AntColors.gray7,
                      chartRadiusFactor: 0.7,
                      maxLinesForLabels: 3),
                  SizedBox(
                    height: 24.h,
                  ),
                  Divider(
                    height: 1,
                  ),
                  MainTextButton(
                    onPress: () {
                      Navigator.of(context).push(AllSubjectsProgress.route(
                          state.asyncCoursesProgress));
                    },
                    customText: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        BaseText(
                          text: s.all_subjects_progress(
                              state.asyncCoursesProgress.length),
                          textColor: AntColors.blue6,
                          weightType: FontWeight.w500,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Icon(
                          RemixIcons.arrow_right_line,
                          color: AntColors.blue6,
                          size: 18.sp,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          : Container(
              child: Column(
                children: [
                  BaseText(
                    text: s.subjects_performance,
                    type: TextTypes.h5,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Image.asset(
                    "assets/images/empty_statistics/empty_statistics.png",
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  BaseText(
                    text: s.no_statistics,
                    type: TextTypes.d1,
                    align: TextAlign.center,
                  ),
                ],
              ),
            ),
    );
  }
}
