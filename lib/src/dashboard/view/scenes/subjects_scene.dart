import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/async_subject_repository/lib/async_subject_repository.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/src/subjects/async_subjects/async_subject.dart';
import 'package:akademi_al_mobile_app/src/subjects/async_subjects/bloc/async_subject_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubjectDashboardScene extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SubjectDashboardScene());
  }

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return BlocProvider(
        create: (context) {
          return AsyncSubjectBloc(AsyncSubjectRepository(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context)));
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              title: new BaseText(
                text: s.subjects,
                letterSpacing: -0.4,
                weightType: FontWeight.w600,
                lineHeight: 1.21,
              ),
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(RemixIcons.arrow_left_line, color: AntColors.blue6),
                onPressed: () => {Navigator.of(context).pop()},
              ),
            ),
            body: AsyncSubjectScene(
              search: false,
            )));
  }
}
