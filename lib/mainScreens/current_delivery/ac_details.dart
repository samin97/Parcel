import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../current_delivery.dart';
import 'accept_rider.dart';
class ACDetails extends StatefulWidget {
  final String documentID;
  final formKey = GlobalKey<FormState>();
  var id;

  ACDetails({required this.documentID});

  @override
  State<ACDetails> createState() => _ACDetailsState();
}

class _ACDetailsState extends State<ACDetails> {
  var data;
  var rData;
  dynamic parcelDetails;
  dynamic riderDetails;
  String title = '';
  String parcelImageUrl = '';
  String detail = '';
  String weight = '';
  String phone = '';
  String dropphone = '';
  String pick = '';
  String drop = '';
  String price = '';
  String rid = '';
  String riderName = '';
  String riderPhone = '';
  String riderLicence = '';

  Future<String> package() async {
    // todo

    await FirebaseFirestore.instance
        .collection('parcel')
        .doc(widget.documentID)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      data = documentSnapshot.data();
      title = data['title'];
      parcelImageUrl = data['parcelImageUrl'];
      detail = data['detail'];
      weight = data['weight'];
      pick = data['pick'];
      drop = data['drop'];
      phone = data['phone'];
      dropphone = data['dropphone'];
      price = data['price'];
      rid = data['rid'];
    });
    await FirebaseFirestore.instance
        .collection('rider')
        .doc(rid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      rData = documentSnapshot.data();
      riderName = rData['riderName'];
      riderLicence = rData['license no'];
      riderPhone = rData['phone'];
    });
    throw(e);
  }

  @override
  Widget build(BuildContext context) {
    final detailsDoc = widget.documentID;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.orange,
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              )),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Route newRoute =
            MaterialPageRoute(builder: (_) => AcceptRider());
            Navigator.pushReplacement(context, newRoute);
          },
        ),
        title: Text(
          'Details',
          style: const TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontFamily: "Lobster",
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<String>(
          future: package(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const CircularProgressIndicator()
                : SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.all(8)),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 35,
                      color: Colors.black54,
                      fontFamily: "Signatra",
                    ),
                  ),
                  Text('Parcel ID : ' + widget.documentID),

                  //Text()

                  const Divider(
                    thickness: 4,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Details: ' + detail,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                      fontFamily: "Varela Round",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'From: ' + pick,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                      fontFamily: "Varela Round",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'To: ' + drop,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                      fontFamily: "Varela Round",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'User Phone no: ' + phone,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                      fontFamily: "Varela Round",
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(8)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Receiver Phone no: ' + dropphone,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                      fontFamily: "Varela Round",
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(8)),
                  const Divider(
                    thickness: 4,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Rider Name: ' + riderName,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                      fontFamily: "Varela Round",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Rider Phone: ' + riderPhone,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                      fontFamily: "Varela Round",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Rider Licence Number: ' + riderLicence,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                      fontFamily: "Varela Round",
                    ),
                  ),
                  ElevatedButton(
                    child: const Text('Accept Rider'),
                    onPressed: () {
                      final docParcel = FirebaseFirestore.instance
                          .collection('parcel')
                          .doc(widget.documentID);
                      docParcel.update({
                        'approved': true,
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CurrentDelivery()));
                    },
                  )
                ],
              ),
            );
          }),
    );
  }
}
