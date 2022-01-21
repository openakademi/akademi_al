import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/src/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/http_client/lib/http_client.dart';
import 'package:akademi_al_mobile_app/packages/models/user/feed_item.dart';

const relative_url = "/feeds";

class FeedApiProvider extends ApiServiceData {
  FeedApiProvider(AuthenticationRepository authenticationRepository)
      : super(authenticationRepository);

  Future<List<FeedItem>> getAllFeedByClassroomId(String classroomId, int pageIndex) async {
    final String url = "$relative_url/$classroomId/$pageIndex/10";
    List<dynamic> response = await getRequest(url);
    final feedItems = response.map((e) => FeedItem.fromJson(e)).toList();
    return feedItems;
  }

  Future<void> saveFeed(FeedItem feedItem) async {
    final String url = "$relative_url";
    final userId = await authenticationRepository.getCurrentUserId();
    final item = feedItem;
    item.createdBy = userId;
    item.updatedBy = userId;
    item.userId = userId;
    await post(url, feedItem.toSaveJson());
  }

  Future<void> deleteFeed(String feedId) async {
    await deleteRequest("$relative_url/$feedId");
  }

  Future<void> updateFeed(FeedItem item) async {
    await update("$relative_url/${item.id}", item.toJson());
  }
}
