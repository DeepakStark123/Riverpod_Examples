// To parse this JSON data, do
//
//     final jokeModel = jokeModelFromJson(jsonString);

import 'dart:convert';

JokeModel jokeModelFromJson(String str) => JokeModel.fromJson(json.decode(str));

String jokeModelToJson(JokeModel data) => json.encode(data.toJson());

class JokeModel {
    List<dynamic>? categories;
    DateTime? createdAt;
    String? iconUrl;
    String? id;
    DateTime? updatedAt;
    String? url;
    String? value;

    JokeModel({
        this.categories,
        this.createdAt,
        this.iconUrl,
        this.id,
        this.updatedAt,
        this.url,
        this.value,
    });

    factory JokeModel.fromJson(Map<String, dynamic> json) => JokeModel(
        categories: json["categories"] == null ? [] : List<dynamic>.from(json["categories"]!.map((x) => x)),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        iconUrl: json["icon_url"],
        id: json["id"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        url: json["url"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x)),
        "created_at": createdAt?.toIso8601String(),
        "icon_url": iconUrl,
        "id": id,
        "updated_at": updatedAt?.toIso8601String(),
        "url": url,
        "value": value,
    };
}


// Api Response

/*
{
  "categories": [],
  "created_at": "2020-01-05 13:42:25.352697",
  "icon_url": "https://assets.chucknorris.host/img/avatar/chuck-norris.png",
  "id": "e21cKJpGQmKq",
  "updated_at": "2020-01-05 13:42:25.352697",
  "url": "https://api.chucknorris.io/jokes/e21cKJpGQmKq",
  "value": "Chuck Norris can divide by zero."
}
*/