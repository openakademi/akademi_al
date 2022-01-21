import 'package:akademi_al_mobile_app/components/button/button.dart';
import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/layouts/keyboard_aware_layout.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/src/login_scenes/register/bloc/register_bloc.dart';
import 'package:akademi_al_mobile_app/src/login_scenes/register/view/scenes/resend_email.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:url_launcher/url_launcher.dart';

import 'components/register_tracker.dart';
import 'scenes/first_register_page.dart';
import 'scenes/fourth_register_page.dart';
import 'scenes/second_register_page.dart';
import 'scenes/successfull_register.dart';
import 'scenes/third_register_page.dart';

class RegisterPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => BlocProvider(
            create: (context) {
              return RegisterBloc(
                  RepositoryProvider.of<AuthenticationRepository>(context));
            },
            child: RegisterPage()));
  }

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  PageController _controller = PageController(
    initialPage: 0,
  );
  final List<Widget> registerPages = [
    FirstRegistrationPage(),
    SecondRegistrationPage(),
    ThirdRegistrationPage(),
    FourthRegistrationPage()
  ];

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (buildContext, state) {
        if (state.resendEmail) {
          return ResendEmailScreen();
        }
        if (state.registrationSuccess) {
          return RegisterSuccess();
        } else {
          return BlocListener<RegisterBloc, RegisterState>(
            listenWhen: (previus, next) {
              return previus.existingUser != null &&
                  next.existingUser != null &&
                  previus.existingUser != next.existingUser;
            },
            listener: (context, state) {
              if (state.existingUser != null && state.existingUser) {
                Flushbar(
                  icon: Icon(
                    RemixIcons.information_line,
                    color: AntColors.red6,
                    size: 16.sp,
                  ),
                  flushbarPosition: FlushbarPosition.TOP,
                  titleText: BaseText(
                    type: TextTypes.p2,
                    weightType: FontWeight.w600,
                    text: s.wrong,
                    textColor: AntColors.red6,
                  ),
                  messageText: BaseText(
                    type: TextTypes.d2,
                    text: s.email_exists,
                    textColor: AntColors.red6,
                  ),
                  backgroundColor: AntColors.red1,
                  duration: Duration(seconds: 5),
                )..show(context);
              }
            },
            child: KeyboardAwareLayout(
              title: new BaseText(
                text: S.of(context).register,
                letterSpacing: -0.4,
                weightType: FontWeight.w600,
                lineHeight: 1.21,
              ),
              leading: IconButton(
                icon: Icon(RemixIcons.arrow_left_line, color: AntColors.blue6),
                onPressed: () => {
                  if (state.currentIndex == 0)
                    {Navigator.of(context).pop()}
                  else
                    {context.bloc<RegisterBloc>().add(PreviousPage())}
                },
              ),
              following: RegisterTracker(
                index: state.currentIndex + 1,
              ),
              backgroundImage: AssetImage(
                  "assets/images/information_1_background/information_1_background.png"),
              body: BlocListener<RegisterBloc, RegisterState>(
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
                      return registerPages.elementAt(position);
                    },
                  ),
                ),
              ),
              bottomBar: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: state.currentIndex == 3
                    ? MainAxisAlignment.spaceAround
                    : MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: state.currentIndex == 3
                        ? EdgeInsets.only(top: 16.h)
                        : EdgeInsets.only(right: 20.0.w, top: 16.h),
                    child: MainButton(
                      text: state.currentIndex == 3 ? s.end : s.continue_label,
                      size: ButtonSize.Medium,
                      width: state.currentIndex == 3 ? 335.w : 134.w,
                      height: 52.h,
                      disabled: state.getPageStatus(state.currentIndex) !=
                              FormzStatus.valid ||
                          (state.submitting != null && state.submitting),
                      suffixIcon: Icon(
                        RemixIcons.arrow_right_line,
                        color: state.getPageStatus(state.currentIndex) ==
                                FormzStatus.valid
                            ? Colors.white
                            : AntColors.gray6,
                        size: 17.sp,
                      ),
                      onPress: () async {
                        if (state.currentIndex < 3) {
                          context.bloc<RegisterBloc>().add(NextPage());
                        } else {
                          context
                              .bloc<RegisterBloc>()
                              .add(FinishRegistration("asd"));
                        }
                      },
                    ),
                  ),
                ],
              ),
              disclaimer: state.currentIndex == 3
                  ? RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: s.term_and_conditions,
                        style: defaultTextStyles[TextTypes.d1].copyWith(
                          height: 1.3,
                        ),
                        children: [
                          TextSpan(
                            text: s.privacy_policy_registration,
                            style: TextStyle(color: AntColors.blue6),
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () async {
                                final url = "https://app.akademi.al/login/privacy-policy";
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                          ),
                          TextSpan(
                            text: " dhe ",
                          ),
                          TextSpan(
                              text: s.usage_policy_registration,
                              style: TextStyle(color: AntColors.blue6),
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () async {
                                final url = "https://app.akademi.al/login/terms-of-service";
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },

                          )
                        ],
                      ))
                  : null,
            ),
          );
        }
      },
    );
  }
}
