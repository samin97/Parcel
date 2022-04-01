import 'package:flutter/material.dart';
import 'package:user_app/mainScreens/home_screen.dart';
import 'current_delivery/accept_rider.dart';
import 'current_delivery/ongoing_delivery.dart';
import 'current_delivery/wait_rider.dart';

class CurrentDelivery extends StatefulWidget {
  var userUID;

  @override
  _CurrentDeliveryState createState() => _CurrentDeliveryState();
}

class _CurrentDeliveryState extends State<CurrentDelivery> {
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
            Route newRoute = MaterialPageRoute(builder: (_) => HomeScreen());
            Navigator.pushReplacement(context, newRoute);
          },
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
        automaticallyImplyLeading: false,
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  flex: 3,
                  child: InkWell(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            color: Colors.orange[300],
                            child: const Align(
                              child: Text(
                                'Waiting   Rider',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontFamily: "Signatra",
                                ),
                              ),
                              alignment: Alignment(0.1, 0.1),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            color: Colors.orange[300],
                            alignment: Alignment.bottomCenter,
                            child: Image.asset(
                              "images/waiting.png",
                              height: 170,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Route newRoute = MaterialPageRoute(
                          builder: (context) => WaitingRider());
                      Navigator.pushReplacement(context, newRoute);
                    },
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: InkWell(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              color: Colors.cyan.shade300,
                              child: const Align(
                                child: Text(
                                  'Accept   Rider',
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontFamily: "Signatra",
                                  ),
                                ),
                                alignment: Alignment(0.1, 0.1),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              color: Colors.cyan.shade300,
                              alignment: Alignment.center,
                              child: Image.asset(
                                "images/accept.png",
                                height: 270,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Route newRoute = MaterialPageRoute(
                            builder: (context) => AcceptRider());
                        Navigator.pushReplacement(context, newRoute);
                      }),
                ),
                Flexible(
                  flex: 3,
                  child: InkWell(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            color: Colors.orange[300],
                            child: const Align(
                              child: Text(
                                'Ongoing   Delivery',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontFamily: "Signatra",
                                ),
                              ),
                              alignment: Alignment(0.1, 0.1),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            color: Colors.orange[300],
                            alignment: Alignment.bottomCenter,
                            child: Image.asset(
                              "images/ongoing.png",
                              height: 270,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Route newRoute = MaterialPageRoute(
                          builder: (context) => OngoingDelivery());
                      Navigator.pushReplacement(context, newRoute);
                    },
                  ),
                ),
              ])),
    );
  }
}
