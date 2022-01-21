
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/src/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/http_client/lib/http_client.dart';

const path = "/grades";

class GradesApiProvider extends ApiServiceData {
  GradesApiProvider(AuthenticationRepository authenticationRepository) : super(authenticationRepository);

  getAllGrades() async {
    final grades = await this.getRequest("$path");
    return grades;
  }
}