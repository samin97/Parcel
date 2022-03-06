import 'package:flutter/material.dart';
import 'package:user_app/api/parcel_api.dart';
import 'package:user_app/controller/parcel_notifier.dart';
import 'package:provider/provider.dart';

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
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index){
            return ListTile(
              title: Text(parcelNotifier.parcelList[index].title),
              subtitle: Text(parcelNotifier.parcelList[index].pick+parcelNotifier.parcelList[index].price),

            );
          }, itemCount: parcelNotifier.parcelList.length,
      separatorBuilder: (BuildContext context,int index){
            return const Divider(
              color: Colors.black,
            );
      },)

    );
  }
}
