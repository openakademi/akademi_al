import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/src/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/http_client/lib/http_client.dart';

const path = "/account-email";

class SendEmailApiProvider extends ApiServiceData {
  SendEmailApiProvider(AuthenticationRepository authenticationRepository) : super(authenticationRepository);

  sendForgotPasswordEmail(String email) async{
    await authenticationRepository.loginClient();

    return this.post("$path/forget-password", {
      "email": email,
      "recaptchaValue": ""
    });
  }
}