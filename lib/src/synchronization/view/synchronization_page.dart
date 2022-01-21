import 'package:akademi_al_mobile_app/packages/async_subject_repository/lib/async_subject_repository.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/enrollment_repository/enrollment_repository.dart';
import 'package:akademi_al_mobile_app/src/synchronization/bloc/synchronization_bloc.dart';
import 'package:akademi_al_mobile_app/src/synchronization/view/synchronization_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SynchronizationPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SynchronizationPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return SynchronizationBloc(
                enrollmentRepository:
                    RepositoryProvider.of<EnrollmentRepository>(context),
                authenticationRepository:
                    RepositoryProvider.of<AuthenticationRepository>(context),
                asyncSubjectRepository: AsyncSubjectRepository(
                    authenticationRepository:
                        RepositoryProvider.of<AuthenticationRepository>(
                            context)));
          },
          child: SynchronizationAnimation(),
        ),
      ),
    );
  }
}
