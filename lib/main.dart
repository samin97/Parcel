import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/controller/parcel_notifier.dart';
import 'package:user_app/global/global.dart';
import 'package:user_app/splash_screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context)=>ParcelNotifier()),],
        child: MyApp()
    ));
}

class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Users App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MySplashScreen(),
    );
  }
}

