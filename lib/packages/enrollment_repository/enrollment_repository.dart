import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/enrollment_repository/lib/src/enrollment_api_provider.dart';
import 'package:akademi_al_mobile_app/packages/enrollment_repository/lib/src/enrollment_hive_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/enrollment/enrollment_entity.dart';
import 'package:connectivity/connectivity.dart';

class EnrollmentRepository {
  static EnrollmentRepository _instance;

  final EnrollmentApiProvider _apiProvider;
  final EnrollmentHiveRepository _repository;

  EnrollmentRepository._privateConstructor(
      AuthenticationRepository authenticationRepository)
      : _repository = new EnrollmentHiveRepository(),
        _apiProvider = new EnrollmentApiProvider(authenticationRepository) {
    _instance = this;
  }

  factory EnrollmentRepository(
          {AuthenticationRepository authenticationRepository}) =>
      _instance ??
      EnrollmentRepository._privateConstructor(authenticationRepository);

//synchronize
  Future<DateTime> synchronize() async {
    final synchedEnrollments = await _repository.getAll();
    synchedEnrollments.sort((a, b) =>
        a.lastSyncDate != null && b.lastSyncDate != null
            ? DateTime.tryParse(b.lastSyncDate)
                .compareTo(DateTime.tryParse(a.lastSyncDate))
            : 0);
    final lastUpdatedDateTime = synchedEnrollments.length != 0 && synchedEnrollments[0].lastSyncDate != null
        ? DateTime.tryParse(synchedEnrollments[0].lastSyncDate)
        : DateTime(1980);

    final enrollments =
        await _apiProvider.getSyncEnrollments(lastUpdatedDateTime);

    await _repository.saveAll(enrollments);
    //Save all enrollments
    return DateTime.now();
  }

  Future<void> deleteSynchronization() async {
    await _repository.deleteAll();
  }

  Future<List<EnrollmentEntity>> getAsyncEnrollments() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var enrollments;
    if (connectivityResult == ConnectivityResult.none) {
      enrollments = await _repository.getAll();
      // I am connected to a mobile network.
    } else {
      enrollments = await _apiProvider.getAllEnrollments();
      // I am connected to a wifi network.
    }
    return enrollments.where((element) => !element.classroom.isAsync).toList();
  }

  Future<List<EnrollmentEntity>> getAllEnrollments() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var enrollments;
    if (connectivityResult == ConnectivityResult.none) {
      enrollments = await _repository.getAll();
      // I am connected to a mobile network.
    } else {
      enrollments = await _apiProvider.getAllEnrollments();
      // I am connected to a wifi network.
    }
    return enrollments;
  }

//getAll

  Future<EnrollmentEntity> getEnrollmentById(String enrollmentId) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var enrollment;
    if (connectivityResult == ConnectivityResult.none) {
      enrollment = await _repository.findById(enrollmentId);
    } else {
      enrollment = await _apiProvider.getEnrollmentById(enrollmentId);

    }
    return enrollment;
  }

  Future<EnrollmentEntity> createEnrollment(String classroomId) async {
    final enrollment = await _apiProvider.createEnrollment(classroomId);
    return enrollment;
  }

  Future<List<EnrollmentEntity>> getAllEnrollmentsByClassroomId(String classroomId) async {
    final response = await _apiProvider.getAllEnrollmentsByClassroomId(classroomId);
    return response;
  }

  Future<void> deleteEnrollment(String enrollmentId) async {
    await _apiProvider.deleteEnrollment(enrollmentId);
  }

  //dispose here
  void dispose() async {
    _repository.dispose();
  }
}
