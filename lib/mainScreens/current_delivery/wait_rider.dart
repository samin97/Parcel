import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user_app/global/global.dart';
import 'package:user_app/mainScreens/current_delivery.dart';
import 'package:user_app/mainScreens/current_delivery/wr_card.dart';
import 'package:user_app/model/json_parcel.dart';

class WaitingRider extends StatefulWidget {
  @override
  _WaitingRiderState createState() => _WaitingRiderState();
}

class _WaitingRiderState extends State<WaitingRider> {
  var currentUserID = sharedPreferences!.getString("sellerUID")!;

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
            Route newRoute =
                MaterialPageRoute(builder: (_) => CurrentDelivery());
            Navigator.pushReplacement(context, newRoute);
          },
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Waiting riders',
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontFamily: "Lobster",
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("parcel")
                .where('taken', isEqualTo: false)
                .where('approved', isEqualTo: false)
                .where('userCompleted', isEqualTo: false)
                .where('sellerUID', isEqualTo: currentUserID)
                .snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? const Center(child: CircularProgressIndicator())
                  : snapshot.data!.docs.isEmpty
                      ? Container()
                      : ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
                            return WRCard(
                              value: index,
                              orderID: snapshot.data!.docs[index].id,
                              model: Order.fromJson(snapshot.data!.docs[index]
                                  .data() as Map<String, dynamic>),
                            );
                          },
                        );
            }),
      ),
    );
  }
}
