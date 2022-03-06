
import 'package:cloud_firestore/cloud_firestore.dart';

class Parcel{
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

   Parcel.fromMap(Map data){
     id = data['id'];
     title = data['title'];
     detail = data['detail'];
     weight = data['weight'];
     phone = data['phone'];
     pick = data['pick'];
     drop = data['drop'];
     price = data['price'];
     taken = data['taken'];
     approved = data['approved'];
     createdAt = data['createdAt'];
   }

}