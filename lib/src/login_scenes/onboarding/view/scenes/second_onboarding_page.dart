import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/src/login_scenes/onboarding/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecondOnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Column(
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
                    text: s.second_onboarding_page_title,
                    type: TextTypes.h3,
                    lineHeight: 1.3,
                    textColor: AntColors.gray9,
                  ),
                ),
                BaseText(
                  text: s.choose_state,
                  textColor: AntColors.gray8,
                )
              ],
            ),
          ),
        ),
        _ChooseStateWidget()
      ],
    );
  }
}

class _ChooseStateWidget extends StatefulWidget {
  @override
  __ChooseStateWidgetState createState() => __ChooseStateWidgetState();
}

class __ChooseStateWidgetState extends State<_ChooseStateWidget> {
  String value;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (buildContext, state) {
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
                  children: ListTile.divideTiles(context: context,color: AntColors.gray4, tiles: [
                ListTile(
                  tileColor: state.nationality?.value == "ALBANIA" ? AntColors.blue1 : Colors.white,
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
                    context.read<OnboardingBloc>().add(NationalityChanged(nationality: "ALBANIA"));
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
                      color: state.nationality?.value == "ALBANIA" ? AntColors.blue6 : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color:state.nationality?.value == "ALBANIA" ? AntColors.blue6: AntColors.gray5,
                      ),
                    ),
                    child:state.nationality?.value == "ALBANIA" ? Icon(RemixIcons.check_line, color: Colors.white, size: 16.sp,): null,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(20.sp),
                  tileColor: state.nationality?.value == "KOSOVO" ? AntColors.blue1 : Colors.white,
                  onTap: () {
                    context.bloc<OnboardingBloc>().add(NationalityChanged(nationality: "KOSOVO"));
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
                      color: state.nationality?.value == "KOSOVO" ? AntColors.blue6 : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color:state.nationality?.value == "KOSOVO" ? AntColors.blue6: AntColors.gray5,
                      ),
                    ),
                    child:state.nationality?.value == "KOSOVO" ? Icon(RemixIcons.check_line, color: Colors.white, size: 16.sp,): null,
                  ),
                ),
                ListTile(
                  tileColor: state.nationality?.value == "OTHER" ? AntColors.blue1 : Colors.white,
                  contentPadding: EdgeInsets.all(20.sp),
                  dense: false,
                  onTap: () {
                    context.bloc<OnboardingBloc>().add(NationalityChanged(nationality: "OTHER"));
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
                      color: state.nationality?.value == "OTHER" ? AntColors.blue6 : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color:state.nationality?.value == "OTHER" ? AntColors.blue6: AntColors.gray5,
                      ),
                    ),
                    child:state.nationality?.value == "OTHER" ? Icon(RemixIcons.check_line, color: Colors.white, size: 16.sp,): null,
                  ),
                )
              ]).toList()),
            ),
          ),
        );
      },
    );
  }
}
