import 'package:aruna_test/infrastructure/endpoint/app_endpoint.dart';
import 'package:aruna_test/infrastructure/utils/http_utils.dart';
import 'package:aruna_test/model/content_responses.dart';

class AppAPI {
  //Get Contents
  Future<List<ContentResponses>> getContents() async {
    final response = await makeGetRequest(AppEndpoints.getContents());

    return contentResponsesFromJson(response.body);
  }
}
