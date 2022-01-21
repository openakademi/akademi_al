import 'dart:io';

import 'package:akademi_al_mobile_app/components/button/button.dart';
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
import 'package:formz/formz.dart';

class SecondRegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              BaseText(
                text: s.birthday_question,
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
                    "assets/images/registration_2/registration_2.png",
                    fit: BoxFit.cover,
                    width: 344.w,
                    height: 168.h,
                  )),
              _BirthdayInput(s: s),
            ]),
      );
    });
  }
}

class _BirthdayInput extends StatelessWidget {
  final S s;

  const _BirthdayInput({Key key, this.s}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.birthday != current.birthday,
      builder: (context, state) {

        return Padding(
          padding: EdgeInsets.only(bottom: 26.0.h, top: 16.0.h),
          child: TextInput(
            height: 54.h,
            initialValue: state.birthday.value,
            errorText: state.secondPageStatus == FormzStatus.invalid
                ? state.birthday.error ==
                    NonEmptyBirthdayFieldValidationError.under3 ? s.no_users_under_3 : "E detyrueshme"
                : null,
            isDatePicker: true,
            onChanged: (birthday) => {
              context
                  .read<RegisterBloc>()
                  .add(RegisterBirthdayChanged(birthday))
            },
            labelText: Platform.isAndroid? s.birthday: s.birth_year,
          ),
        );
      },
    );
  }
}
