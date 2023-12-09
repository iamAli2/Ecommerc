import 'package:ecommerce_app/Utils/Constant/colors.dart';
import 'package:ecommerce_app/Utils/utils.dart';
import 'package:ecommerce_app/View/Auth/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _auth.currentUser != null
          ? const Center(
              child: Text(
                'Your Profile has been created',
                style: TextStyle(color: kDarkBlue),
              ),
            )
          : SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //image
                  Image.asset(
                    'assets/images/system-solid-8-account.gif',
                    height: 170,
                    color: korangeColor.withOpacity(0.8),
                  ).centered(),

                  // customProfileButton(() {
                  //   // Navigate to the login screen
                  //   navigateToLogin();
                  // }, 50, 150, 'Login'),
                  // 10.heightBox,
                  // 'OR'
                  //     .text
                  //     .xl2
                  //     .fontFamily('Poppins')
                  //     .color(kDarkBlue)
                  //     .makeCentered()
                  //     .px(10.0),
                  // 10.heightBox,
                  customProfileButton(() {
                    Get.to(()=>const SignUp(),
      duration: const Duration(milliseconds: 200), transition: Transition.fade);
                  }, 50, 190, 'Sign Up'),
                ],
              ),
            ),
    );
  }
}
