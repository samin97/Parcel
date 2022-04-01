import 'package:flutter/material.dart';
import 'package:user_app/authentication/auth_screen.dart';
import 'package:user_app/global/global.dart';
import 'package:user_app/mainScreens/current_delivery.dart';
import 'package:user_app/mainScreens/request_delivery.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

String ramesh = sharedPreferences!.getString("uid")!;

class _HomeScreenState extends State<HomeScreen> {
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
            ),
          ),
        ),
        title: Text(
          'Hello ' + sharedPreferences!.getString("name")!,
          style: const TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontFamily: "Lobster",
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Flexible(
            flex: 3,
            child: InkWell(
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: Colors.orangeAccent[400],
                      child: const Align(
                        child: Text(
                          'Request   For   Delivery',
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
                      color: Colors.orangeAccent[400],
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 100, 70, 100),
                        child: Image.asset(
                          "images/handset.png",
                          height: 270,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RequestDelivery()));
              },
            ),
          ),
          Flexible(
            flex: 3,
            child: InkWell(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.cyan.shade400,
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 10, 0, 10),
                        child: Image.asset(
                          "images/done.png",
                          height: 470,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: Colors.cyan.shade400,
                      child: const Align(
                        child: Text(
                          'My   Delivery   Items',
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
                ],
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CurrentDelivery()));
              },
            ),
          ),
          Flexible(
            flex: 1,
            child: InkWell(
              child: Container(
                color: Colors.lightBlue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Align(
                      child: Text('Log out', style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontFamily: "Signatra",
                      ),),
                      alignment: Alignment.center,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Icon(Icons.logout, color: Colors.white,)
                  ],
                ),
              ),
              onTap: () {
                firebaseAuth.signOut().then(
                  (value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => const AuthScreen()));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
