import 'dart:convert';

AreaModel areaModelFromJson(String str) => AreaModel.fromJson(json.decode(str));

String areaModelToJson(AreaModel data) => json.encode(data.toJson());

class AreaModel {
  final bool? success;
  final List<ListElement>? list;

  AreaModel({
    this.success,
    this.list,
  });

  factory AreaModel.fromJson(Map<String, dynamic> json) => AreaModel(
        success: json["success"],
        list: json["list"] == null ? [] : List<ListElement>.from(json["list"]!.map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "list": list == null ? [] : List<dynamic>.from(list!.map((x) => x.toJson())),
      };
}

class ListElement {
  final String? id;
  final String? name;
  final String? city;
  final String? area;
  final String? transport;
  final String? traffic;
  final String? avgTemperature;
  final String? populationDensity;
  final String? tds;
  final String? publicInfrastructureRating;
  final String? aqi;
  final String? averageRent;
  final String? costOfLivingIndex;
  final String? averageAnnualRainfall;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final List<Review>? reviews;

  ListElement({
    this.id,
    this.name,
    this.city,
    this.area,
    this.transport,
    this.traffic,
    this.avgTemperature,
    this.populationDensity,
    this.tds,
    this.publicInfrastructureRating,
    this.aqi,
    this.averageRent,
    this.costOfLivingIndex,
    this.averageAnnualRainfall,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.reviews,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["_id"],
        name: json["name"],
        city: json["city"],
        area: json["area"],
        transport: json["transport"],
        traffic: json["traffic"],
        avgTemperature: json["avgTemperature"],
        populationDensity: json["populationDensity"],
        tds: json["tds"],
        publicInfrastructureRating: json["publicInfrastructureRating"],
        aqi: json["aqi"],
        averageRent: json["averageRent"],
        costOfLivingIndex: json["costOfLivingIndex"],
        averageAnnualRainfall: json["averageAnnualRainfall"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        reviews: json["reviews"] == null ? [] : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "city": city,
        "area": area,
        "transport": transport,
        "traffic": traffic,
        "avgTemperature": avgTemperature,
        "populationDensity": populationDensity,
        "tds": tds,
        "publicInfrastructureRating": publicInfrastructureRating,
        "aqi": aqi,
        "averageRent": averageRent,
        "costOfLivingIndex": costOfLivingIndex,
        "averageAnnualRainfall": averageAnnualRainfall,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x.toJson())),
      };
}

class Review {
  final String? id;
  final String? text;
  final String? user;
  final String? area;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Review({
    this.id,
    this.text,
    this.user,
    this.area,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["_id"],
        text: json["text"],
        user: json["user"],
        area: json["area"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "text": text,
        "user": user,
        "area": area,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
