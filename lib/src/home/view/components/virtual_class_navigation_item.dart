import 'package:akademi_al_mobile_app/components/button/lib/main_text_button.dart';
import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/src/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VirtualClassNavigator extends StatelessWidget {
  final int enrollmentNumber;
  final S s;

  const VirtualClassNavigator({Key key, this.enrollmentNumber, this.s})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 8.h),
      child: BlocBuilder<HomeBloc, HomeState>(buildWhen: (previous, next) {
        return next.virtualClassEnrollments != null &&
            next.virtualClassEnrollments?.length !=
                previous.virtualClassEnrollments?.length;
      }, builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BaseText(
              text: s.virtual_classes(state.virtualClassEnrollments?.length),
              type: TextTypes.h6,
              textColor: AntColors.gray9,
            ),
            state.virtualClassEnrollments?.length >= 5
                ? MainTextButton(
                    onPress: () {
                      context.read<HomeBloc>().add(ViewAllVirtualClasses());
                    },
                    text: s.all,
                  )
                : Container()
          ],
        );
      }),
    );
  }
}
