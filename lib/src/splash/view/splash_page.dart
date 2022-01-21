import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/splash_screen/splash_screen.png"),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  "assets/logos/akademi_logo/akademi_logo.png",
                height: 40.sp, width: 157.sp, fit: BoxFit.fill,),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 15.h),
                  child: Image.asset(
                      "assets/logos/ministry_logo/ministry_logo.png"),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 42.h),
                  child: BaseText(
                    text: s.splash_page_text,
                    type: TextTypes.p2,
                    textColor: AntColors.gray7,
                    align: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 50.h),
                  child: BaseText(
                    text: s.copyright(DateTime.now().year),
                    type: TextTypes.p2,
                    textColor: AntColors.gray7,
                    align: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],

        )
      ]),
    );
  }
}
