import 'package:hive/hive.dart';
import 'package:vk_find_people/modules/app/cache.dart';
part 'access_token_data.g.dart';

@HiveType(typeId: 1)
class AccessTokenData {
  static String cacheBoxKey = 'token';
  @HiveField(0)
  late final String accessToken;
  @HiveField(1)
  late final int expiresIn;
  @HiveField(2)
  late final int userId;

  AccessTokenData({
    required this.accessToken,
    required this.expiresIn,
    required this.userId,
  });

  AccessTokenData.fromJson(dynamic json) {
    accessToken = json['access_token'];
    expiresIn = int.parse(json['expires_in']);
    userId = int.parse(json['user_id']);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'access_token': accessToken,
      'expires_in': expiresIn,
      'user_id': userId,
    };
  }

  static Box<AccessTokenData> get cacheBox => Cache.box<AccessTokenData>();

  Future remove() async {
    await cacheBox.delete(cacheBoxKey);
  }

  static AccessTokenData? fromCache() {
    return cacheBox.get(cacheBoxKey);
  }
}
