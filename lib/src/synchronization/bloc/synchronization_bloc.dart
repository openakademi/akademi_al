import 'dart:async';

import 'package:akademi_al_mobile_app/packages/async_subject_repository/lib/async_subject_repository.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/enrollment_repository/enrollment_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/user/models.dart';
import 'package:akademi_al_mobile_app/src/utils/consts.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'synchronization_event.dart';

part 'synchronization_state.dart';

class SynchronizationBloc
    extends Bloc<SynchronizationEvent, SynchronizationState> {
  SynchronizationBloc({
    @required EnrollmentRepository enrollmentRepository,
    @required AuthenticationRepository authenticationRepository,
    @required AsyncSubjectRepository asyncSubjectRepository
  })
      : assert(enrollmentRepository != null),
        assert(authenticationRepository != null),
        _enrollmentRepository = enrollmentRepository,
        _authenticationRepository = authenticationRepository,
        _asyncSubjectRepository = asyncSubjectRepository,
        super(const SynchronizationState(SynchronizationProcessState.started));

  final EnrollmentRepository _enrollmentRepository;
  final AsyncSubjectRepository _asyncSubjectRepository;
  final AuthenticationRepository _authenticationRepository;
  Box synchronizationTimeBox;

  @override
  Stream<SynchronizationState> mapEventToState(
      SynchronizationEvent event,) async* {
    if (event is SynchronizationStart) {
      yield await _startSynchronization();
    } else if (event is DeleteSynchronization) {
      yield await _deleteSynchronization(event, state);
    }
  }

  Future<SynchronizationState> _startSynchronization() async {
    await _openSynchronizationBox();
    final User user = await _authenticationRepository.getCurrentUser();

    // await Future.delayed(Duration(seconds: 30));
    final lastUpdatedTime = await _enrollmentRepository.synchronize();
    await _asyncSubjectRepository.synchronize();
    // synchronizationTimeBox.put("enrollment_time", lastUpdatedTime);
    return SynchronizationState(SynchronizationProcessState.finished);
  }

  @override
  Future<void> close() {
    _enrollmentRepository.dispose();
    // _asyncSubjectRepository.dispose();
    if (synchronizationTimeBox.isOpen) {
      synchronizationTimeBox.close();
    }
    return super.close();
  }

  Future<void> _openSynchronizationBox() async {
    if (Hive.isBoxOpen(synchronization_time_box_name)) {
      synchronizationTimeBox = Hive.box(synchronization_time_box_name);
    } else {
      synchronizationTimeBox =
      await Hive.openBox(synchronization_time_box_name);
    }
  }

  Future<SynchronizationState> _deleteSynchronization(event, state) async {
    await _enrollmentRepository.deleteSynchronization();
    // await _asyncSubjectRepository.deleteSynchronization();
    return state;
  }
}
