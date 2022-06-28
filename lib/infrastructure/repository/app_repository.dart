import 'package:aruna_test/infrastructure/api/app_api.dart';
import 'package:aruna_test/model/content_responses.dart';

class AppRepository {
  final AppAPI _appAPI = AppAPI();

  Future<List<ContentResponses>> fetchContents() => _appAPI.getContents();
}
