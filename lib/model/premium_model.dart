import 'dart:convert';

List<PremiumModel> premiumModelFromJson(List<dynamic> jsonList) {
  return List<PremiumModel>.from(
    jsonList.map((x) => PremiumModel.fromJson(x as Map<String, dynamic>)),
  );
}

String premiumModelToJson(List<PremiumModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PremiumModel {
  String? id;
  String? featureName;
  String? type; // "Feature" or "Price"
  List<PlanModel> plans;
  DateTime? createdAt;
  DateTime? updatedAt;

  PremiumModel({
    this.id,
    this.featureName,
    this.type,
    this.plans = const [],
    this.createdAt,
    this.updatedAt,
  });

  factory PremiumModel.fromJson(Map<String, dynamic> json) {
    return PremiumModel(
      id: json["id"]?.toString(),
      featureName: json["name"] ?? "",
      type: json["type"] ?? "",
      plans:
          json["plan"] == null
              ? []
              : List<PlanModel>.from(
                (json["plan"] as List).map((x) => PlanModel.fromJson(x)),
              ),
      createdAt:
          json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
      updatedAt:
          json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": featureName,
    "type": type,
    "plan": List<dynamic>.from(plans.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class PlanModel {
  String? duration; // "3 Months", "6 Months", etc.
  String? basic;
  String? premium;

  PlanModel({this.duration, this.basic, this.premium});

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
      duration: json["duration"]?.toString(),
      basic: json["basic"]?.toString(),
      premium: json["premium"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    "duration": duration,
    "basic": basic,
    "premium": premium,
  };
}
