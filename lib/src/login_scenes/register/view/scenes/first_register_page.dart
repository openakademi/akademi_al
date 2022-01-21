import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/input/text_input.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/src/login_scenes/register/bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FirstRegistrationPage extends StatelessWidget {
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
                  text: s.whats_your_name,
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
                      "assets/images/registration_1/registration_1.png",
                      fit: BoxFit.cover,
                      width: 344.w,
                      height: 168.h,
                    )),
                _NameInput(s: s),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: _SurnameInput(s: s),
                ),
              ]),
        );
      },
      buildWhen: (previous, current) {
        return current.firstPageStatus != previous.firstPageStatus;
      },
    );
  }
}

class _NameInput extends StatelessWidget {
  final s;

  const _NameInput({Key key, this.s}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(bottom: 26.0.h, top: 16.0.h),
          child: TextInput(
            height: 54.h,
            initialValue: state.name.value,
            onChanged: (name) =>
                context.read<RegisterBloc>().add(RegisterNameChanged(name)),
            labelText: s.name,
          ),
        );
      },
    );
  }
}

class _SurnameInput extends StatelessWidget {
  final s;

  const _SurnameInput({Key key, this.s}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.surname != current.surname,
      builder: (context, state) {
        return TextInput(
          height: 54.h,
          initialValue: state.surname.value,
          onChanged: (password) => context
              .read<RegisterBloc>()
              .add(RegisterSurnameChanged(password)),
          labelText: s.surname,
        );
      },
    );
  }
}
