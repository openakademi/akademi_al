import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/layouts/keyboard_aware_layout.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/src/login_scenes/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_form.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardAwareLayout(
      title: new BaseText(
        text: S.of(context).login,
        letterSpacing: -0.4,
        weightType: FontWeight.w600,
        lineHeight: 1.21,
      ),
      backgroundImage: AssetImage(
          "assets/images/information_1_background/information_1_background.png"),
      leading: IconButton(
        icon: Icon(RemixIcons.arrow_left_line, color: AntColors.blue6),
        onPressed: () => Navigator.of(context).pop(),
      ),
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context));
        },
        child: LoginForm(),
      ),

    );
  }
}
