import 'dart:convert';

CityModel cityModelFromJson(String str) => CityModel.fromJson(json.decode(str));

String cityModelToJson(CityModel data) => json.encode(data.toJson());

class CityModel {
  final bool? success;
  final List<ListElement>? list;
  final int? count;

  CityModel({
    this.success,
    this.list,
    this.count,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        success: json["success"],
        list: json["list"] == null ? [] : List<ListElement>.from(json["list"]!.map((x) => ListElement.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "list": list == null ? [] : List<dynamic>.from(list!.map((x) => x.toJson())),
        "count": count,
      };
}

class ListElement {
  final String? id;
  final String? name;
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
  final bool? isComingSoon;

  ListElement({
    this.id,
    this.name,
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
    this.isComingSoon,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["_id"],
        name: json["name"],
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
        isComingSoon: json["isComingSoon"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
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
        "isComingSoon": isComingSoon,
      };
}
