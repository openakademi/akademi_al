import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return Material(
      elevation: 1,
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(left: 20.0.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: FutureBuilder<String>(
                    future: _getUserName(context),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            BaseText(
                              text: s.welcome_user,
                              textColor: AntColors.gray7,
                              type: TextTypes.p1,
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Expanded(
                              child: BaseText(
                                text: snapshot.data,
                                textColor: AntColors.gray8,
                                type: TextTypes.h5,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              ),
              Image.asset(
                "assets/images/dashboard_image/dashboard_image.png",
                fit: BoxFit.cover,
                width: 105.w,
                height: 70.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> _getUserName(BuildContext context) async {
    final authenticationRepository =
        RepositoryProvider.of<AuthenticationRepository>(context);

    final user = await authenticationRepository.getCurrentUser();
    return "${user.firstName} ${user.lastName}";
  }
}
