import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:user_app/api/parcel_api.dart';
import 'package:user_app/controller/parcel_notifier.dart';
import 'package:provider/provider.dart';
import 'package:user_app/model/parcel.dart';

class CurrentDelivery extends StatefulWidget {
  const CurrentDelivery({Key? key}) : super(key: key);

  @override
  _CurrentDeliveryState createState() => _CurrentDeliveryState();
}



class _CurrentDeliveryState extends State<CurrentDelivery> {

  @override
  void initState() {
    ParcelNotifier parcelNotifier = Provider.of<ParcelNotifier>(context, listen: false);
    getParcels(parcelNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ParcelNotifier parcelNotifier = Provider.of<ParcelNotifier>(context);

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
              )
          ),
        ),
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
        child: CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 1.5,
            viewportFraction: 0.9,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
          ),
          items: Parcel.parcels.map((parcel) => parcelDemo(parcel: parcel)).
          toList(),
        ),
      ),

    );
  }
}

class parcelDemo extends StatelessWidget {

  final Parcel parcel;
  const parcelDemo(
  {
    required this.parcel
}
      );
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            Container(
              child: Image.network(
                Parcel.parcels[0].parcelImageUrl,
              ),
            )
            Text(parcel.title)
          ],
        ),
      ),
    );
  }
}
