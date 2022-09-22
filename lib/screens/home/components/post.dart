import 'package:shop_app/screens/home/components/pharmacy_model.dart';

class post {
  int? id;
  String? drugname;
  String? manufactureDate;
  String? expDate;
  int? price;
  String? drugDescription;
  String? createdAt;
  String? updatedAt;
  Null? categoryId;
  int? userId;
  int? pharmacyId;
  Pharmacy? pharmacy;

  post({
    this.id,
    this.drugname,
    this.manufactureDate,
    this.expDate,
    this.price,
    this.drugDescription,
    this.createdAt,
    this.updatedAt,
    this.categoryId,
    this.userId,
    this.pharmacyId,
    this.pharmacy,
  });

  post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    drugname = json['Drugname'];
    manufactureDate = json['manufactureDate'];
    expDate = json['expDate'];
    price = json['price'];
    drugDescription = json['drugDescription'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    categoryId = json['categoryId'];
    userId = json['userId'];
    pharmacyId = json['pharmacyId'];
    pharmacy = json['pharmacy'] != null
        ? new Pharmacy.fromJson(json['pharmacy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Drugname'] = this.drugname;
    data['manufactureDate'] = this.manufactureDate;
    data['expDate'] = this.expDate;
    data['price'] = this.price;
    data['drugDescription'] = this.drugDescription;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['categoryId'] = this.categoryId;
    data['userId'] = this.userId;
    data['pharmacyId'] = this.pharmacyId;
    if (this.pharmacy != null) {
      data['pharmacy'] = this.pharmacy!.toJson();
    }

    return data;
  }
}
