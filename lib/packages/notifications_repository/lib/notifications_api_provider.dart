
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/src/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/http_client/lib/http_client.dart';
import 'package:akademi_al_mobile_app/packages/models/user/notification.dart';

const relative_url = "/notifications";

class NotificationsApiProvider extends ApiServiceData {
  NotificationsApiProvider(AuthenticationRepository authenticationRepository) : super(authenticationRepository);

  Future<int> countAllByUserId() async {
    final response = await getRequest("$relative_url/count");
    return int.tryParse(response);
  }

  Future<List<Notification>> getAllForUser() async {
    List<dynamic> response = await getRequest("$relative_url");

    return response.map((e) => Notification.fromJson(e)).toList();
  }

  Future<void> markAllAsRead() async {
    await this.update("$relative_url", {});
  }
}