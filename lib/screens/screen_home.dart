import 'package:analog_clock/analog_clock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:masjid/constants/app_colors.dart';
import 'package:masjid/constants/app_decorations.dart';
import 'package:masjid/constants/app_routes.dart';
import 'package:masjid/constants/app_values.dart';
import 'package:masjid/constants/navigator.dart';
import 'package:masjid/constants/sizes.dart';
import 'package:masjid/controllers/functions.dart';
import 'package:masjid/widgets/app_screen/app_screen.dart';
import 'package:masjid/widgets/appbar/custom_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masjid/widgets/svg_image/svg_image.dart';
import 'package:masjid/widgets/text/buttons/custom_button.dart';
import 'package:masjid/widgets/text/custom_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'masjid_details.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({
    Key? key,
  }) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  var masjidTimes;
  final now = DateTime.now();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String? fajarTime;

  String? zuharTime;

  String? asarTime;

  String? maghribTime;

  String? eshaTime;

  //var diffInHour;
  String? nextPrayer;
  String? nextPrayerTime;
  int? minutesUntilNextPrayer;

  getData() async{
    var data = await firebaseFirestore
        .collection('mosques')
        .doc(masjidKey2).get();
    //print(data);

    fajarTime = formatTime(data['fajar']);
    zuharTime = formatTime(data['zuhar']);
    asarTime = formatTime(data['asar']);
    maghribTime = formatTime(data['maghrib']);
    eshaTime = formatTime(data['esha']);

    print('Fajar time = $fajarTime');
    print('Zuhar time = $zuharTime');

   // final currentTime = DateFormat('hh:mm');
    //print('current time = $currentTime');
    if (now.compareTo(DateTime.parse(fajarTime.toString())) < 0) {
      nextPrayer = 'fajar';
      nextPrayerTime = fajarTime.toString();
      final nextPrayerDateTime =
          '${DateFormat('yyyy-MM-dd').format(now)} $fajarTime';
      final nextPrayerDuration =
      DateTime.parse(nextPrayerDateTime).difference(now);
      minutesUntilNextPrayer =  nextPrayerDuration.inMinutes;
      print('duration = $nextPrayerDuration' );
      print('next prayer: $nextPrayer');
      print(minutesUntilNextPrayer);
    } else {
      nextPrayer = 'asar';
      nextPrayerTime = asarTime.toString();
      final nextPrayerDateTime =
          '${DateFormat('hh:mm').format(now)} $asarTime';
      print('Next Prayer date Time = $nextPrayerDateTime');
      final nextPrayerDuration =
      DateTime.parse(nextPrayerDateTime).difference(now);
      print('Next Prayer Duration,,,,,,,,, = $nextPrayerDuration');
      minutesUntilNextPrayer =  nextPrayerDuration.inMinutes;
      print('duration = $nextPrayerDuration' );
      print('next prayer: $nextPrayer');
      print(minutesUntilNextPrayer);
    }

    // asarTime = formatTime(userDocument['zuhar']);
    // asarTime = formatTime(userDocument['asar']);
    // maghribTime = formatTime(userDocument['maghrib']);
    // eshaTime = formatTime(userDocument['esha']);
  }


  @override
  void initState() {
    super.initState();

    Future.delayed( Duration.zero).then((value) {
      getData();
    });

    // Future.delayed(const Duration(seconds: 1)).then((value) {
    //
    // });
  }

//  }

  ValueNotifier<String> masjidKey = ValueNotifier('');
  late String masjidKey2;

  void getMasjidId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    masjidTimes = preferences.getString('mosque_id');
    masjidKey.value = preferences.getString('mosque_id')!;
    masjidKey2 = preferences.getString('mosque_id')!;
  }

  @override
  void didChangeDependencies() {
    getMasjidId();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('home is called');
    return AppScreen(
      scaffoldKey: _scaffoldKey,
      drawer: Drawer(
        width: MediaQuery.of(context).size.width/1.8,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30))),
        backgroundColor: Colors.brown,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  svgImage(path: AssetPaths.masjidIcon, height: 35),
                  const CustomText(
                    text: 'مسجد',
                    fontColor: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ],
              ),
              const Divider(
                thickness: 1,
                color: AppColors.primaryColor,
              ),
              gap(height: 40),
              GestureDetector(
                  onTap: () {
                    navigate(OurRoutes.home);
                  },
                  child: drawerItem(iconItem: Icons.home, itemName: 'Home')),
              gap(height: 30),
              GestureDetector(
                  onTap: () {
                    navigate(OurRoutes.nearby);
                  },
                  child: drawerItem(
                      iconItem: Icons.near_me_outlined,
                      itemName: 'Nearby Masjids')),
              gap(height: 30),
              GestureDetector(
                  onTap: () {
                    if (user == null) {
                      navigate(OurRoutes.login);
                    } else {
                      navigate(OurRoutes.add);
                    }
                  },
                  child: drawerItem(
                      iconItem: Icons.add_box_outlined,
                      itemName: 'Add Masjid')),
              gap(height: 30),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: drawerItem(
                      iconItem: Icons.exit_to_app_outlined, itemName: 'Exit')),
            ],
          ),
        ),
      ),
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          CustomAppBar(
            ontapmenuIcon: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            ontapMasjidIcon: () {
              if (user!.email == null) {
                navigate(OurRoutes.login);
              } else {
                navigate(OurRoutes.add);
              }
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  gap(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        user != null
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      AnalogClock(
                                        height: 170.w,
                                        decoration:
                                            AppDecorations.roundedDecoration(
                                          radius: 100,
                                          color: AppColors.darkGrey,
                                        ),
                                        width: 170.w,
                                        isLive: true,
                                        hourHandColor: AppColors.primaryColor,
                                        minuteHandColor: AppColors.white,
                                        showSecondHand: true,
                                        numberColor: AppColors.primaryColor,
                                        showNumbers: true,
                                        showAllNumbers: true,
                                        textScaleFactor: 1.4,
                                        showTicks: true,
                                        showDigitalClock: false,
                                        datetime: DateTime.now(),
                                      ),
                                      gap(height: 25),
                                      CustomText(
                                        text: 'Time Remaining: ${minutesUntilNextPrayer.toString()}',
                                        fontColor: AppColors.whiteWithOpacy77,
                                        fontSize: AppSizes.s14,
                                      ),
                                    ],
                                  ),
                                  gap(width: 10),
                                  Container(
                                      decoration:
                                          AppDecorations.roundedDecoration(
                                              color: AppColors.cardColor),
                                      height: 200,
                                      width: 150,
                                      child: ValueListenableBuilder(
                                        valueListenable: masjidKey,
                                        builder: (BuildContext context, value,
                                            Widget? child) {
                                          return masjidKey.value == '' ||
                                                  masjidKey.value.isEmpty
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                              : StreamBuilder(
                                                  stream: firebaseFirestore
                                                      .collection('mosques')
                                                      .doc(masjidKey.value)
                                                      .snapshots(),
                                                  builder: (context, snapshot) {
                                                    if (!snapshot.hasData) {
                                                      return const CustomText(
                                                        text: 'Loading',
                                                      );
                                                    }
                                                    var userDocument =
                                                        snapshot.data;

                                                    return Column(
                                                      children: [
                                                        const CustomText(
                                                          text: 'نماز کے اوقات',
                                                          fontColor: AppColors
                                                              .primaryColor,
                                                          fontSize:
                                                              AppSizes.s18,
                                                        ),
                                                        gap(height: 15),
                                                        prayerItem(
                                                          prayerName: 'فجر',
                                                          prayerTime:
                                                              userDocument![
                                                                  'fajar'],
                                                        ),
                                                        gap(height: 15),
                                                        prayerItem(
                                                            prayerName: 'ظہر',
                                                            prayerTime:
                                                                userDocument[
                                                                    'zuhar']),
                                                        gap(height: 15),
                                                        prayerItem(
                                                            prayerName: 'عصر',
                                                            prayerTime:
                                                                userDocument[
                                                                    'asar']),
                                                        gap(height: 15),
                                                        prayerItem(
                                                            prayerName: 'مغرب',
                                                            prayerTime:
                                                                userDocument[
                                                                    'maghrib']),
                                                        gap(height: 15),
                                                        prayerItem(
                                                            prayerName: 'عشاء',
                                                            prayerTime:
                                                                userDocument[
                                                                    'esha']),
                                                      ],
                                                    );
                                                  },
                                                );
                                        },
                                      )),
                                ],
                              )
                            : gap(height: 0),
                      ],
                    ),
                  ),
                  gap(height: 15),
                  const CustomText(
                    text: 'NearBy Masjids',
                    fontColor: AppColors.primaryColor,
                    fontSize: AppSizes.s16,
                  ),
                  gap(height: 10),
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width,
                    // decoration: AppDecorations.roundedDecoration(
                    //   color: AppColors.cardColor,
                    // ),
                    child: FutureBuilder(
                        future: firebaseFirestore.collection('mosques').get(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MasjidDetails(
                                                  id: snapshot
                                                      .data!.docs[index].id,
                                                )));
                                  },
                                  child: ListTile(
                                    leading: svgImage(
                                        path: AssetPaths.masjidIcon,
                                        height: 30),
                                    title: Text(
                                      snapshot.data!.docs[index].data()['name'],
                                      style: const TextStyle(
                                          color: AppColors.whiteWithOpacy77,
                                          fontSize: AppSizes.s18),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  )),
                ],
              ),
            ),
          ),
          user != null
              ? CustomButton(
                  margin: const EdgeInsets.only(bottom: 10),
                  text: 'Log Out',
                  onTapFunction: () async {
                    await FirebaseAuth.instance.signOut().then((value) {
                      navigate(OurRoutes.home);
                    });
                  },
                )
              : gap(height: 0)
        ],
      ),
    );
  }

  Widget drawerItem({String? itemName, IconData? iconItem}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(width: 2, color: AppColors.primaryColor)),
      child: Row(
        children: [
          Icon(
            iconItem,
            size: 25,
            color: AppColors.primaryColor,
          ),
          gap(width: 20),
          CustomText(
            text: itemName,
            fontSize: 17,
            fontColor: AppColors.primaryColor,
          )
        ],
      ),
    );
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
}
