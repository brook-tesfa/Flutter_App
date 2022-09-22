class Pharmacy {
  int? id;
  String? pharmacyName;
  String? pharmacyAddress;
  String? bankAccount;
  double? currentLatitude;
  double? currentLongitude;
  String? createdAt;
  String? updatedAt;
  Null? accountId;
  Null? adminId;
  int? distance;
  Pharmacy(
      {this.id,
      this.pharmacyName,
      this.pharmacyAddress,
      this.bankAccount,
      this.currentLatitude,
      this.currentLongitude,
      this.createdAt,
      this.updatedAt,
      this.accountId,
      this.adminId,
      this.distance});

  Pharmacy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pharmacyName = json['pharmacyName'];
    pharmacyAddress = json['pharmacyAddress'];
    bankAccount = json['bankAccount'];
    currentLatitude = json['currentLatitude'];
    currentLongitude = json['currentLongitude'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    accountId = json['accountId'];
    adminId = json['adminId'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pharmacyName'] = this.pharmacyName;
    data['pharmacyAddress'] = this.pharmacyAddress;
    data['bankAccount'] = this.bankAccount;
    data['currentLatitude'] = this.currentLatitude;
    data['currentLongitude'] = this.currentLongitude;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['accountId'] = this.accountId;
    data['adminId'] = this.adminId;
    data['distance'] = this.distance;
    return data;
  }
}
