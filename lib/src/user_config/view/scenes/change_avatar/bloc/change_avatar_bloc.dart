import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'change_avatar_event.dart';
part 'change_avatar_state.dart';

class ChangeAvatarBloc extends Bloc<ChangeAvatarEvent, ChangeAvatarState> {
  ChangeAvatarBloc() : super(ChangeAvatarInitial());

  @override
  Stream<ChangeAvatarState> mapEventToState(
    ChangeAvatarEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
