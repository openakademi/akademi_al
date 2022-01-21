

import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/src/select_organization/view/scenes/select_organization.dart';
import 'package:akademi_al_mobile_app/src/synchronization/bloc/synchronization_bloc.dart';
import 'package:flutter/material.dart';
import 'package:akademi_al_mobile_app/src/authentication/authentication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'UserName: ${context.bloc<AuthenticationBloc>().state.status}',
          ),
          RaisedButton(
            child: const Text('Logout'),
            onPressed: () {
              context
                  .read<SynchronizationBloc>()
                  .add(DeleteSynchronization());
              context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLogoutRequested());
            },
          ),
        ],
      ),
    );
  }
}