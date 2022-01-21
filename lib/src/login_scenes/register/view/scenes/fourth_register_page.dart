import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/input/text_input.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/src/login_scenes/register/bloc/register_bloc.dart';
import 'package:akademi_al_mobile_app/src/login_scenes/register/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FourthRegistrationPage extends StatelessWidget {
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
              children: [
                BaseText(
                  text: s.create_a_password,
                  type: TextTypes.h3,
                  textColor: AntColors.gray9,
                  align: TextAlign.center,
                ),
                Padding(
                    padding: EdgeInsets.only(
                      top: 16.0.h,
                      bottom: 16.0.h,
                    ),
                    child: Image.asset(
                      "assets/images/registration_4/registration_4.png",
                      fit: BoxFit.cover,
                      width: 344.w,
                      height: 168.h,
                    )),
                _PasswordInput(s: s),
                _PasswordErrors(
                  text: s.at_least_8_chars,
                  hasError: state.password.error != null && state.password.error
                      .contains(PasswordFieldValidationError.noEightChars),
                ),
                _PasswordErrors(
                  text: s.at_least_1_macro,
                  hasError: state.password.error != null &&  state.password.error
                      .contains(PasswordFieldValidationError.noMacro),
                ),
                _PasswordErrors(
                  text: s.at_least_a_special_char,
                  hasError:state.password.error != null &&  state.password.error
                      .contains(PasswordFieldValidationError.noSpecialChar),
                ),
                _PasswordErrors(
                  text: s.at_least_a_number,
                  hasError: state.password.error != null &&  state.password.error
                      .contains(PasswordFieldValidationError.notNumber),
                ),
              ]),
        );
      },
      buildWhen: (previous, current) {
        return current.password != previous.password;
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  final s;

  const _PasswordInput({Key key, this.s}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(bottom: 26.0.h),
          child: TextInput(
            initialValue: state.password.value,
            onChanged: (password) => context
                .read<RegisterBloc>()
                .add(RegisterPasswordChanged(password)),
            labelText: s.password,
            isPassword: true,
          ),
        );
      },
    );
  }
}

class _PasswordErrors extends StatelessWidget {
  final bool hasError;
  final String text;

  const _PasswordErrors({Key key, this.hasError, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(
            hasError
                ? RemixIcons.error_warning_fill
                : RemixIcons.checkbox_circle_fill,
            size: 16,
            color: hasError ? AntColors.orange6 : AntColors.green6,
          ),
          BaseText(
            text: text,
            type: TextTypes.d2,
            textColor: AntColors.gray8,
            align: TextAlign.center,
            horizontalPadding: 8.w,
          ),
        ],
      ),
    );
  }
}
