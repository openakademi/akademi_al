import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/src/login_scenes/onboarding/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const gradeToIcon = {
  0: RemixIcons.user_5_line,
  1: RemixIcons.open_arm_line,
  2: RemixIcons.user_line,
  3: RemixIcons.user_4_line
};
const gradeToValue = {0: "PRESCHOOL", 1: "ELEMENTARY", 2: "MIDDLE", 3: "HIGH"};

class FifthOnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.bloc<OnboardingBloc>().add(LoadGrades());

    final s = S.of(context);
    final gradeToName = {
      0: s.preschool,
      1: s.elementary,
      2: s.middle_school,
      3: s.high_school
    };

    return BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (buildContext, state) {
      if (state.classes == null) {
        return Center(
            child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ));
      } else {
        return SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              children: [Container(
                width: MediaQuery.of(context).size.width,
                // height: 224.h,
                color: AntColors.gray2,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0.w, top: 32.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 16.0.h),
                        child: BaseText(
                          text: s.grade,
                          type: TextTypes.h3,
                          lineHeight: 1.3,
                          textColor: AntColors.gray9,
                        ),
                      ),
                      BaseText(
                        text: s.choose_grade_description,
                        textColor: AntColors.gray8,
                        lineHeight: 1.5,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0.h, bottom: 24.h),
                        child: BaseText(
                          text: s.choose_grade_disclaimer,
                          textColor: AntColors.gray8,
                          type: TextTypes.d2,
                          lineHeight: 1.3,
                        ),
                      )
                    ],
                  ),
                ),
              )],
            ),
            Padding(
                padding:
                    EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 24.h),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 20.w,
                  childAspectRatio: 1.6,
                  children: List.generate(4, (index) {
                    return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0.sp),
                          side: BorderSide(
                            color:
                                state.gradeLevel?.value == gradeToValue[index]
                                    ? AntColors.blue6
                                    : AntColors.gray3,
                          ),
                        ),
                        child: ListTile(
                          onTap: () {
                            context.read<OnboardingBloc>().add(
                                GradeLevelChanged(
                                    gradeLevel: gradeToValue[index]));
                          },
                          tileColor:
                              state.gradeLevel?.value == gradeToValue[index]
                                  ? AntColors.blue1
                                  : Colors.white,
                          title: Stack(children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 26.0.h),
                                    child: Icon(
                                      gradeToIcon[index],
                                      color: AntColors.gray6,
                                      size: 24.sp,
                                    ),
                                  ),
                                  BaseText(
                                    text: gradeToName[index],
                                    textColor: AntColors.gray8,
                                    fontSize: 16.sp,
                                    lineHeight: 1.5,
                                  )
                                ]),
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.0.h),
                                child: Container(
                                  width: 16.0.sp,
                                  height: 16.0.sp,
                                  decoration: new BoxDecoration(
                                    color: state.gradeLevel?.value ==
                                            gradeToValue[index]
                                        ? AntColors.blue6
                                        : Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: state.gradeLevel?.value ==
                                              gradeToValue[index]
                                          ? AntColors.blue6
                                          : AntColors.gray5,
                                    ),
                                  ),
                                  child: state.gradeLevel?.value ==
                                          gradeToValue[index]
                                      ? Icon(
                                          RemixIcons.check_line,
                                          color: Colors.white,
                                          size: 10.sp,
                                        )
                                      : null,
                                ),
                              ),
                            )
                          ]),
                        ));
                  }),
                )),
            state.gradeLevel != null ? Padding(
              padding: EdgeInsets.only(top: 40.0.h, left: 20.0.w),
              child: state.gradeLevel.value.isEmpty ? null :BaseText(
                  text: s.what_grade_question,
                  textColor: AntColors.gray8,
                  align: TextAlign.left),
            ) : Container(),
            state.gradeLevel != null ? Padding(
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
                          tiles: state.classes.where((element) => element.level == state.gradeLevel.value)
                              .map((e) => ListTile(
                                    tileColor:
                                        state.gradeClassId?.value == e.id
                                            ? AntColors.blue1
                                            : Colors.white,
                                    dense: false,
                                    contentPadding: EdgeInsets.all(20.sp),
                                    shape: ContinuousRectangleBorder(
                                        side: BorderSide(
                                      color: AntColors.gray3,
                                    )),
                                    onTap: () {
                                      context.read<OnboardingBloc>().add(
                                          GradeClassChanged(gradeClassId: e.id));
                                    },
                                    title: BaseText(
                                      text: e.name,
                                      type: TextTypes.p1,
                                      textColor: AntColors.gray8,
                                    ),
                                    trailing: Container(
                                      width: 24.0.sp,
                                      height: 24.0.sp,
                                      decoration: new BoxDecoration(
                                        color: state.gradeClassId?.value == e.id
                                            ? AntColors.blue6
                                            : Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: state.gradeClassId?.value == e.id
                                              ? AntColors.blue6
                                              : AntColors.gray5,
                                        ),
                                      ),
                                      child:
                                      state.gradeClassId?.value == e.id
                                              ? Icon(
                                                  RemixIcons.check_line,
                                                  color: Colors.white,
                                                  size: 16.sp,
                                                )
                                              : null,
                                    ),
                                  )).toList()).toList()),
                ),
              ),
            ) : Container()
          ],
        ));
      }
    });
  }

}
