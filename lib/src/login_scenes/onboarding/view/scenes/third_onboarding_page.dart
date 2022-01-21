
import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/profile_picture/profile_picture.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/components/uploader/uploader.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/onboarding/profile_picture_file.dart';
import 'package:akademi_al_mobile_app/src/login_scenes/onboarding/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ThirdOnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final s = S.of(context);
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (buildContext, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 136.h,
                color: AntColors.gray2,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0.w, top: 32.h),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 16.0.h),
                            child: BaseText(
                              text: s.third_onboarding_page_title,
                              type: TextTypes.h3,
                              lineHeight: 1.3,
                              textColor: AntColors.gray9,
                            ),
                          ),
                          BaseText(
                            text: s.choose_profile_picture_description,
                            textColor: AntColors.gray8,
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 16.0.h, left: 8.w),
                        child: ProfilePicture(
                          shape: BoxShape.circle,
                          size: 40.sp,
                          profilePicture: state.profilePicture.value,
                          profilePictureType: state.profilePictureType,
                          file: state.wizard.state.profilePictureFile,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 24.h),
                child: GridView.count(
                    shrinkWrap:true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 20.w,
                  children: List.generate(43, (index) {
                    if(index == 0) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0.sp),
                          side: BorderSide(
                            color: state.profilePictureType == "static" ? state.profilePicture?.value ==
                                "student${index}.svg" ||
                                state.profilePicture?.value ==
                                    "student${index}.png" ?
                            AntColors.blue6 : AntColors.gray3: AntColors.blue6,
                          ),
                        ),
                        child: Center(
                          child: Uploader(
                            authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context),
                            onUpload: (ProfilePictureFile file) {
                              context.read<OnboardingBloc>().add(ProfilePictureUploaded(file: file));
                            },
                            file: state.wizard.state.profilePictureFile,
                          ),
                        ),
                      );
                    } else {
                      return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0.sp),
                            side: BorderSide(
                              color:  state.profilePicture?.value ==
                                  "student${index}.svg" ||
                                  state.profilePicture?.value ==
                                      "student${index}.png" ?
                              AntColors.blue6 : AntColors.gray3,
                            ),
                          ),
                          child: ListTile(
                            onTap: () {
                              context.read<OnboardingBloc>().add(
                                  ProfilePictureChanged(profilePicture:
                                  index < 9
                                      ? "student$index.svg"
                                      : "student$index.png"
                                  ));
                            },
                            tileColor:
                            state.profilePicture?.value ==
                                "student$index.svg" ||
                                state.profilePicture?.value ==
                                    "student$index.png"
                                ? AntColors.blue1
                                : Colors.white
                            ,
                            title: Stack(children: [
                              Center(
                                  child: index < 9
                                      ? SvgPicture.asset(
                                      "assets/avatars/student$index.svg",
                                      width: 78.sp,
                                      height: 78.sp)
                                      : Image.asset(
                                    "assets/avatars/student$index.png",
                                    width: 78.sp,
                                    height: 78.sp,
                                  )),
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 8.0.h),
                                  child: Container(
                                    width: 16.0.sp,
                                    height: 16.0.sp,
                                    decoration: new BoxDecoration(
                                      color: state.profilePicture?.value ==
                                          "student$index.svg" ||
                                          state.profilePicture?.value ==
                                              "student$index.png"
                                          ? AntColors.blue6
                                          : Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: state.profilePicture?.value ==
                                            "student$index.svg" ||
                                            state.profilePicture?.value ==
                                                "student$index.png"
                                            ? AntColors.blue6
                                            : AntColors.gray5,
                                      ),
                                    ),
                                    child: state.profilePicture?.value ==
                                        "student$index.svg" ||
                                        state.profilePicture?.value ==
                                            "student$index.png"
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
                    }
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
