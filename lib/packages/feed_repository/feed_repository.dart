import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/feed_repository/lib/feed_api_provider.dart';
import 'package:akademi_al_mobile_app/packages/models/user/feed_item.dart';

class FeedRepository {
  static FeedRepository _instance;

  final FeedApiProvider _apiProvider;

  // final EnrollmentHiveRepository _repository;

  FeedRepository._privateConstructor(
      AuthenticationRepository authenticationRepository)
      : _apiProvider = new FeedApiProvider(authenticationRepository) {
    _instance = this;
  }

  factory FeedRepository({AuthenticationRepository authenticationRepository}) =>
      _instance ?? FeedRepository._privateConstructor(authenticationRepository);

  Future<List<FeedItem>> getAllFeedByClassroomId(String classroomId, int pageIndex) async {
    final response = await _apiProvider.getAllFeedByClassroomId(classroomId, pageIndex);
    return response;
  }

  Future<void> saveFeed(FeedItem feedItem) async {
    await _apiProvider.saveFeed(feedItem);
  }

  Future<void> deleteFeed(String feedId) async {
    await _apiProvider.deleteFeed(feedId);
  }

  Future<void> updateFeed(FeedItem item) async {
    await _apiProvider.updateFeed(item);
  }
}
