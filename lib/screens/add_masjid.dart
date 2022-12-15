import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:masjid/constants/app_colors.dart';
import 'package:masjid/constants/app_routes.dart';
import 'package:masjid/constants/navigator.dart';
import 'package:masjid/constants/sizes.dart';
import 'package:masjid/widgets/app_screen/app_screen.dart';
import 'package:masjid/widgets/text/buttons/custom_button.dart';
import 'package:masjid/widgets/text/custom_text.dart';

class AddMasjid extends StatefulWidget {
  const AddMasjid({Key? key}) : super(key: key);

  @override
  State<AddMasjid> createState() => _AddMasjidState();
}

class _AddMasjidState extends State<AddMasjid> {
  //final Location _location = Location();
  final _auth = FirebaseAuth.instance;

  late LatLng _selectedLocation;

  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> displayTimeDialog(TextEditingController ctr) async {
    final TimeOfDay? time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time != null) {
      setState(() {
        var data = time.format(context);
        //selectedTime = time.format(context) as TimeOfDay;
        print(data);
        ctr.text = data;
      });
      //print(selectedTime);
    }
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _masjidNameCtr = TextEditingController();
  final TextEditingController _fajrTimeCtr = TextEditingController();
  final TextEditingController _zuharTimeCtr = TextEditingController();
  final TextEditingController _asarTimeCtr = TextEditingController();
  final TextEditingController _maghribTimeCtr = TextEditingController();
  final TextEditingController _eshaTimeCtr = TextEditingController();

  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.9772137, 71.4253848),
    zoom: 12,
  );

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        actions: [
          Center(
            child: CustomButton(
              text: 'Add Masjid',
              onTapFunction: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
        title: SizedBox(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onLongPress: (LatLng location) {
              setState(() {
                _selectedLocation = location;
              });

            },
          ),
        ));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
        child: Form(
      key: _formKey,
      child: ListView(
        children: [
          gap(height: 20),
          const CustomText(
            text: 'Add Masjid',
            textAlign: TextAlign.center,
            fontColor: AppColors.whiteWithOpacy77,
            fontSize: AppSizes.s18,
          ),
          gap(height: 30),
          textFieldBox(
              labelname: 'Masjid Name',
              ctr: _masjidNameCtr,
              typ: TextInputType.name,
              valueSaved: (val) {
                _masjidNameCtr.text;
              },
              onTap: () {},
              read: false),
          gap(height: 10),
          textFieldBox(
              labelname: 'Fajar Time',
              ctr: _fajrTimeCtr,
              typ: TextInputType.datetime,
              valueSaved: (val) {
                _fajrTimeCtr.text;
              },
              onTap: () {
                //print('hi');
                displayTimeDialog(_fajrTimeCtr);
              },
              read: true),
          gap(height: 10),
          textFieldBox(
              labelname: 'Zuhar Time',
              ctr: _zuharTimeCtr,
              typ: TextInputType.datetime,
              valueSaved: (val) {
                _zuharTimeCtr.text;
              },
              onTap: () {
                displayTimeDialog(_zuharTimeCtr);
              },
              read: true),
          gap(height: 10),
          textFieldBox(
              labelname: 'Asar Time',
              ctr: _asarTimeCtr,
              typ: TextInputType.datetime,
              valueSaved: (val) {
                _asarTimeCtr.text;
              },
              onTap: () {
                displayTimeDialog(_asarTimeCtr);
              },
              read: true),
          gap(height: 10),
          textFieldBox(
              labelname: 'Maghrib Time',
              ctr: _maghribTimeCtr,
              typ: TextInputType.datetime,
              valueSaved: (val) {
                _fajrTimeCtr.text;
              },
              onTap: () {
                displayTimeDialog(_maghribTimeCtr);
              },
              read: true),
          gap(height: 10),
          textFieldBox(
              labelname: 'Esha Time',
              ctr: _eshaTimeCtr,
              typ: TextInputType.datetime,
              valueSaved: (val) {
                _eshaTimeCtr.text;
              },
              onTap: () {
                displayTimeDialog(_eshaTimeCtr);
              },
              read: true),
          gap(height: 10),
          IconButton(
            onPressed: () {
              showAlertDialog(context);
            },
            icon: const Icon(Icons.add_location_rounded),
            color: AppColors.primaryColor,
            iconSize: 40,
          ),
          gap(height: 15),
          CustomButton(
            onTapFunction: () {
              if (_formKey.currentState!.validate()) {
                sendMasjidDetails();
              }
            },
            padding: const EdgeInsets.symmetric(horizontal: 15),
            text: 'Add Masjid',
          )
        ],
      ),
    ));
  }

  Padding textFieldBox(
      {String? labelname,
      TextEditingController? ctr,
      TextInputType? typ,
      Function(String?)? valueSaved,
      Function()? onTap,
      required bool read}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        onTap: onTap,
        readOnly: read,
        style: const TextStyle(color: AppColors.whiteWithOpacy77),
        controller: ctr,
        keyboardType: typ,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            floatingLabelStyle:
                const TextStyle(color: AppColors.whiteWithOpacy77),
            focusColor: Colors.black,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor)),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.whiteWithOpacy77)),
            hintText: labelname,
            hintStyle: const TextStyle(color: AppColors.whiteWithOpacy77)),
        onSaved: valueSaved,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Data");
          }
          return null;
        },
      ),
    );
  }

  void sendMasjidDetails() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var id  = firebaseFirestore.collection("mosques").doc().id.toString();
    await firebaseFirestore.collection("mosques").doc(id).set({
      "name": _masjidNameCtr.text,
      "fajar": _fajrTimeCtr.text,
      "zuhar": _zuharTimeCtr.text,
      "asar": _asarTimeCtr.text,
      "esha": _eshaTimeCtr.text,
      "maghrib": _maghribTimeCtr.text,
      "mid" : id,
    }).then((value) {
      Fluttertoast.showToast(msg: "Data Send Successfully");
      navigate(OurRoutes.home);
    });
  }
}
