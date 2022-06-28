import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<Map<String, String>> getHeaderAuthorization() async {
  var header = {
    "Content-type": "application/json",
  };
  return header;
}

Future<http.Response> makeGetRequest(String url) async {
  print(await getHeaderAuthorization());
  print("[GET] $url");

  var response = await http.get(
    url,
    headers: await getHeaderAuthorization(),
  );

  _printResponse(response.body);
  return response;
}

Future _printResponse(String response) async {
  var split = response.split("\n");

  debugPrint(response);
  if (split.length <= 200) {
  } else {
    debugPrint(split.sublist(0, 60).join("\n"));
    var printNext =
        split.sublist(60).map((s) => s.replaceAll(' ', "")).join("");
    debugPrint("... $printNext");
  }
}
