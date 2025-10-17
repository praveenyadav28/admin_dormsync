import 'dart:convert';

List<LicenceList> licenceListFromJson(List<dynamic> jsonList) {
  return List<LicenceList>.from(
    jsonList.map((x) => LicenceList.fromJson(x as Map<String, dynamic>)),
  );
}

String licenceListToJson(List<LicenceList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LicenceList {
  int? id;
  String? licenceNo;
  DateTime? licenseDueDate;
  DateTime? amcDueDate;
  String? companyName;
  String? lAddress;
  String? lCity;
  String? lState;
  String? gstNo;
  String? ownerName;
  String? contactNo;
  String? dealAmt;
  String? amcAmt;
  String? receiveAmt;
  String? dueAmt;
  int? branchCount;
  String? salesman;
  String? remarks;
  DateTime? createdAt;
  DateTime? updatedAt;

  LicenceList({
    this.id,
    this.licenceNo,
    this.licenseDueDate,
    this.amcDueDate,
    this.companyName,
    this.lAddress,
    this.lCity,
    this.lState,
    this.gstNo,
    this.ownerName,
    this.contactNo,
    this.dealAmt,
    this.receiveAmt,
    this.dueAmt,
    this.amcAmt,
    this.branchCount,
    this.salesman,
    this.remarks,
    this.createdAt,
    this.updatedAt,
  });

  factory LicenceList.fromJson(Map<String, dynamic> json) => LicenceList(
    id: json["id"],
    licenceNo: json["licence_no"].toString(),
    licenseDueDate:
        json["license_due_date"] == null
            ? null
            : DateTime.parse(json["license_due_date"]),
    amcDueDate:
        json["amc_due_date"] == null
            ? null
            : DateTime.parse(json["amc_due_date"]),
    companyName: json["company_name"],
    lAddress: json["l_address"],
    lCity: json["l_city"],
    lState: json["l_state"],
    gstNo: json["gst_no"],
    ownerName: json["owner_name"],
    contactNo: json["contact_no"],
    dealAmt: json["deal_amt"],
    receiveAmt: json["receive_amt"],
    dueAmt: json["due_amt"],
    amcAmt: json["amc_amt"],
    branchCount: json["branch_count"],

    salesman: json["salesman"],
    remarks: json["remarks"],
    createdAt:
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "licence_no": licenceNo,
    "license_due_date": licenseDueDate?.toIso8601String().split("T").first,
    "amc_due_date": amcDueDate?.toIso8601String().split("T").first,
    "company_name": companyName,
    "l_address": lAddress,
    "l_city": lCity,
    "l_state": lState,
    "gst_no": gstNo,
    "owner_name": ownerName,
    "contact_no": contactNo,
    "deal_amt": dealAmt,
    "receive_amt": receiveAmt,
    "due_amt": dueAmt,
    "amc_amt": amcAmt,
    "branch_count": branchCount,
    "salesman": salesman,
    "remarks": remarks,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
