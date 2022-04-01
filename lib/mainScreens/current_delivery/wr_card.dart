import 'package:flutter/material.dart';
import 'package:user_app/mainScreens/current_delivery/wr_details.dart';
import 'package:user_app/model/json_parcel.dart';

class WRCard extends StatefulWidget {
  final Order model;
  final String orderID;
  final int value;

  WRCard({
    required this.model,
    required this.orderID,
    required this.value,
  });

  @override
  _WRCardState createState() => _WRCardState();
}

class _WRCardState extends State<WRCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Text(
              widget.model.pick.toString() +
                  ' to ' +
                  widget.model.drop.toString(),
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black54,
                fontFamily: "BebasNeue",
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Price : Rs ' + widget.model.price.toString(),
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black54,
                fontFamily: "BebasNeue",
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              child: const Text('Details'),
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                Route newRoute = MaterialPageRoute(
                    builder: (context) => WRDetails(
                          model: widget.model,
                          value: widget.value,
                          orderID: widget.orderID,
                        ));
                Navigator.pushReplacement(context, newRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}
