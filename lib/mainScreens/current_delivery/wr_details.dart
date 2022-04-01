import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user_app/mainScreens/current_delivery/wait_rider.dart';
import 'package:user_app/model/json_parcel.dart';

import '../current_delivery.dart';
class WRDetails extends StatefulWidget {

  final Order model;
  final String orderID;
  final int value;

  WRDetails({required this.model,
    required this.orderID,
    required this.value,});

  @override
  _WRDetailsState createState() => _WRDetailsState();
}

class _WRDetailsState extends State<WRDetails> {
  @override
  Widget build(BuildContext context) {
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
            Route newRoute = MaterialPageRoute(builder: (_) => WaitingRider());
            Navigator.pushReplacement(context, newRoute);
          },
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'My items',
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontFamily: "Lobster",
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),

      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.model.title.toString(),
                style: const TextStyle(
                  fontSize: 35,
                  color: Colors.black54,
                  fontFamily: "Signatra",
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text('Parcel ID : ' + widget.orderID),
              const Divider(
                thickness: 4,
              ),

              Container(
                width: MediaQuery.of(context).size.width,
                height: 125,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  image: DecorationImage(
                    image: NetworkImage(widget.model.parcelImageUrl.toString()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Divider(
                thickness: 4,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Details: ' + widget.model.detail,
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
                'From: ' + widget.model.pick,
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
                'To: ' + widget.model.drop,
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
                'Price: Rs' + widget.model.price,
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
                'Phone: ' + widget.model.phone,
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
                'Weight: ' + widget.model.weight + 'kg',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                  fontFamily: "Varela Round",
                ),
              ),
              ElevatedButton(
                child: const Text('Cancel order'),
                onPressed: () {
                  final docParcel = FirebaseFirestore.instance.collection('parcel').doc(widget.orderID);
                  docParcel.delete();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CurrentDelivery()));
                },
              ),
            ],
          ),
        ),
      ),


      //todo body: SingleChildScrollView(
      //   child: StreamBuilder<QuerySnapshot>(
      //       stream: FirebaseFirestore.instance
      //           .collection("parcel")
      //           .doc(widget.documentID)
      //           .snapshots(),
      //       builder: (context, snapshot) {
      //         return !snapshot.hasData
      //             ? const Center(child: CircularProgressIndicator())
      //             : snapshot.data!.docs.isEmpty
      //             ? Container()
      //             : ListView.builder(
      //           itemCount: snapshot.data!.docs.length,
      //           shrinkWrap: true,
      //           physics: ScrollPhysics(),
      //           itemBuilder: (context, index) {
      //             return WRCard(
      //               value: index,
      //               orderID: snapshot.data!.docs[index].id,
      //               model: Order.fromJson(snapshot.data!.docs[index]
      //                   .data() as Map<String, dynamic>),
      //             );
      //           },
      //         );
      //       }),
      // ),

    );
  }
}
