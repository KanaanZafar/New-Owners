// To parse this JSON data, do
//
//     final vendorType = vendorTypeFromJson(jsonString);

import 'dart:convert';

import 'package:fuodz/constants/app_colors.dart';

VendorType vendorTypeFromJson(String str) =>
    VendorType.fromJson(json.decode(str));

String vendorTypeToJson(VendorType data) => json.encode(data.toJson());

class VendorType {
  VendorType({
    this.id,
    this.name,
    this.description,
    this.slug,
    this.color,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.formattedDate,
    this.logo,
  });

  int id;
  String name;
  String description;
  String slug;
  String color;
  int isActive;
  DateTime createdAt;
  DateTime updatedAt;
  String formattedDate;
  String logo;

  factory VendorType.fromJson(Map<String, dynamic> json) => VendorType(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        slug: json["slug"] == null ? null : json["slug"],
        color: json["color"] == null
            ? AppColor.colorEnv("primaryColor")
            : (json["color"].toString().length == 7
                ? json["color"]
                : AppColor.colorEnv("primaryColor")),
        isActive: json["is_active"] == null ? null : json["is_active"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        formattedDate:
            json["formatted_date"] == null ? null : json["formatted_date"],
        logo: json["logo"] == null ? null : json["logo"],
      );

  bool get isService => slug == "service";

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "slug": slug == null ? null : slug,
        "is_active": isActive == null ? null : isActive,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "formatted_date": formattedDate == null ? null : formattedDate,
        "logo": logo == null ? null : logo,
      };

  //
  bool get authRequired {
    return ["taxi", "parcel", "package"].contains(slug);
  }
}
