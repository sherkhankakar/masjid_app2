import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:masjid/constants/app_colors.dart';
import 'package:masjid/constants/app_decorations.dart';
import 'package:masjid/constants/app_routes.dart';
import 'package:masjid/constants/navigator.dart';
import 'package:masjid/constants/sizes.dart';
import 'package:masjid/widgets/app_screen/app_screen.dart';
import 'package:masjid/widgets/appbar/custom_appbar.dart';
import 'package:masjid/widgets/text/custom_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/text/buttons/custom_button.dart';

class MasjidDetails extends StatefulWidget {
  String? id;

  MasjidDetails({Key? key, this.id}) : super(key: key);

  @override
  State<MasjidDetails> createState() => _MasjidDetailsState();
}

class _MasjidDetailsState extends State<MasjidDetails> {
  String masjidName = '';

  User? user = FirebaseAuth.instance.currentUser;

  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore? firebaseFirestore;
  final Completer<GoogleMapController> _controller = Completer();

  //var args;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.9772137, 71.4253848),
    zoom: 11,
  );

  @override
  void initState() {
    firebaseFirestore = FirebaseFirestore.instance;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //args = ModalRoute.of(context)!.settings.arguments;
    super.didChangeDependencies();
    // firebaseFirestore!.collection('mosques').doc(args).get().then((value) {

    // });
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
        child: Column(
      children: [
        const CustomAppBar(),
        gap(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: masjidName,
                fontColor: AppColors.whiteWithOpacy77,
                fontSize: AppSizes.s22,
              ),
              CustomButton(
                text: 'Set As Default',
                width: 110,
                onTapFunction: () {
                  if (user == null) {
                    navigate(OurRoutes.login);
                    setDefaultMosque(widget.id!);
                  } else {
                    navigate(OurRoutes.home);
                    setDefaultMosque(widget.id!);
                  }
                },
              )
            ],
          ),
        ),
        gap(height: 20),
        Container(
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration:
                AppDecorations.roundedDecoration(color: AppColors.cardColor),
            child: StreamBuilder(
                stream: firebaseFirestore!
                    .collection('mosques')
                    .doc(widget.id!)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CustomText(text: 'Loading');
                  }
                  var userDocument = snapshot.data;
                  Future.delayed(Duration.zero, () {
                    setState(() {
                      masjidName = userDocument!['name'];
                    });
                  });

                  return Column(
                    children: [
                      gap(height: 10),
                      const CustomText(
                        text: 'نماز کے اوقات',
                        fontColor: AppColors.primaryColor,
                        fontSize: AppSizes.s18,
                      ),
                      gap(height: 15),
                      prayerItem(
                          prayerName: 'فجر',
                          prayerTime: userDocument!['fajar']),
                      gap(height: 15),
                      prayerItem(
                          prayerName: 'ظہر',
                          prayerTime: userDocument!['zuhar']),
                      gap(height: 15),
                      prayerItem(
                          prayerName: 'عصر', prayerTime: userDocument!['asar']),
                      gap(height: 15),
                      prayerItem(
                          prayerName: 'مغرب',
                          prayerTime: userDocument!['maghrib']),
                      gap(height: 15),
                      prayerItem(
                          prayerName: 'عشاء',
                          prayerTime: userDocument!['esha']),
                    ],
                  );
                })),
        gap(height: 15),
        const CustomText(
          text: 'Masjid Location',
          fontColor: AppColors.whiteWithOpacy77,
        ),
        gap(height: 15),
        Container(
          height: 250,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
          decoration: AppDecorations.roundedDecoration(
              color: AppColors.cardColor, radius: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              initialCameraPosition: _kGooglePlex,
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                setState(() {
                  _controller.complete(controller);
                });
              },
            ),
          ),
        ),
        gap(height: 20),
        const CustomButton(
          text: 'Get Directions',
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 15),
        )
      ],
    ));
  }

  Widget prayerItem({String? prayerName, String? prayerTime}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: prayerTime,
            fontColor: AppColors.whiteWithOpacy77,
          ),
          CustomText(
            text: prayerName,
            fontColor: AppColors.primaryColor,
          )
        ],
      ),
    );
  }

  void setDefaultMosque(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('mosque_id', id);
  }
}
