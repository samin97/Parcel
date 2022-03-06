import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:user_app/controller/parcel_notifier.dart';
import 'package:user_app/model/parcel.dart';

getParcels(ParcelNotifier parcelNotifier) async{
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('parcel').get();

  List<Parcel> _parcelList = [];

  snapshot.docs.forEach((documents) {
  Parcel parcel = Parcel.fromMap(documents.data);
  _parcelList.add(parcel);
  });
  parcelNotifier.parcelList = _parcelList;
}

