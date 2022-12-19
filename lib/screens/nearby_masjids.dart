import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:masjid/widgets/app_screen/app_screen.dart';
import 'package:masjid/widgets/text/custom_text.dart';

import '../constants/app_colors.dart';
import '../constants/app_values.dart';
import '../constants/sizes.dart';
import '../widgets/svg_image/svg_image.dart';
import 'masjid_details.dart';

class NearbyMasjids extends StatefulWidget {
  const NearbyMasjids({Key? key}) : super(key: key);

  @override
  State<NearbyMasjids> createState() => _NearbyMasjidsState();
}

class _NearbyMasjidsState extends State<NearbyMasjids> {
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      child: Column(
        children: [
          gap(height: 10),
          const CustomText(
            text: 'Nearby Masjids',
            fontSize: 20,
            fontColor: AppColors.whiteWithOpacy77,
          ),
          const Divider(
            thickness: 1,
            color: AppColors.whiteWithOpacy77,
          ),
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
                                          id: snapshot.data!.docs[index].id,
                                        )));
                          },
                          child: ListTile(
                            leading: svgImage(
                                path: AssetPaths.masjidIcon, height: 30),
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
    );
  }
}
