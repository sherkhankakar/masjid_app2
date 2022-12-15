import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:masjid/constants/app_colors.dart';
import 'package:masjid/constants/app_routes.dart';
import 'package:masjid/constants/navigator.dart';
import 'package:masjid/constants/sizes.dart';
import 'package:masjid/widgets/app_screen/app_screen.dart';
import 'package:masjid/widgets/text/buttons/custom_button.dart';
import 'package:masjid/widgets/text/custom_text.dart';

import '../constants/app_values.dart';
import '../widgets/svg_image/svg_image.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailCtr = TextEditingController();
  final TextEditingController _passCtr = TextEditingController();
  final TextEditingController _confirmPassCtr = TextEditingController();

  @override
  void dispose() {
    _emailCtr.dispose();
    _passCtr.dispose();
    super.dispose();
  }

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
              text: "Sign Up",
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
                  _passCtr.text;
                },
                onTap: () {},
                obscure: true),
            gap(height: 20),
            textFieldBox(
                labelname: 'Confirm Password',
                ctr: _confirmPassCtr,
                typ: TextInputType.visiblePassword,
                valueSaved: (val) {
                  _confirmPassCtr.text;
                },
                onTap: () {},
                obscure: true),
            gap(height: 40),
            CustomButton(
              text: 'Sign Up',
              onTapFunction: () async {
                if (_formKey.currentState!.validate()) {
                  signUp(_emailCtr.text, _passCtr.text);
                }
              },
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

  void signUp(String email, String password) async {
    String confirmPass = _confirmPassCtr.text.trim();

    if (password == confirmPass) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          Fluttertoast.showToast(msg: "user created");
          postDetails(value.user!.uid);
        });
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    } else {
      Fluttertoast.showToast(msg: "Passwords don't match");
    }
  }

  void postDetails(String uid) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var id = firebaseFirestore.collection("users").doc().id.toString();
    await firebaseFirestore.collection("users").doc(id).set({
      "email": _emailCtr.text,
      "mid": id,
    }).then((value) {
      Fluttertoast.showToast(msg: "Sign Up Successfully");
      navigate(OurRoutes.add);
    });
  }
}
