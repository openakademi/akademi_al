import 'package:akademi_al_mobile_app/components/button/button.dart';
import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/src/login_scenes/register/bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocBuilder<RegisterBloc, RegisterState>(
        builder: (buildContext, state) {
          return Stack(
            children: [
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
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                      icon:
                      Icon(RemixIcons.arrow_left_line, color: AntColors.blue6),
                      onPressed: () => Navigator.of(context).pop(),
                    )),
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Column(
                    children: [
                      Icon(
                        RemixIcons.mail_send_line,
                        color: AntColors.blue6,
                        size: 80.sp,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 16.0.h, top: 24.h),
                        child: BaseText(
                          text: s.check_email_to_finish_registration,
                          type: TextTypes.h3,
                          textColor: AntColors.gray9,
                          lineHeight: 1.3,
                        ),
                      ),
                      RichText(
                          text: TextSpan(
                              text: s.registration_success_description_1,
                              style: defaultTextStyles[TextTypes.p2].copyWith(
                                color: AntColors.gray8,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: state.email.value,
                                    style: defaultTextStyles[TextTypes.p2]
                                        .copyWith(fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: s
                                        .registration_success_description_2,
                                    style: defaultTextStyles[TextTypes.p2]
                                        .copyWith(
                                      color: AntColors.gray8,
                                    )),
                              ])),
                      _ResendButton(s: s),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 60.0.h),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                BaseText(
                                  text: s.email_not_recived,
                                  type: TextTypes.d1,
                                  textColor: AntColors.gray7,
                                  align: TextAlign.center,
                                ),
                                MainTextButton(
                                  onPress: () {
                                    context.read<RegisterBloc>().add(ResendEmail());
                                  },
                                  customText: BaseText(
                                    text: s.resend_email,
                                    type: TextTypes.p2,
                                    weightType: FontWeight.w500,
                                    textColor: AntColors.blue6,
                                    align: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        });
  }
}

class _ResendButton extends StatelessWidget {
  final s;

  const _ResendButton({Key key, this.s}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 32.h),
      child: MainButton(
        text: s.open_email,
        size: ButtonSize.Medium,
        width: 335.w,
        height: 52.h,
        onPress: () async {
          var result = await OpenMailApp.openMailApp();

          // If no mail apps found, show error
          if (!result.didOpen && !result.canOpen) {

            // print("ayye no open");
          } else if (!result.didOpen && result.canOpen) {
            showDialog(
              context: context,
              builder: (_) {
                return MailAppPickerDialog(
                  mailApps: result.options,
                );
              },
            );
          }
          // final String googleMapsUrl = "mailto://";
          // final String appleMapsUrl = "message://";
          //
          // if (await canLaunch(googleMapsUrl)) {
          //   await launch(googleMapsUrl);
          // } else if (await canLaunch(appleMapsUrl)) {
          //   await launch(appleMapsUrl);
          // } else {
          //   throw "Couldn't launch URL";
        },
      ),
    );
  }
}
