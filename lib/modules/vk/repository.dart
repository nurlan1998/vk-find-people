import '../app/base/base_repository.dart';

class VkRepository extends BaseRepository {
  Future<dynamic> getProfileInfo() async {
    return await client.get('/method/account.getProfileInfo');
  }

  Future<dynamic> checkToken({
    required String accessToken,
  }) async {
    return await client.get('/method/secure.checkToken', queryParameters: {
      'access_token': accessToken,
    });
  }

  Future<dynamic> getUser({
    required int userId,
  }) async {
    return await client.get('/method/users.get', queryParameters: {
      'user_ids': userId,
      'fields': 'has_photo,photo_100,photo_200',
    });
  }
  Future<dynamic> getFriends({
    required int userId,
  }) async {
    return await client.get('/method/friends.get', queryParameters: {
      'user_id': userId,
      'fields': 'contacts,photo_200',
    });
  }

  Future<dynamic> getAllUsers({
    required String field,
  }) async {
    return await client.get('/method/users.search', queryParameters: {
      'q': field,
      'fields': 'has_photo, photo_200',
    });
  }
}