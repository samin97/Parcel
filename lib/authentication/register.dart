import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/global/global.dart';
import 'package:user_app/mainScreens/home_screen.dart';
import 'package:user_app/widgets/custom_text_field.dart';
import 'package:user_app/widgets/error_dialog.dart';
import 'package:user_app/widgets/loading_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart' as f_storage;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  Position? position;
  List<Placemark>? placeMarks;

  String sellerImageUrl = "";
  String completeAddress = "";

  Future<void> _getImage() async{
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageXFile;
    });
  }

  getCurrentLocation() async{
    Position newPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    position = newPosition;
    placeMarks = await placemarkFromCoordinates(
      position!.latitude,
      position!.longitude,
    );

    Placemark pMark = placeMarks![0];

    completeAddress = '${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea}, ${pMark.administrativeArea} ${pMark.postalCode}, ${pMark.country}';
    locationController.text = completeAddress;
  }

  Future<void> formValidation() async{
    if(imageXFile == null)
    {
      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message: "Please Select an image.",
            );
          }
      );
    }
    else{
      if(passwordController.text == confirmPasswordController.text)
      {
        if(confirmPasswordController.text.isNotEmpty && emailController.text.isNotEmpty && nameController.text.isNotEmpty && phoneController.text.isNotEmpty && locationController.text.isNotEmpty)
          {
            //start uploading image
            showDialog(
                context: context,
                builder: (c)
                {
                  return LoadingDialog(
                    message: "Registering Account",
                  );
                }
            );
            String fileName = DateTime.now().millisecondsSinceEpoch.toString();
            f_storage.Reference reference = f_storage.FirebaseStorage.instance.ref().child("sellers").child(fileName);
            f_storage.UploadTask uploadTask = reference.putFile(File(imageXFile!.path));
            f_storage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
            await taskSnapshot.ref.getDownloadURL().then((url){
              sellerImageUrl = url;

              // save info to firestorm db
              authenticateSellerAndSignUp();
            });
          }
        else
          {
            showDialog(
                context: context,
                builder: (c){
                  return ErrorDialog(
                    message: "Please fill all the information.",
                  );
                }
            );
          }
      }
      else
      {
        showDialog(
            context: context,
            builder: (c){
              return ErrorDialog(
                message: "Password do not match.",
              );
            }
        );
      }
    }

  }

  void authenticateSellerAndSignUp() async{
    User? currentUser;

    await firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
    ).then((auth){
      currentUser = auth.user;
    }).catchError((error){
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message: error.message.toString(),
            );
          }
      );

    });

    if(currentUser != null){
      saveDataToFirestore(currentUser!).then((value){
        Navigator.pop(context);
        //sends user to home page
        Route newRoute = MaterialPageRoute(builder: (c) => const HomeScreen());
        Navigator.pushReplacement(context, newRoute);
      });
    }
  }

  Future saveDataToFirestore(User currentUser) async{
    FirebaseFirestore.instance.collection("sellers").doc(currentUser.uid).set({
      "sellerUID": currentUser.uid,
      "sellerEmail": currentUser.email,
      "sellerName": nameController.text.trim(),
      "sellerAvatar": sellerImageUrl,
      "phone": phoneController.text.trim(),
      "address": completeAddress,
      "status": "approved",
      "earnings" : 0.0,
      "lat": position!.latitude,
      "lng": position!.longitude,
    });

    // save data locally
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid", currentUser.uid);
    await sharedPreferences!.setString("email", currentUser.email.toString());
    await sharedPreferences!.setString("name", nameController.text.trim());
    await sharedPreferences!.setString("lat", position!.latitude.toString());
    await sharedPreferences!.setString("lng", position!.longitude.toString());

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 10,),
          InkWell(
            onTap: ()
            {
              _getImage();
            },
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.20,
              backgroundColor: Colors.white,
              backgroundImage: imageXFile==null ? null : FileImage(File(imageXFile!.path)),
              child: imageXFile == null
                  ?
                Icon(
                  Icons.add_photo_alternate,
                  size: MediaQuery.of(context).size.width * 0.20,
                  color: Colors.grey,
                ) : null,
            ),
          ),
          const SizedBox(height: 10,),
          Form(
            key: _formkey,
            child: Column(
              children: [
                CustomTextField(
                  data: Icons.person,
                  controller: nameController,
                  hintText: "Name",
                  isObsecre: false,
                ),
                CustomTextField(
                  data: Icons.email,
                  controller: emailController,
                  hintText: "Email",
                  isObsecre: false,
                ),
                CustomTextField(
                  data: Icons.lock,
                  controller: passwordController,
                  hintText: "Password",
                  isObsecre: true,
                ),
                CustomTextField(
                  data: Icons.lock,
                  controller: confirmPasswordController,
                  hintText: "Conform Password",
                  isObsecre: true,
                ),
                CustomTextField(
                  data: Icons.phone,
                  controller: phoneController,
                  hintText: "Phone",
                  isObsecre: false,
                ),
                CustomTextField(
                  data: Icons.my_location,
                  controller: locationController,
                  hintText: "Current Location",
                  isObsecre: false,
                  enabled: false,
                ),
                Container(
                  width: 400,
                  height: 40,
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                      label: const Text(
                          "Get my Location",
                        style: TextStyle(color: Colors.white),
                      ),
                    icon: const Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                    onPressed: (){
                        getCurrentLocation();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amber,
                      shape:  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
            child: const Text(
              "Sign up",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.lightBlueAccent,
              shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            ),
            onPressed: (){
              formValidation();
            },
          ),
          const SizedBox(height: 30,),
        ],
      ),
    );
  }
}
