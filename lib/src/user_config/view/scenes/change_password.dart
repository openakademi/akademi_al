import 'package:akademi_al_mobile_app/components/button/button.dart';
import 'package:akademi_al_mobile_app/components/button/lib/main_button.dart';
import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/input/text_input.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/user_repository/lib/user_repository.dart';
import 'package:akademi_al_mobile_app/src/login_scenes/register/models/models.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';

import 'change_password/bloc/change_password_bloc.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool changed = false;
  bool submitting = false;
  String currentPassword = "";
  Password newPassword = Password.pure();
  Password repeatedNewPassword = Password.pure();

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return BlocProvider(
      create: (context) {
        return ChangePasswordBloc(
            userRepository: UserRepository(
                authenticationRepository:
                    RepositoryProvider.of<AuthenticationRepository>(context)));
      },
      child: Scaffold(
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
            text: s.password,
            type: TextTypes.p1,
          ),
        ),
        body: BlocListener<ChangePasswordBloc, ChangePasswordState>(
          listenWhen: (previous, next) {
            return previous.success != next.success;
          },
          listener: (context, state) {
            if (state.success != null && state.success) {
              Navigator.of(context).pop();
              Flushbar(
                flushbarPosition: FlushbarPosition.BOTTOM,
                messageText: BaseText(
                  type: TextTypes.d1,
                  weightType: FontWeight.w600,
                  text: s.password_changed_succesfully,
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
                  text: s.wrong_old_password,
                  textColor: AntColors.red6,
                ),
                backgroundColor: AntColors.red1,
                duration: Duration(seconds: 5),
              )..show(context);
            }
          },
          child: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
              builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 136.h,
                    color: AntColors.gray2,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0.w, top: 32.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 16.0.h),
                            child: BaseText(
                              text: s.password,
                              type: TextTypes.h3,
                              lineHeight: 1.3,
                              textColor: AntColors.gray9,
                            ),
                          ),
                          BaseText(
                            text: s.you_can_change_your_password_here,
                            textColor: AntColors.gray8,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 34.0.h, left: 20.w, right: 20.w),
                    child: TextInput(
                      initialValue: state.password.value,
                      onChanged: (password) {
                        context
                            .read<ChangePasswordBloc>()
                            .add(ChangeCurrentPassword(password));
                      },
                      labelText: s.current_password,
                      isPassword: true,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 34.0.h, left: 20.w, right: 20.w),
                    child: TextInput(
                      initialValue: state.newPassword.value,
                      onChanged: (password) => {
                        context
                            .read<ChangePasswordBloc>()
                            .add(ChangeNewPassword(password))
                      },
                      labelText: s.create_new_password,
                      isPassword: true,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 34.0.h, left: 20.w, right: 20.w),
                    child: TextInput(
                      initialValue: state.newRepeatedPassword.value,
                      onChanged: (password) => {
                        context
                            .read<ChangePasswordBloc>()
                            .add(ChangeRepeatPassword(password))
                      },
                      labelText: s.repeat_new_password,
                      isPassword: true,
                    ),
                  ),
                  // Expanded(child: Container()),
                  // Align(
                  //   alignment: Alignment.bottomCenter,
                  //   child: _getBottomSheet(s),
                  // )
                ],
              ),
            );
          }),
        ),
        bottomSheet: _getBottomSheet(s),
      ),
    );
  }

  _getBottomSheet(S s) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
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
              disabled: state.pageStatus.isInvalid ||
                  state.newPassword.value.isEmpty ||
                  state.newPassword.value != state.newRepeatedPassword.value ||
                  (state.submitting != null && state.submitting),
              onPress: () async {
                context.read<ChangePasswordBloc>().add(ChangePasswordRequest());
              },
            ),
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
  }
}
