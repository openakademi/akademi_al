import 'package:akademi_al_mobile_app/components/button/button.dart';
import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/input/text_input.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/src/login_scenes/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      buildWhen: (previous, current) {
        return previous.emailExist != current.emailExist;
      },
        builder: (context, state) {
      return Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.0.w),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 16.0.h),
                child: BaseText(
                  text: s.forgot_password_question,
                  type: TextTypes.h3,
                  textColor: AntColors.gray9,
                  align: TextAlign.center,
                  lineHeight: 1.3,
                ),
              ),
              !state.emailExist ? Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 26.h),
                child: Container(
                  color: AntColors.red6,
                  height: 54.h,
                  child: BaseText(
                    type: TextTypes.d1,
                    textColor: AntColors.gray8,
                    align: TextAlign.center,
                    text: s.email_does_not_exist,
                  ),
                ),
              ):Container(height: 0, width: 0),
              BaseText(
                text: s.forgot_password_description,
                type: TextTypes.p2,
                textColor: AntColors.gray8,
                align: TextAlign.left,
              ),
              Padding(
                padding: EdgeInsets.only(top: 32.0.h),
                child: _EmailInput(s: s),
              ),
              _SendButton(s: s)
            ]),
      );
    });
  }
}

class _EmailInput extends StatelessWidget {
  final s;

  const _EmailInput({Key key, this.s}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(bottom: 26.0.h, top: 16.0.h),
          child: TextInput(
            prefixIcon: Icon(
              RemixIcons.mail_line,
              color: AntColors.gray7,
              size: 20.sp,
            ),
            height: 54.h,
            initialValue: state.email.value,
            onChanged: (email) =>
                context.bloc<ForgotPasswordBloc>().add(ForgotPasswordEmailChanged(email)),
            labelText: s.email,
            hintText: s.example_email,
          ),
        );
      },
    );
  }
}

class _SendButton extends StatelessWidget {
  final s;

  const _SendButton({Key key, this.s}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: 8),
          child: MainButton(
            text: s.send_instructions,
            prefixIcon: Icon(
              RemixIcons.send_plane_line,
              color: state.status == FormzStatus.valid ? Colors.white: AntColors.gray6,
              size: 18.sp,
            ),
            disabled: state.status != FormzStatus.valid,
            size: ButtonSize.Medium,
            width: 335.w,
            height: 52.h,
            onPress: () async {
              context.read<ForgotPasswordBloc>().add(SendSubmitted());
            },
          ),
        );
      },
    );
  }
}
