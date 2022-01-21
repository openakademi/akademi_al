import 'package:akademi_al_mobile_app/components/button/button.dart';
import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/input/text_input.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/src/login_scenes/forgot_password/view/forgot_password_page.dart';
import 'package:akademi_al_mobile_app/src/login_scenes/login/bloc/login_bloc.dart';
import 'package:akademi_al_mobile_app/src/login_scenes/register/view/register_page.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Flushbar(
            icon: Icon(RemixIcons.information_line, color: AntColors.red6, size: 16.sp,),
            flushbarPosition: FlushbarPosition.TOP,
            titleText: BaseText(
              type: TextTypes.p2,
              weightType: FontWeight.w600,
              text: s.wrong,
              textColor: AntColors.red6,
            ),
            messageText: BaseText(
              type: TextTypes.d2,
              text: s.wrong_login,
              textColor: AntColors.red6,
            ),
            backgroundColor: AntColors.red1,
            duration: Duration(seconds: 5),
          )..show(context);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              color: AntColors.blue1,
              elevation: 0,
              borderOnForeground: true,
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: AntColors.blue4),
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                      // dense: true,
                      visualDensity: VisualDensity(horizontal: 0.0),
                      contentPadding: EdgeInsets.only(
                          left: 26.0.w,
                          bottom: 16.0.h,
                          right: 16.0.w,
                          top: 16.0.h),
                      title: Row(children: [
                        Icon(
                          RemixIcons.information_line,
                          color: AntColors.blue6,
                          size: 24.sp,
                        ),
                        SizedBox(
                          width: 14.w,
                        ),
                        BaseText(
                          padding: EdgeInsets.only(top: 8, bottom: 8.h),
                          text: s.note_title,
                          type: TextTypes.t2,
                          // verticalPadding: 8,
                          textColor: AntColors.gray9,
                        )
                      ]),
                      subtitle: Row(children: [
                        SizedBox(
                          width: 38.w,
                        ),
                        Flexible(
                            child: BaseText(
                          text: s.note_description,
                          type: TextTypes.d1,
                          lineHeight: 1.57,
                          textColor: AntColors.gray8,
                          letterSpacing: 0,
                        )),
                      ])),
                ],
              ),
              // shape:
            ),
            _UsernameInput(s: s),
            _PasswordInput(s: s),
            _LoginButton(s: s),
            Padding(
              padding: EdgeInsets.only(top: 24.h),
              child: MainTextButton(
                onPress: () {
                  Navigator.of(context).push(ForgotPasswordPage.route());
                },
                customText: new BaseText(
                  text: s.forgot_password,
                  textColor: AntColors.blue6,
                  type: TextTypes.p2,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24.h),
              child: Row(
                children: [
                  Expanded(
                      child: Divider(
                    color: AntColors.gray5,
                    thickness: 1.sp,
                    endIndent: 8.sp,
                  )),
                  BaseText(
                    text: s.or,
                    type: TextTypes.d2,
                    textColor: AntColors.gray7,
                  ),
                  Expanded(
                      child: Divider(
                    color: AntColors.gray5,
                    thickness: 1.sp,
                    indent: 8.sp,
                  )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BaseText(
                    text: s.dont_have_account,
                    horizontalPadding: 0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: SizedBox(
                      height: 28,
                      child: MainTextButton(
                        onPress: () {
                          Navigator.of(context).push(RegisterPage.route());
                        },
                        customText: BaseText(
                          text: s.register_here_1,
                          textColor: AntColors.blue6,
                          horizontalPadding: 0,
                          align: TextAlign.start,
                          verticalPadding: 0,
                          type: TextTypes.p2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  final s;

  const _UsernameInput({Key key, this.s}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous?.username != current?.username,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(bottom: 26.0.h, top: 16.0.h),
          child: TextInput(
            height: 54.h,
            onChanged: (username) =>
                context.read<LoginBloc>().add(LoginUsernameChanged(username)),
            labelText: s.email_or_username,
            errorText: state.username.invalid ? s.wrong_email : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  final s;

  const _PasswordInput({Key key, this.s}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(bottom: 26.0.h),
          child: TextInput(
            height: 54.h,
            onChanged: (password) =>
                context.read<LoginBloc>().add(LoginPasswordChanged(password)),
            labelText: s.password,
            errorText: state.password.invalid ? s.wrong_password : null,
            isPassword: true,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  final s;

  const _LoginButton({Key key, this.s}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: MainButton(
            disabled: state.status != FormzStatus.valid,
            text: s.login,
            size: ButtonSize.Medium,
            width: 335.w,
            height: 52.h,
            onPress: () {
              context.read<LoginBloc>().add(const LoginSubmitted());
            },
          ),
        );
      },
    );
  }
}
