import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/src/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/http_client/lib/http_client.dart';
import 'package:akademi_al_mobile_app/packages/models/user/classroom_entity.dart';

const relative_url = "/classroom";

class ClassroomApiProvider extends ApiServiceData {
  ClassroomApiProvider(AuthenticationRepository authenticationRepository)
      : super(authenticationRepository);

  Future<ClassroomEntity> getClassroom(String classroomId) async {
    final response = await getRequest("$relative_url/$classroomId");
    final classroomEntity = ClassroomEntity.fromJson(response);
    return classroomEntity;
  }

  Future<ClassroomEntity> getClassroomByCode(String code) async {
    final response = await getRequest("$relative_url/code/$code");
    final classroomEntity = ClassroomEntity.fromJson(response);
    return classroomEntity;
  }

  Future<List<ClassroomEntity>> getAssignmentsByStartDate(String startDate) async {
    List<dynamic> response = await getRequest("$relative_url/assignments/$startDate");
    final classroomEntities = response.map((e) => ClassroomEntity.fromJson(e)).toList();
    return classroomEntities;
  }
}
