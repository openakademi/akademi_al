import 'package:akademi_al_mobile_app/packages/async_subject_repository/lib/src/async_subject_api_provider.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/async_subject.dart';
import 'package:connectivity/connectivity.dart';

import 'src/async_subject_hive_repository.dart';

class AsyncSubjectRepository {
  static AsyncSubjectRepository _instance;

  final AsyncSubjectApiProvider _apiProvider;
  final AsyncSubjectHiveRepository _repository;

  AsyncSubjectRepository._privateConstructor(
      AuthenticationRepository authenticationRepository)
      : _apiProvider = new AsyncSubjectApiProvider(authenticationRepository),
        _repository = new AsyncSubjectHiveRepository() {
    _instance = this;
  }

  factory AsyncSubjectRepository(
          {AuthenticationRepository authenticationRepository}) =>
      _instance ??
      AsyncSubjectRepository._privateConstructor(authenticationRepository);

  Future<List<AsyncSubject>> getWithAsync() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    var subjects;
    if (connectivityResult != ConnectivityResult.none) {
      subjects = await _apiProvider.getWithAsync();
    } else {
      subjects = await _repository.getAll();
      // print("subjects ${subjects[0].grade}");
    }
    return subjects;
  }

  Future<DateTime> synchronize() async {
    final synchedSubjects = await _repository.getAll();
    synchedSubjects.sort((a, b) =>
    a.lastSyncDate != null && b.lastSyncDate != null
        ? DateTime.tryParse(b.lastSyncDate)
        .compareTo(DateTime.tryParse(a.lastSyncDate))
        : 0);
    final lastUpdatedDateTime = synchedSubjects.length != 0 && synchedSubjects[0].lastSyncDate != null
        ? DateTime.tryParse(synchedSubjects[0].lastSyncDate)
        : DateTime(1980);

    // final asyncSubjectsToSave = await _apiProvider.getSyncAsyncSubjects(lastUpdatedDateTime);

    // await _repository.saveAll(asyncSubjectsToSave);
    // Save all enrollments
    return DateTime.now();
  }

  Future<void> deleteSynchronization() async {
    await _repository.deleteAll();
  }

  void dispose() async {
    _repository.dispose();
  }
}
