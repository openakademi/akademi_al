import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SliderInformation extends StatelessWidget {
  final slideNumber;

  const SliderInformation({Key key, this.slideNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final titleValues = {
      1: s.information_1_title,
      2: s.information_2_title,
      3: s.information_3_title,
      4: s.information_4_title,
    };

    final contentValues = {
      1: s.information_1_content,
      2: s.information_2_content,
      3: s.information_3_content,
      4: s.information_4_content,
    };

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              "assets/images/information_${slideNumber}_background/information_${slideNumber}_background.png"),
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter,
          scale: 1.w,
        ),
      ),
      constraints: BoxConstraints.expand(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
              padding:
                  EdgeInsets.only(left: 16.0.w, right: 16.0.w, top: 112.h, bottom: 24),
              child: Image.asset(
                "assets/images/information_$slideNumber/information_$slideNumber.png",
                fit: BoxFit.cover,
                width: 344.w,
                height: 250.h,
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              BaseText(
                text: titleValues[slideNumber],
                textColor: AntColors.blue9,
                align: TextAlign.center,
                lineHeight: 1.3,
                verticalPadding: 16,
                horizontalPadding: 20,
                type: TextTypes.h3,
              ),
              BaseText(
                text: contentValues[slideNumber],
                align: TextAlign.center,
                horizontalPadding: 20,
                textColor: AntColors.gray8,
              )
            ],
          )
        ],
      ),
    );
  }
}
