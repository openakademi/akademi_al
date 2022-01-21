import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/input/text_input.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/src/login_scenes/onboarding/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SeventhOnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        width: MediaQuery.of(context).size.width,
        height: 136.h,
        color: AntColors.gray2,
        child: Padding(
          padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 32.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 16.0.h),
                child: BaseText(
                  text: s.sixth_onboarding_page_title,
                  type: TextTypes.h3,
                  lineHeight: 1.3,
                  textColor: AntColors.gray9,
                ),
              ),
              BaseText(
                text: s.virtual_class_description,
                textColor: AntColors.gray8,
                lineHeight: 1.5,
              )
            ],
          ),
        ),
      ),
      // Padding(
      //     padding: EdgeInsets.only(
      //       top: 24.0.h,
      //       bottom: 8.h,
      //     ),
      //     child: Image.asset(
      //       "assets/images/registration_4/registration_4.png",
      //       fit: BoxFit.cover,
      //       width: 335.w,
      //       height: 144.h,
      //     )),
      Padding(
        padding: EdgeInsets.only(left: 20.0.w, right: 20.w, bottom: 20.h),
        child: Card(
          color: AntColors.blue1,
          elevation: 0,
          borderOnForeground: true,
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: AntColors.blue4),
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          child: Column(
            children: <Widget>[
              ExpansionTile(
                  initiallyExpanded: false,
                  // dense: true,
                  //   visualDensity: VisualDensity(horizontal: 0.0),
                  //   contentPadding: EdgeInsets.only(
                  //       left: 26.0.w, bottom: 16.0.h, right: 16.0.w, top: 16.0.h),
                  childrenPadding: EdgeInsets.all(8.0),
                  leading: Icon(
                    RemixIcons.information_line,
                    color: AntColors.blue6,
                    size: 24.sp,
                  ),
                  title: Row(children: [
                    BaseText(
                      padding: EdgeInsets.only(top: 8, bottom: 8.h, left: 0),
                      text: s.what_is_a_virtual_class,
                      type: TextTypes.p1,
                      // verticalPadding: 8,
                      textColor: AntColors.gray9,
                    )
                  ]),
                  children: [
                    Row(children: [
                      SizedBox(
                        width: 60.w,
                      ),
                      Flexible(
                          child: Padding(
                        padding: EdgeInsets.only(bottom: 16.0.h),
                        child: BaseText(
                          text: s.what_is_a_virtual_class_description,
                          type: TextTypes.d1,
                          lineHeight: 1.57,
                          textColor: AntColors.gray8,
                          letterSpacing: 0,
                        ),
                      )),
                    ])
                  ]),
            ],
          ),
          // shape:
        ),
      ),

      Row(
        children: [
          BaseText(
            padding: EdgeInsets.only(left: 20.0.w),
            text: s.virtual_class_code,
            type: TextTypes.p2,
            textColor: AntColors.gray9,
          ),
          BaseText(
            text: s.not_neccesessary,
            type: TextTypes.p2,
            textColor: AntColors.gray5,
          ),
        ],
      ),
      Padding(
        padding: EdgeInsets.only(left: 20.0.w, right: 20.w),
        child: _VirtualClassCodeInput(
          s: s,
        ),
      ),
    ]));
  }
}

class _VirtualClassCodeInput extends StatelessWidget {
  final s;

  const _VirtualClassCodeInput({Key key, this.s}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(bottom: 26.0.h, top: 16.0.h),
          child: TextInput(
            prefixIcon: Icon(
              RemixIcons.door_open_line,
              size: 20.sp,
              color: AntColors.gray6,
            ),
            height: 54.h,
            errorText: state.errorVirtualClassCode,
            initialValue: state.virtualClassCode,
            onChanged: (code) => context
                .read<OnboardingBloc>()
                .add(VirtualClassCodeChanged(code)),
            labelText: s.virtual_class_code_label,
          ),
        );
      },
    );
  }
}
