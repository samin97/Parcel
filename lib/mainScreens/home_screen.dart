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
              )
          ),
        ),
        title: Text(
            'Hello '+ sharedPreferences!.getString("name")!,
            style: const TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontFamily: "Lobster",
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body:Column(
          children:[
            Flexible(flex:3,
                child: InkWell(
                  child: Container(
                    color: Colors.cyan,
                    child: const Align(child: Text('Request For Delivery'),
                      alignment: Alignment(0.1,0.1),),
                  ),
                  onTap: (){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const RequestDelivery())
                    );
                  },
                )
            ),
            Flexible(flex:3,
                child: InkWell(
                  child: Container(
                    color: Colors.yellow,
                    child: const Align(child: Text('My Delivery Items'),
                      alignment: Alignment(0.1,0.1),),
                  ),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CurrentDelivery())
                    );
                  },
                )
            ),
            Flexible(flex:1,
                child: Container(
                  color: Colors.green,
                  child:  Center(
                    child: ElevatedButton(
                      child: const Text("logout"),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue
                      ),
                      onPressed: ()
                      {
                        firebaseAuth.signOut().then((value){
                          Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));

                        });

                      },
                    ),
                  ),
                )
            )
          ],
        ) ,
    );
  }
}
