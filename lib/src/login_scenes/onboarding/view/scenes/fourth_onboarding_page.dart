import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/src/login_scenes/onboarding/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const gradeToIcon = {
  0: RemixIcons.building_2_line,
  1: RemixIcons.open_arm_line,
  2: RemixIcons.user_line,
  3: RemixIcons.user_4_line,
  4: RemixIcons.arrow_right_circle_line
};
const educationToValue = {0: "KORPORATION", 1: "PRE_SCHOOL", 2: "UNIVERSITY", 3: "PROFESSIONAL", 4: "OTHER"};

class FourthOnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.bloc<OnboardingBloc>().add(LoadGrades());

    final s = S.of(context);
    final gradeToName = {
      0: s.corporate,
      1: s.pre_university,
      2: s.university,
      3: s.professional_school,
      4: s.other
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
                                  text: s.education,
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
                          children: List.generate(5, (index) {
                            return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0.sp),
                                  side: BorderSide(
                                    color:
                                    state.educationLevel?.value == educationToValue[index]
                                        ? AntColors.blue6
                                        : AntColors.gray3,
                                  ),
                                ),
                                child: ListTile(
                                  onTap: () {
                                    context.read<OnboardingBloc>().add(
                                        EducationLevelChanged(
                                            educationLevel: educationToValue[index]));
                                  },
                                  tileColor:
                                  state.educationLevel?.value == educationToValue[index]
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
                                            color: state.educationLevel?.value ==
                                                educationToValue[index]
                                                ? AntColors.blue6
                                                : Colors.white,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: state.educationLevel?.value ==
                                                  educationToValue[index]
                                                  ? AntColors.blue6
                                                  : AntColors.gray5,
                                            ),
                                          ),
                                          child: state.educationLevel?.value ==
                                              educationToValue[index]
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
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.all(Radius.circular(6.sp)),
                    //       border: Border.all(
                    //         color: AntColors.gray3,
                    //       ),
                    //     ),
                    //     child: Padding(
                    //       padding: EdgeInsets.symmetric(vertical: 8.0.h),
                    //       child: Column(
                    //           children: ListTile.divideTiles(
                    //               context: context,
                    //               color: AntColors.gray4,
                    //               tiles: state.classes.where((element) => element.level == state.gradeLevel.value)
                    //                   .map((e) => ListTile(
                    //                 tileColor:
                    //                 state.gradeClassId?.value == e.id
                    //                     ? AntColors.blue1
                    //                     : Colors.white,
                    //                 dense: false,
                    //                 contentPadding: EdgeInsets.all(20.sp),
                    //                 shape: ContinuousRectangleBorder(
                    //                     side: BorderSide(
                    //                       color: AntColors.gray3,
                    //                     )),
                    //                 onTap: () {
                    //                   context.read<OnboardingBloc>().add(
                    //                       GradeClassChanged(gradeClassId: e.id));
                    //                 },
                    //                 title: BaseText(
                    //                   text: e.name,
                    //                   type: TextTypes.p1,
                    //                   textColor: AntColors.gray8,
                    //                 ),
                    //                 trailing: Container(
                    //                   width: 24.0.sp,
                    //                   height: 24.0.sp,
                    //                   decoration: new BoxDecoration(
                    //                     color: state.gradeClassId?.value == e.id
                    //                         ? AntColors.blue6
                    //                         : Colors.white,
                    //                     shape: BoxShape.circle,
                    //                     border: Border.all(
                    //                       color: state.gradeClassId?.value == e.id
                    //                           ? AntColors.blue6
                    //                           : AntColors.gray5,
                    //                     ),
                    //                   ),
                    //                   child:
                    //                   state.gradeClassId?.value == e.id
                    //                       ? Icon(
                    //                     RemixIcons.check_line,
                    //                     color: Colors.white,
                    //                     size: 16.sp,
                    //                   )
                    //                       : null,
                    //                 ),
                    //               )).toList()).toList()),
                    //     ),
                    //   ),
                    // )
                  ],
                ));
          }
        });
  }

}
