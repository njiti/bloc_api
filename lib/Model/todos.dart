// To parse this JSON data, do
//
//     final todo = todoFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Todo todoFromJson(String str) => Todo.fromJson(json.decode(str));

String todoToJson(Todo data) => json.encode(data.toJson());

class Todo {
  final List<Result> results;
  final int offset;
  final int number;
  final int totalResults;

  Todo({
    required this.results,
    required this.offset,
    required this.number,
    required this.totalResults,
  });

  Todo copyWith({
    List<Result>? results,
    int? offset,
    int? number,
    int? totalResults,
  }) =>
      Todo(
        results: results ?? this.results,
        offset: offset ?? this.offset,
        number: number ?? this.number,
        totalResults: totalResults ?? this.totalResults,
      );

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        offset: json["offset"],
        number: json["number"],
        totalResults: json["totalResults"],
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "offset": offset,
        "number": number,
        "totalResults": totalResults,
      };
}

class Result {
  final int id;
  final String title;
  final String image;
  final ImageType imageType;
  final Nutrition nutrition;

  Result({
    required this.id,
    required this.title,
    required this.image,
    required this.imageType,
    required this.nutrition,
  });

  Result copyWith({
    int? id,
    String? title,
    String? image,
    ImageType? imageType,
    Nutrition? nutrition,
  }) =>
      Result(
        id: id ?? this.id,
        title: title ?? this.title,
        image: image ?? this.image,
        imageType: imageType ?? this.imageType,
        nutrition: nutrition ?? this.nutrition,
      );

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        imageType: imageTypeValues.map[json["imageType"]]!,
        nutrition: Nutrition.fromJson(json["nutrition"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "imageType": imageTypeValues.reverse[imageType],
        "nutrition": nutrition.toJson(),
      };
}

enum ImageType { JPG }

final imageTypeValues = EnumValues({"jpg": ImageType.JPG});

class Nutrition {
  final List<Nutrient> nutrients;

  Nutrition({
    required this.nutrients,
  });

  Nutrition copyWith({
    List<Nutrient>? nutrients,
  }) =>
      Nutrition(
        nutrients: nutrients ?? this.nutrients,
      );

  factory Nutrition.fromJson(Map<String, dynamic> json) => Nutrition(
        nutrients: List<Nutrient>.from(
            json["nutrients"].map((x) => Nutrient.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "nutrients": List<dynamic>.from(nutrients.map((x) => x.toJson())),
      };
}

class Nutrient {
  final Name name;
  final double amount;
  final Unit unit;

  Nutrient({
    required this.name,
    required this.amount,
    required this.unit,
  });

  Nutrient copyWith({
    Name? name,
    double? amount,
    Unit? unit,
  }) =>
      Nutrient(
        name: name ?? this.name,
        amount: amount ?? this.amount,
        unit: unit ?? this.unit,
      );

  factory Nutrient.fromJson(Map<String, dynamic> json) => Nutrient(
        name: nameValues.map[json["name"]]!,
        amount: json["amount"]?.toDouble(),
        unit: unitValues.map[json["unit"]]!,
      );

  Map<String, dynamic> toJson() => {
        "name": nameValues.reverse[name],
        "amount": amount,
        "unit": unitValues.reverse[unit],
      };
}

enum Name { FAT }

final nameValues = EnumValues({"Fat": Name.FAT});

enum Unit { G }

final unitValues = EnumValues({"g": Unit.G});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
