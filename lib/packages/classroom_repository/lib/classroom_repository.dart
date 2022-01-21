

import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/classroom_repository/lib/src/classroom_api_provider.dart';
import 'package:akademi_al_mobile_app/packages/classroom_repository/lib/src/classroom_hive_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/user/classroom_entity.dart';

class ClassroomRepository {
  static ClassroomRepository _instance;


  ClassroomRepository._privateConstructor(
      AuthenticationRepository authenticationRepository)
      : _apiProvider = new ClassroomApiProvider(authenticationRepository),
        _repository = new ClassroomHiveRepository()
  {
    _instance = this;
  }

  factory ClassroomRepository(
      {AuthenticationRepository authenticationRepository}) =>
      _instance ??
          ClassroomRepository._privateConstructor(authenticationRepository);

  final ClassroomApiProvider _apiProvider;
  final ClassroomHiveRepository _repository;

  Future<ClassroomEntity> getClassroomById(String id) async {
    final classroomEntity = await _apiProvider.getClassroom(id);
    return classroomEntity;
  }

  Future<ClassroomEntity> getClassroomByCode(String id) async {
    final classroomEntity = await _apiProvider.getClassroomByCode(id);
    return classroomEntity;
  }

  Future<DateTime> synchronize() async {
    final synchedEnrollments = await _repository.getAll();
    synchedEnrollments.sort((a, b) =>
    a.lastSyncDate != null && b.lastSyncDate != null
        ? DateTime.tryParse(b.lastSyncDate)
        .compareTo(DateTime.tryParse(a.lastSyncDate))
        : 0);
    final lastUpdatedDateTime = synchedEnrollments.length != 0
        ? DateTime.tryParse(synchedEnrollments[0].lastSyncDate)
        : DateTime(1980);

    // final enrollments =
    // await _apiProvider(lastUpdatedDateTime);

    // await _repository.saveAll(enrollments);
    //Save all enrollments
    return DateTime.now();
  }

  Future<List<ClassroomEntity>> getAssignmentsByStartDate(String startDate) async {
    final assignments = await _apiProvider.getAssignmentsByStartDate(startDate);
    return assignments;
  }

  Future<void> deleteSynchronization() async {
    await _repository.deleteAll();
  }

}