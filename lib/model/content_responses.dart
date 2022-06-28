import 'dart:convert';

List<ContentResponses> contentResponsesFromJson(String str) =>
    List<ContentResponses>.from(
        json.decode(str).map((x) => ContentResponses.fromJson(x)));

String contentResponsesToJson(List<ContentResponses> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ContentResponses {
  final int userId;
  final int id;
  final String title;
  final String body;

  ContentResponses({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory ContentResponses.fromJson(Map<String, dynamic> json) =>
      ContentResponses(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
