import 'dart:ui';

import 'package:akademi_al_mobile_app/components/button/button.dart';
import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/src/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/user/models.dart';
import 'package:akademi_al_mobile_app/packages/onboarding_repository/lib/onboarding_api_provider.dart';
import 'package:akademi_al_mobile_app/src/login_scenes/onboarding/bloc/onboarding_bloc.dart';
import 'package:akademi_al_mobile_app/src/select_organization/view/scenes/select_organization.dart';
import 'package:akademi_al_mobile_app/src/synchronization/view/synchronization_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';

import 'components/onboarding_tracker.dart';
import 'scenes/sixth_onboarding_page.dart';
import 'scenes/first_onboarding_page.dart';
import 'scenes/fifth_onboarding_page.dart';
import 'scenes/fourth_onboarding_page.dart';
import 'scenes/second_onboarding_page.dart';
import 'scenes/seventh_onboarding_page.dart';
import 'scenes/third_onboarding_page.dart';

class OnboardingPage extends StatefulWidget {
  final User user;

  OnboardingPage(this.user);

  static Route route(User user) {
    return MaterialPageRoute<void>(
        builder: (_) => BlocProvider(
            create: (context) {
              return OnboardingBloc(
                  apiProvider:
                      RepositoryProvider.of<OnboardingApiProvider>(context),
                  authenticationRepository:
                      RepositoryProvider.of<AuthenticationRepository>(context));
            },
            child: OnboardingPage(user)));
  }

  @override
  _OnboardingPageState createState() => _OnboardingPageState(user);
}

class _OnboardingPageState extends State<OnboardingPage> {
  PageController _controller;
  final User user;

  final List<Widget> onboardingPages = [
    FirstOnboardingPage(),
    SecondOnboardingPage(),
    ThirdOnboardingPage(),
    FourthOnboardingPage(),
    FifthOnboardingPage(),
    SixthOnboardingPage(),
    SeventhOnboardingPage(),
  ];

  @override
  void initState() {
    super.initState();
    context.read<OnboardingBloc>().add(LoadOnboarding());
  }

  _OnboardingPageState(this.user);

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final Map<int, String> pageTitles = {
      0: s.fill_your_profile,
      1: s.second_onboarding_page_title,
      2: s.third_onboarding_page_title,
      3: s.fourth_onboarding_page_title,
      4: s.fifth_onboarding_page_title,
      5: s.sixth_onboarding_page_title,
      6: s.seventh_onboarding_page_title,
    };

    return BlocListener<OnboardingBloc, OnboardingState>(
      listenWhen: (previous, current) {
        return previous.finished != current.finished;
      },
      listener: (context, state) {
        if (state.finished) {
          Navigator.of(context).pushAndRemoveUntil<void>(
            SelectOrganization.route(false),
            (route) => false,
          );
        }
      },
      child: BlocBuilder<OnboardingBloc, OnboardingState>(
          buildWhen: (previous, current) {
        return previous.loading != current.loading ||
            previous.currentIndex != current.currentIndex;
      }, builder: (buildContext, state) {
        if (state.loading) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              actions: [
              ],
              title: new BaseText(
                text: pageTitles[state.currentIndex],
                letterSpacing: -0.4,
                weightType: FontWeight.w600,
                lineHeight: 1.21,
              ),
            ),
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            ),
          );
        } else {
          _controller = PageController(
            initialPage: state.currentIndex,
          );
          return Scaffold(
            backgroundColor:
                state.currentIndex == 0 ? AntColors.blue1 : Colors.white,
            appBar: AppBar(
              elevation: 1,
              backgroundColor: Colors.white,
              leading: state.currentIndex != 0
                  ? IconButton(
                      icon: Icon(RemixIcons.arrow_left_line,
                          color: AntColors.blue6),
                      onPressed: () => {
                        if (state.currentIndex == 0)
                          {Navigator.of(context).pop()}
                        else
                          {context.bloc<OnboardingBloc>().add(PreviousPage())}
                      },
                    )
                  : null,
              title: new BaseText(
                text: pageTitles[state.currentIndex],
                letterSpacing: -0.4,
                weightType: FontWeight.w600,
                lineHeight: 1.21,
              ),
            ),
            body: BlocListener<OnboardingBloc, OnboardingState>(
              listener: (context, state) {
                FocusScope.of(context).unfocus();
                _controller.jumpToPage(state.currentIndex);
              },
              listenWhen: (previous, current) {
                return previous.currentIndex != current.currentIndex;
              },
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _controller,
                  itemBuilder: (context, position) {
                    return onboardingPages.elementAt(position);
                  },
                ),
              ),
            ),
            bottomNavigationBar: Material(
              elevation: state.currentIndex == 0 ? 0 : 60,
              color: state.currentIndex == 0 ? AntColors.blue1 : Colors.white,
              child: Container(
                  decoration: BoxDecoration(
                    color: state.currentIndex == 0
                        ? Colors.white
                        : AntColors.blue1,
                    borderRadius: state.currentIndex == 0
                        ? BorderRadius.vertical(top: Radius.circular(30))
                        : null,
                  ),
                  height: state.currentIndex == 0 ? 360.h : 108.h,
                  child: state.currentIndex == 0
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.only(
                                  left: 24.w, right: 21.w, top: 19.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  BaseText(
                                    text: s.welcome_name(
                                        "${user.firstName} ${user.lastName}"),
                                    type: TextTypes.h3,
                                    lineHeight: 1.3,
                                    textColor: AntColors.gray9,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 16.h),
                                    child: BaseText(
                                      text: s.welcome_description,
                                      type: TextTypes.p2,
                                      textColor: AntColors.gray8,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                            Padding(
                              padding: EdgeInsets.only(bottom: 50.h),
                              child: _BottomNextRow(state, s),
                            )
                          ],
                        )
                      : _BottomNextRow(state, s)),
            ),
          );
        }
      }),
    );
  }
}

class _BottomNextRow extends StatelessWidget {
  final state;
  final s;

  _BottomNextRow(this.state, this.s);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
        buildWhen: (previous, current) {
      return previous.getPageStatus(state.currentIndex) !=
              current.getPageStatus(state.currentIndex) ||
          previous.currentIndex != current.currentIndex || previous.educationLevel != current.educationLevel;
    }, builder: (buildContext, state) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: OnboardingTracker(
              index: state.currentIndex + 1,
            ),
          ),
          state.currentIndex == 6
              ? MainTextButton(
            onPress: () {
              context.read<OnboardingBloc>().add(FinishOnboarding());
            },
                  customText: BaseText(
                    text: s.skip,
                    fontSize: 17.sp,
                    lineHeight: 1.64,
                    letterSpacing: -0.75,
                    weightType: FontWeight.w500,
                    textColor: AntColors.blue6,
                  ),
                )
              : Container(width: 0, height: 0,),
          Padding(
            padding: EdgeInsets.only(right: 20.0.w, top: 16.h),
            child: MainButton(
              text: s.continue_label,
              size: ButtonSize.Medium,
              width: 134.w,
              height: 52.h,
              disabled:
                  state.getPageStatus(state.currentIndex) != FormzStatus.valid,
              suffixIcon: Icon(
                RemixIcons.arrow_right_line,
                color:
                    state.getPageStatus(state.currentIndex) == FormzStatus.valid
                        ? Colors.white
                        : AntColors.gray6,
                size: 17.sp,
              ),
              onPress: () {
                if(state.currentIndex == 3 && state.educationLevel.value != "PRE_SCHOOL"){
                  print(state.educationLevel.value);
                  context.read<OnboardingBloc>().add(FinishOnboarding());
                } else if (state.currentIndex < 6) {
                  context.read<OnboardingBloc>().add(NextPage());
                } else {
                  context.read<OnboardingBloc>().add(FinishOnboarding());
                }
              },
            ),
          ),
        ],
      );
    });
  }
}
