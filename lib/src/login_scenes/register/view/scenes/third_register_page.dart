import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/input/text_input.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/src/login_scenes/register/bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';

class ThirdRegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: _checkIfUnder13(state.isUnder13, s)),
        );
      },
      buildWhen: (previous, current) {
        return current.firstPageStatus != previous.firstPageStatus;
      },
    );
  }

  _checkIfUnder13(bool isUnder13, S s) {

    if (!isUnder13) {
      return [
        BaseText(
          text: s.your_email,
          type: TextTypes.h3,
          textColor: AntColors.gray9,
          align: TextAlign.center,
        ),
        Padding(
            padding: EdgeInsets.only(
              left: 16.0.w,
              right: 16.0.w,
              top: 16.0.h,
              bottom: 16.0.h,
            ),
            child: Image.asset(
              "assets/images/registration_3/registration_3.png",
              fit: BoxFit.cover,
              width: 344.w,
              height: 168.h,
            )),
        _EmailInput(s: s, over13: true)
      ];
    } else {
      return [
        Padding(
          padding: EdgeInsets.only(bottom: 16.0.h),
          child: BaseText(
            text: s.parent_email,
            type: TextTypes.h3,
            textColor: AntColors.gray9,
            align: TextAlign.center,
            lineHeight: 1.3,
          ),
        ),
        BaseText(
          text: s.parent_email_description,
          type: TextTypes.p2,
          textColor: AntColors.gray8,
          align: TextAlign.center,
        ),
        Padding(
            padding: EdgeInsets.only(
              left: 16.0.w,
              right: 16.0.w,
              top: 16.0.h,
              bottom: 16.0.h,
            ),
            child: Image.asset(
              "assets/images/registration_3/registration_3.png",
              fit: BoxFit.cover,
              width: 344.w,
              height: 168.h,
            )),
        _EmailInput(s: s, over13: false),
        _UsernameInput(s: s)
      ];
    }
  }
}

class _EmailInput extends StatelessWidget {
  final S s;
  final bool over13;

  const _EmailInput({Key key, this.s, this.over13}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.email != current.email && previous.thirdPageStatus != current.thirdPageStatus,
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
            errorText: state.email.invalid ?  s.wrong_email : null,
            initialValue: state.email.value,
            onChanged: (email) =>
                context.bloc<RegisterBloc>().add(RegisterEmailChanged(email)),
            labelText: over13 ? s.email: s.parent_email_label,
            hintText: over13 ? s.example_email: s.example_parent_email,
          ),
        );
      },
    );
  }
}

class _UsernameInput extends StatelessWidget {
  final s;

  const _UsernameInput({Key key, this.s}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(bottom: 26.0.h),
          child: TextInput(
            prefixIcon: Icon(
              RemixIcons.account_pin_box_line,
              color: AntColors.gray7,
              size: 20.sp,
            ),
            height: 54.h,
            initialValue: state.username.value,
            onChanged: (username) =>
                context.bloc<RegisterBloc>().add(RegisterUsernameChanged(username)),
            labelText: s.username_label,
          ),
        );
      },
    );
  }
}


