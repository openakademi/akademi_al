import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/layouts/keyboard_aware_layout.dart';
import 'package:akademi_al_mobile_app/packages/send_email_repository/lib/send_email_api_provider.dart';
import 'package:akademi_al_mobile_app/src/login_scenes/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'scenes/forgot_password.dart';
import 'scenes/sent_email_success.dart';

class ForgotPasswordPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => BlocProvider(
            create: (context) {
              return ForgotPasswordBloc(RepositoryProvider.of<SendEmailApiProvider>(context));
            },
            child: ForgotPasswordPage()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      buildWhen: (previous, next) {
        return next.sentEmail != previous.sentEmail;
      },
      builder: (buildContext, state) {
        if (state.sentEmail && state.emailExist) {
          return SentEmailSuccess();
        } else {
          return KeyboardAwareLayout(
            backgroundImage: AssetImage(
                "assets/images/information_1_background/information_1_background.png"),
            leading: IconButton(
              icon: Icon(RemixIcons.arrow_left_line, color: AntColors.blue6),
              onPressed: () => Navigator.of(context).pop(),
            ),
            body: ForgotPassword(),
          );
        }
      },
    );
  }
}
