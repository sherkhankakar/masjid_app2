import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:masjid/constants/app_routes.dart';
import 'package:masjid/constants/navigator.dart';
import 'package:masjid/screens/splash.dart';
import 'package:masjid/widgets/app_screen/app_screen.dart';
import 'package:masjid/widgets/svg_image/svg_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_colors.dart';
import '../constants/app_values.dart';
import '../constants/sizes.dart';
import '../widgets/text/buttons/custom_button.dart';
import '../widgets/text/custom_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailCtr = TextEditingController(text: 'ali@gmail.com' );
  final TextEditingController _passCtr = TextEditingController( text: '123456');

  @override
  Widget build(BuildContext context) {
    return AppScreen(
        child: Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            svgImage(
              height: 150,
              path: AssetPaths.masjidIcon,
            ),
            gap(height: 30),
            const CustomText(
              text: "Log In",
              fontSize: AppSizes.s20,
              fontColor: AppColors.whiteWithOpacy77,
            ),
            gap(height: 30),
            textFieldBox(
                labelname: 'Email',
                ctr: _emailCtr,
                typ: TextInputType.emailAddress,
                valueSaved: (val) {
                  _emailCtr.text;
                },
                onTap: () {},
                obscure: false),
            gap(height: 20),
            textFieldBox(
                labelname: 'Password',
                ctr: _passCtr,
                typ: TextInputType.visiblePassword,
                valueSaved: (val) {
                  _emailCtr.text;
                },
                onTap: () {},
                obscure: true),
            gap(height: 40),
            CustomButton(
                text: 'Log In',
                onTapFunction: () async {
                  var sharedPref = await SharedPreferences.getInstance();
                  sharedPref.setBool(LOGIN, true);
                  if (_formKey.currentState!.validate()) {
                    signIn();
                  }
                }),
            gap(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomText(
                  text: 'Don\'t have account?',
                  fontColor: AppColors.whiteWithOpacy77,
                ),
                TextButton(
                    onPressed: () {
                      navigate(OurRoutes.signup);
                    },
                    child: const Text('Sign Up Here'))
              ],
            )
          ],
        ),
      ),
    ));
  }

  Padding textFieldBox(
      {String? labelname,
      TextEditingController? ctr,
      TextInputType? typ,
      Function(String?)? valueSaved,
      Function()? onTap,
      required bool obscure}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        onTap: onTap,
        obscureText: obscure,
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

  void signIn() async {
    try {
      final User? user = (await _auth.signInWithEmailAndPassword(
              email: _emailCtr.text, password: _passCtr.text))
          .user;
      if (user != null) {

          Fluttertoast.showToast(msg: "Logged In Successfully");
          Navigator.pushReplacement(
            context,
            navigate(OurRoutes.home),
          );
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
