import 'package:akademi_al_mobile_app/components/button/button.dart';
import 'package:akademi_al_mobile_app/src/home/home.dart';
import 'package:akademi_al_mobile_app/src/synchronization/bloc/synchronization_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SynchronizationAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.bloc<SynchronizationBloc>().add(new SynchronizationStart());
    return BlocListener<SynchronizationBloc, SynchronizationState>(
        listener: (context, state) {
          switch (state.status) {
            case SynchronizationProcessState.started:
              break;
            case SynchronizationProcessState.not_started:
              break;
            case SynchronizationProcessState.finished:
              Future.delayed(Duration.zero, () {
                Navigator.of(context).pushAndRemoveUntil<void>(
                    HomePage.route(false), (route) => false);
              });
              break;
          }
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Center(
            child: Image.asset("assets/gifs/synchronization.gif", width:150.w, height: 105.h, fit: BoxFit.fitWidth,),
          ),
        ));
  }
}
