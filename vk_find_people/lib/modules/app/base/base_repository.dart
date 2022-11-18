
import '../../../http/api_client.dart';
import '../service_locator.dart';

abstract class BaseRepository {
  late ApiClient client;

  BaseRepository() {
    client = ServiceLocator.get<ApiClient>();
  }
}