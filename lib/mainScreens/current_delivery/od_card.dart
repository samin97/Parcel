import 'package:flutter/material.dart';
import 'package:user_app/model/json_parcel.dart';

import 'od_details.dart';


class ODCard extends StatefulWidget {
  final Order model;
  final String orderID;
  final int value;

  ODCard({
    required this.model,
    required this.orderID,
    required this.value,
  });


  @override
  _ODCardState createState() => _ODCardState();
}
class _ODCardState extends State<ODCard> {
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
                    builder: (context) => ODDetails(
                      documentID: widget.orderID,

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
