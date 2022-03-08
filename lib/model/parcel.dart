import 'package:cloud_firestore/cloud_firestore.dart';

class Parcel {
  late String id;
  late String title;
  late String detail;
  late String weight;
  late String phone;
  late String pick;
  late String drop;
  late String price;
  late String taken;
  late String approved;
  late Timestamp createdAt;

  Parcel(
      {required this.id,
      required this.title,
      required this.detail,
      required this.weight,
      required this.phone,
      required this.pick,
      required this.drop,
      required this.price,
      required this.taken,
      required this.approved,
      required this.createdAt});

  factory Parcel.fromJson(Map<String, dynamic> json) {
    return Parcel(
        id: json['id'],
        title: json['title'],
        detail: json['detail'],
        weight: json['weight'],
        phone: json['phone'],
        pick: json['pick'],
        drop: json['drop'],
        price: json['price'],
        taken: json['taken'],
        approved: json['approved'],
        createdAt: json['createdAt']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = id;
    data['detail'] = detail;
    data['weight'] = weight;
    data['phone'] = phone;
    data['pick'] = pick;
    data['drop'] = drop;
    data['taken'] = taken;
    data['approved'] = approved;
    data['createdAt'] = createdAt;

    return data;
  }
}
