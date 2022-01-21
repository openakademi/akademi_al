import 'package:akademi_al_mobile_app/components/button/button.dart';
import 'package:akademi_al_mobile_app/components/button/lib/main_button.dart';
import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/input/text_input.dart';
import 'package:akademi_al_mobile_app/components/skeleton_list/skeleton_list.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/models/user/user.dart';
import 'package:akademi_al_mobile_app/src/user_profile/view/scenes/change_profile_data/bloc/change_profile_data_bloc.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';

enum ChangeProfileType { NAME, NATIONALITY, USERNAME }

class ChangeProfile extends StatefulWidget {
  final ChangeProfileType type;
  final User userEntity;
  final Function reload;

  const ChangeProfile({Key key, this.type, this.userEntity, this.reload})
      : super(key: key);

  @override
  _ChangeProfileState createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
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
          text: _getTitleText(s),
          type: TextTypes.p1,
        ),
      ),
      body: BlocListener<ChangeProfileDataBloc, ChangeProfileDataState>(
        listenWhen: (previous, next) {
          return previous.success != next.success;
        },
        listener: (context, state) {
          if (state.success != null && state.success) {
            widget.reload();
            Navigator.of(context).pop();
            Flushbar(
              flushbarPosition: FlushbarPosition.BOTTOM,
              messageText: BaseText(
                type: TextTypes.d1,
                weightType: FontWeight.w600,
                text: s.succesfully_changed_data,
                textColor: Colors.white,
              ),
              backgroundColor: AntColors.green6,
              duration: Duration(seconds: 3),
            )..show(context);
          } else {
            Flushbar(
              icon: Icon(
                RemixIcons.information_line,
                color: AntColors.red6,
                size: 16.sp,
              ),
              flushbarPosition: FlushbarPosition.TOP,
              titleText: BaseText(
                type: TextTypes.p2,
                weightType: FontWeight.w600,
                text: s.wrong,
                textColor: AntColors.red6,
              ),
              messageText: BaseText(
                type: TextTypes.d2,
                text: s.an_error_happend,
                textColor: AntColors.red6,
              ),
              backgroundColor: AntColors.red1,
              duration: Duration(seconds: 5),
            )..show(context);
          }
        },
        child: BlocBuilder<ChangeProfileDataBloc, ChangeProfileDataState>(
            builder: (context, state) {
          if (state.userEntity != null) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: AntColors.gray2,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0.w, top: 32.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(bottom: 16.0.h, right: 20.0.w),
                            child: BaseText(
                              text: _getMainDescriptionText(s),
                              type: TextTypes.h3,
                              lineHeight: 1.3,
                              textColor: AntColors.gray9,
                            ),
                          ),
                          BaseText(
                            text: _getMainDescriptionLineText(s),
                            textColor: AntColors.gray8,
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  //
                  _getFieldsToChange(s, state),
                ],
              ),
            );
          } else {
            return SkeletonList();
          }
        }),
      ),
      bottomSheet: _getBottomSheet(s),
    );
  }

  _getFieldsToChange(S s, ChangeProfileDataState state) {
    switch (widget.type) {
      case ChangeProfileType.NAME:
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 34.0.h, left: 20.w, right: 20.w),
              child: TextInput(
                initialValue: state.name.value,
                onChanged: (value) => {
                  context
                      .read<ChangeProfileDataBloc>()
                      .add(ChangeName(newName: value))
                },
                labelText: s.name,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 34.0.h, left: 20.w, right: 20.w),
              child: TextInput(
                initialValue: state.surname.value,
                onChanged: (value) => {
                  context
                      .read<ChangeProfileDataBloc>()
                      .add(ChangeSurname(surname: value))
                },
                labelText: s.surname,
              ),
            ),
          ],
        );
      case ChangeProfileType.USERNAME:
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 34.0.h, left: 20.w, right: 20.w),
              child: TextInput(
                initialValue: state.userName.value,
                onChanged: (value) => {
                  context
                      .read<ChangeProfileDataBloc>()
                      .add(ChangeUsername(username: value))
                },
                labelText: s.username_label,
              ),
            ),
          ],
        );
      case ChangeProfileType.NATIONALITY:
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6.sp)),
              border: Border.all(
                color: AntColors.gray3,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0.h),
              child: Column(
                  children: ListTile.divideTiles(
                      context: context,
                      color: AntColors.gray4,
                      tiles: [
                    ListTile(
                      tileColor: state.nationality?.value == "ALBANIA"
                          ? AntColors.blue1
                          : Colors.white,
                      dense: false,
                      contentPadding: EdgeInsets.all(20.sp),
                      shape: ContinuousRectangleBorder(
                          side: BorderSide(
                        color: AntColors.gray3,
                      )),
                      leading: Image.asset(
                        "assets/logos/albania_logo/albania_logo.png",
                        height: 32.h,
                        width: 32.w,
                      ),
                      onTap: () {
                        context
                            .read<ChangeProfileDataBloc>()
                            .add(ChangeNationality(nationality: "ALBANIA"));
                      },
                      title: BaseText(
                        text: s.albania_nationality,
                        type: TextTypes.p1,
                        textColor: AntColors.gray8,
                      ),
                      trailing: Container(
                        width: 24.0.sp,
                        height: 24.0.sp,
                        decoration: new BoxDecoration(
                          color: state.nationality?.value == "ALBANIA"
                              ? AntColors.blue6
                              : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: state.nationality?.value == "ALBANIA"
                                ? AntColors.blue6
                                : AntColors.gray5,
                          ),
                        ),
                        child: state.nationality?.value == "ALBANIA"
                            ? Icon(
                                RemixIcons.check_line,
                                color: Colors.white,
                                size: 16.sp,
                              )
                            : null,
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.all(20.sp),
                      tileColor: state.nationality?.value == "KOSOVO"
                          ? AntColors.blue1
                          : Colors.white,
                      onTap: () {
                        context
                            .read<ChangeProfileDataBloc>()
                            .add(ChangeNationality(nationality: "KOSOVO"));
                      },
                      leading: Image.asset(
                        "assets/logos/kosova_logo/kosova_logo.png",
                        height: 32.h,
                        width: 32.w,
                      ),
                      dense: false,
                      shape: ContinuousRectangleBorder(
                          side: BorderSide(
                        color: AntColors.gray3,
                      )),
                      title: BaseText(
                        text: s.kosova_nationality,
                        type: TextTypes.p1,
                        textColor: AntColors.gray8,
                      ),
                      trailing: Container(
                        width: 24.0.sp,
                        height: 24.0.sp,
                        decoration: new BoxDecoration(
                          color: state.nationality?.value == "KOSOVO"
                              ? AntColors.blue6
                              : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: state.nationality?.value == "KOSOVO"
                                ? AntColors.blue6
                                : AntColors.gray5,
                          ),
                        ),
                        child: state.nationality?.value == "KOSOVO"
                            ? Icon(
                                RemixIcons.check_line,
                                color: Colors.white,
                                size: 16.sp,
                              )
                            : null,
                      ),
                    ),
                    ListTile(
                      tileColor: state.nationality?.value == "OTHER"
                          ? AntColors.blue1
                          : Colors.white,
                      contentPadding: EdgeInsets.all(20.sp),
                      dense: false,
                      onTap: () {
                        context
                            .read<ChangeProfileDataBloc>()
                            .add(ChangeNationality(nationality: "OTHER"));
                      },
                      leading: Image.asset(
                        "assets/logos/diaspora_logo/diaspora_logo.png",
                        height: 32.h,
                        width: 32.w,
                      ),
                      shape: ContinuousRectangleBorder(
                          side: BorderSide(
                        color: AntColors.gray3,
                      )),
                      title: BaseText(
                        text: s.diaspora_nationality,
                        type: TextTypes.p1,
                        textColor: AntColors.gray8,
                      ),
                      trailing: Container(
                        width: 24.0.sp,
                        height: 24.0.sp,
                        decoration: new BoxDecoration(
                          color: state.nationality?.value == "OTHER"
                              ? AntColors.blue6
                              : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: state.nationality?.value == "OTHER"
                                ? AntColors.blue6
                                : AntColors.gray5,
                          ),
                        ),
                        child: state.nationality?.value == "OTHER"
                            ? Icon(
                                RemixIcons.check_line,
                                color: Colors.white,
                                size: 16.sp,
                              )
                            : null,
                      ),
                    )
                  ]).toList()),
            ),
          ),
        );
    }
  }

  @override
  void initState() {
    super.initState();
    context
        .read<ChangeProfileDataBloc>()
        .add(LoadUserEntity(userEntity: widget.userEntity));
  }

  _getTitleText(S s) {
    switch (widget.type) {
      case ChangeProfileType.NAME:
        return s.name_title;
      case ChangeProfileType.USERNAME:
        return s.user_name_title;
      case ChangeProfileType.NATIONALITY:
        return s.state_title;
    }
  }

  _getMainDescriptionText(S s) {
    switch (widget.type) {
      case ChangeProfileType.NAME:
        return s.name_title;
      case ChangeProfileType.USERNAME:
        return s.user_name_title;
      case ChangeProfileType.NATIONALITY:
        return s.studying_state;
    }
  }

  _getMainDescriptionLineText(S s) {
    switch (widget.type) {
      case ChangeProfileType.NAME:
        return s.change_name_description;
      case ChangeProfileType.USERNAME:
        return s.change_user_name_description;
      case ChangeProfileType.NATIONALITY:
        return s.change_state_description;
    }
  }

  _getBottomSheet(S s) {
    return BlocBuilder<ChangeProfileDataBloc, ChangeProfileDataState>(
        builder: (context, state) {
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
              disabled: state.changed != null &&
                  !state.changed &&
                  state.getCurrentPageStatus(widget.type) != FormzStatus.valid,
              onPress: () async {
                context
                    .read<ChangeProfileDataBloc>()
                    .add(RequestChangeNameAndSurname());
              },
            ),
          ),
        ),
      );
    });
  }
}
