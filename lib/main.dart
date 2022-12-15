import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masjid/constants/app_colors.dart';
import 'package:masjid/constants/app_font.dart';
import 'package:masjid/controllers/main_controller.dart';
import 'package:masjid/screens/splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/app_routes.dart';
import 'constants/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
// Test

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainController()),
      ],
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        designSize: const Size(392, 825),
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          title: 'Masjid',
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.darkGrey,
            primarySwatch: Colors.orange,
            fontFamily: FontConstants.poppins,
          ),
          routes: tabRoutes(navigatorKey, const Splash()),
        ),
      ),
    );
  }
}
