import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices{

  final String pid;
  DatabaseServices({required this.pid});
  //collection reference
  final CollectionReference parcel = FirebaseFirestore.instance.collection('parcelDemo');

  Future updateParcelData(String title, String uid, String detail, String weight, String phone, String pick, String drop, String price  ) async{
    return await parcel.doc(pid).set({
      'title' : title,
      'uid': uid,
      'detail' : detail,
      'weight': weight,
      'phone': phone,
      'pick' : pick,
      'drop' : drop,
      'price' : price
    });
  }
}