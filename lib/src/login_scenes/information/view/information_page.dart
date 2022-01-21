import 'package:akademi_al_mobile_app/components/button/button.dart';
import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/src/login_scenes/login/login.dart';
import 'package:akademi_al_mobile_app/src/login_scenes/register/view/register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'components/first_information.dart';

List<Widget> informationPages = [
  SliderInformation(slideNumber: 1),
  SliderInformation(slideNumber: 2),
  SliderInformation(slideNumber: 3),
  SliderInformation(slideNumber: 4),
];

class InformationPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => InformationPage());
  }

  @override
  State<StatefulWidget> createState() {
    return _InformationPageState();
  }
}

class _InformationPageState extends State<InformationPage> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Image.asset(
                "assets/logos/akademi_logo/akademi_logo.png",
                fit: BoxFit.fitHeight,
                height: 28.w,
              )),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              new Flexible(
                child: new Swiper(
                  itemBuilder: (context, index) {
                    return informationPages[index];
                  },
                  itemCount: informationPages.length,
                  pagination: new SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.all(5.w),
                      builder: new DotSwiperPaginationBuilder(
                          color: AntColors.gray4,
                          activeColor: AntColors.blue6,
                          activeSize: 12.w,
                          size: 8.w,
                          space: 12.w,

                      )),
                  control: new SwiperControl(size: 0),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(bottom: 50.h),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MainButton(
                          text: S.of(context).register,
                          onPress: () {
                            Navigator.of(context).push(RegisterPage.route());
                          },
                          width: 158.w,
                          size: ButtonSize.Big,
                        ),
                        MainButton(
                          text: S.of(context).login,
                          onPress: () {
                            Navigator.of(context).push(LoginPage.route());
                          },
                          ghost: true,
                          width: 158.w,
                          size: ButtonSize.Big,
                        ),
                      ])),
            ],
          ),
        ));
  }
}
