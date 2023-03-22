class ReportPackage {
  String? reason;
  String? accountId;
  String? packageId;
  String? imageUrl;

  ReportPackage({this.reason, this.accountId, this.packageId, this.imageUrl});

  ReportPackage.fromJson(Map<String, dynamic> json) {
    reason = json['reason'];
    accountId = json['accountId'];
    packageId = json['packageId'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['reason'] = reason;
    data['accountId'] = accountId;
    data['packageId'] = packageId;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
