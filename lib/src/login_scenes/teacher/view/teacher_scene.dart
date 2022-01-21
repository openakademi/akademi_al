import 'package:akademi_al_mobile_app/components/button/button.dart';
import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/http_client/lib/http_client.dart';
import 'package:akademi_al_mobile_app/src/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class TeacherScene extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => TeacherScene());
  }

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "assets/images/information_1_background/information_1_background.png"),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            ),
          ),
        ),
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: new BaseText(
              text: s.teacher_profile,
              letterSpacing: -0.4,
              weightType: FontWeight.w600,
              lineHeight: 1.21,
            ),
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(RemixIcons.arrow_left_line, color: AntColors.blue6),
              onPressed: () => {
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationLogoutRequested())
              },
            ),
          ),
          backgroundColor: Colors.transparent,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 40.0.h),
                child: Center(
                  child: Image.asset(
                    "assets/images/teacher/teacher.png",
                    fit: BoxFit.cover,
                    width: 141.w,
                    height: 96.h,
                  ),
                ),
              ),
              BaseText(
                text: s.login_in_as_teacher,
                textColor: AntColors.blue9,
                align: TextAlign.center,
                lineHeight: 1.3,
                verticalPadding: 16,
                horizontalPadding: 20,
                type: TextTypes.h3,
              ),
              BaseText(
                text: s.teacher_message,
                align: TextAlign.center,
                horizontalPadding: 20,
                textColor: AntColors.gray8,
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.0.h),
                child: BaseText(
                  text: "Ndërkohe ju mund të përdorni versionin web.",
                  align: TextAlign.center,
                  horizontalPadding: 20,
                  textColor: AntColors.gray8,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 38.h, left: 20.w, right: 20.w),
                child: MainButton(
                  text: s.open_website,
                  size: ButtonSize.Medium,
                  width: 335.w,
                  height: 52.h,
                  suffixIcon: Icon(
                    RemixIcons.arrow_right_up_line,
                    color: Colors.white,
                    size: 18.sp,
                  ),
                  onPress: () async {
                    const url = Urls.browserBaseUrl;
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      print("can't open");
                    }
                  },
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BaseText(
                      text: s.got_an_account,
                      horizontalPadding: 0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: SizedBox(
                        height: 28,
                        child: MainTextButton(
                          onPress: () {
                            context
                                .read<AuthenticationBloc>()
                                .add(AuthenticationLogoutRequested());
                          },
                          customText:BaseText(
                            text: s.enter_here,
                            textColor: AntColors.blue6,
                            horizontalPadding: 0,
                            align: TextAlign.start,
                            verticalPadding: 0,
                            type: TextTypes.p2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
