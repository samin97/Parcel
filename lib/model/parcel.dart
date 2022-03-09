import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Parcel extends Equatable {
  final String id;
  final String parcelImageUrl;
  final String title;
  final String detail;
  final String weight;
  final String phone;
  final String pick;
  final String drop;
  final String price;
  final String taken;
  final String approved;
  final String uid;
  final String rid;

  Parcel({
    required this.id,
    required this.title,
    required this.parcelImageUrl,
    required this.uid,
    required this.rid,
    required this.detail,
    required this.weight,
    required this.phone,
    required this.pick,
    required this.drop,
    required this.price,
    required this.taken,
    required this.approved,
  });

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
        uid: json['uid'],
        parcelImageUrl: json['parcelImageUrl'],
        rid: json['rid']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['detail'] = detail;
    data['weight'] = weight;
    data['phone'] = phone;
    data['pick'] = pick;
    data['drop'] = drop;
    data['price'] = price;
    data['taken'] = taken;
    data['approved'] = approved;
    data['uid'] = uid;
    data['parcelImageUrl'] = parcelImageUrl;
    data['rid'] = rid;

    return data;
  }

  @override
  List<Object?> get props => [
        id,
        title,
        parcelImageUrl,
        detail,
        weight,
        phone,
        pick,
        drop,
        price,
        taken,
        approved,
        uid,
        rid,
      ];
  static List<Parcel> parcels = {
    Parcel(
      id: 'a',
      title: 'a',
      parcelImageUrl: 'a',
      detail: 'a',
      weight: 'a',
      phone: 'a',
      pick: 'a',
      drop: 'a',
      price: 'a',
      taken: 'a',
      approved: 'a',
      uid: 'a',
      rid: 'a',
    )
  } as List<Parcel>;
}
