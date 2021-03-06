// ignore_for_file: unused_import

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/global/global.dart';
import 'package:user_app/mainScreens/loacation_map.dart';
import 'package:user_app/widgets/custom_text_field.dart';
import 'package:user_app/widgets/error_dialog.dart';
import 'package:user_app/widgets/loading_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart' as p_storage;
import 'package:user_app/authentication/auth_screen.dart';

import 'home_screen.dart';

class RequestDelivery extends StatefulWidget {
  const RequestDelivery({Key? key}) : super(key: key);

  @override
  _RequestDeliveryState createState() => _RequestDeliveryState();
}

class _RequestDeliveryState extends State<RequestDelivery> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController pickController = TextEditingController();
  TextEditingController dropController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dropphoneController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  bool taken = false;
  bool approved = false;
  bool userCompleted = false;
  bool riderCompleted = false;

  String parcelImageUrl = "";
  String nameController = "";

  XFile? parcelImageXFile;
  final ImagePicker _parcel = ImagePicker();

  var rid = '';

  Future<void> _getImage() async {
    parcelImageXFile = await _parcel.pickImage(source: ImageSource.camera);

    setState(() {
      parcelImageXFile;
    });
  }

  Future<void> validate() async {
    if (parcelImageUrl == null) {
      showDialog(
          context: context,
          builder: (c) {
            return const ErrorDialog(
              message: "Please Select an image.",
            );
          });
    } else {
      if (titleController.text.isNotEmpty &&
          detailController.text.isNotEmpty &&
          weightController.text.isNotEmpty &&
          phoneController.text.isNotEmpty &&
          dropphoneController.text.isNotEmpty &&
          pickController.text.isNotEmpty &&
          dropController.text.isNotEmpty &&
          priceController.text.isNotEmpty) {
        showDialog(
            context: context,
            builder: (c) {
              return LoadingDialog(
                message: "Posting Delivery Request",
              );
            });
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        p_storage.Reference reference = p_storage.FirebaseStorage.instance
            .ref()
            .child("parcel")
            .child(fileName);
        p_storage.UploadTask uploadTask =
            reference.putFile(File(parcelImageXFile!.path));
        p_storage.TaskSnapshot taskSnapshot =
            await uploadTask.whenComplete(() {});
        await taskSnapshot.ref.getDownloadURL().then((url) {
          parcelImageUrl = url;

          //save to database
          User? currentParcel;
          var sellerUID = sharedPreferences!.getString("sellerUID");
          FirebaseFirestore.instance
              .collection("parcel")
              .doc(currentParcel?.uid)
              .set({
            "title": titleController.text.trim(),
            "sellerUID": sellerUID,
            "rid": rid,
            "parcelImageUrl": parcelImageUrl,
            "detail": detailController.text.trim(),
            "weight": weightController.text.trim(),
            "phone": phoneController.text.trim(),
            "dropphone": dropphoneController.text.trim(),
            "pick": pickController.text.trim(),
            "drop": dropController.text.trim(),
            "price": priceController.text.trim(),
            "taken": taken,
            "approved": approved,
            "userCompleted": userCompleted,
            "riderCompleted": riderCompleted,
            "pid": currentParcel?.uid,
            "completedDate": DateTime.now().millisecondsSinceEpoch,
          });
          //sends user to home page
          Navigator.pop(context);
          Route newRoute =
              MaterialPageRoute(builder: (c) => const HomeScreen());
          Navigator.pushReplacement(context, newRoute);
        });
      } else {
        showDialog(
            context: context,
            builder: (c) {
              return ErrorDialog(
                message: "Please fill all the information.",
              );
            });
      }
    }
  }

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
          title: const Text(
            'Delivery request form',
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
          
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    _getImage();
                  },
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Picture of Package',
                        style: TextStyle(fontSize: 32, color: Colors.black54),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.50,
                          backgroundColor: Colors.white,
                          backgroundImage: parcelImageXFile == null
                              ? null
                              : FileImage(File(parcelImageXFile!.path)),
                          child: parcelImageXFile == null
                              ? Icon(
                                  Icons.add_photo_alternate,
                                  size:
                                      MediaQuery.of(context).size.width * 0.50,
                                  color: Colors.grey,
                                )
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          data: Icons.title,
                          controller: titleController,
                          hintText: "Title",
                          isObsecre: false,
                        ),
                        CustomTextField(
                          data: Icons.details,
                          controller: detailController,
                          hintText: "Details",
                          isObsecre: false,
                        ),
                        CustomTextField(
                          data: Icons.all_inbox,
                          controller: weightController,
                          hintText: "Approximate weight",
                          isObsecre: false,
                        ),
                        CustomTextField(
                          data: Icons.phone,
                          controller: phoneController,
                          hintText: "Phone number",
                          isObsecre: false,
                        ),
                        CustomTextField(
                          data: Icons.phone,
                          controller: dropphoneController,
                          hintText: "Drop off Phone number",
                          isObsecre: false,
                        ),
                        CustomTextField(
                          data: Icons.location_on,
                          controller: pickController,
                          hintText: "Pickup",
                          isObsecre: false,
                          enabled: true,
                        ),
                        CustomTextField(
                          data: Icons.location_on,
                          controller: dropController,
                          hintText: "Drop off",
                          isObsecre: false,
                          enabled: true,
                        ),
                        // Container(
                        //   width: 400,
                        //   height: 40,
                        //   alignment: Alignment.center,
                        //   child: ElevatedButton.icon(
                        //     label: const Text(
                        //       "check on maps",
                        //       style: TextStyle(color: Colors.white),
                        //     ),
                        //     icon: const Icon(
                        //       Icons.location_on,
                        //       color: Colors.white,
                        //     ),
                        //     style: ElevatedButton.styleFrom(
                        //         primary: Colors.blue,
                        //         shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(30))),
                        //     onPressed: () {
                        //       Navigator.pop(context);
                        //       Route newRoute = MaterialPageRoute(
                        //           builder: (c) => const LocationMap());
                        //       Navigator.pushReplacement(context, newRoute);
                        //     },
                        //   ),
                        // ),
                        CustomTextField(
                          data: Icons.attach_money_outlined,
                          controller: priceController,
                          hintText: "Price",
                          isObsecre: false,
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {
                    validate();
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ));
  }
}
