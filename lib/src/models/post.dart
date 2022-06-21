// https://quicktype.io/
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

// String JSON to List
List<Post> postFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));
// List to JSON string
String postToJson(List<Post> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  // Constructor
  Post({
    this.userId,
    this.id,
    this.title,
    this.body,
  });
  // Variables
  int? userId;
  int? id;
  String? title;
  String? body;

  // Constructor Object
  factory Post.fromJson(Map<String, dynamic> json) => Post(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"],
  );
  // Map JSON
  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
  };
}
