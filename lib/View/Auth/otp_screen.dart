import 'package:ecommerce_app/Utils/Constant/colors.dart';
import 'package:ecommerce_app/Utils/utils.dart';
import 'package:ecommerce_app/View/Home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:velocity_x/velocity_x.dart';

class Otp_verify extends StatefulWidget {
  final String verificationId;
  const Otp_verify({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<Otp_verify> createState() => _Otp_verifyState();
}

class _Otp_verifyState extends State<Otp_verify> {
  TextEditingController otpController = TextEditingController();
  FocusNode phoneFocusNode = FocusNode();

  void verifyOTP() async {
    String otp = otpController.text.trim();

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: otp);

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        flushBarMessage(
            'You have succesfully Sign Up', context, kgreenTextColor);
        Get.offAll(() => const Home());
      }
    } on FirebaseAuthException catch (ex) {
      if (ex.code.contains('invalid-verification-code')) {
        flushBarMessage('Invalid Code', context, Colors.red);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/otp.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Pinput(
                controller: otpController,
                length: 6,
                // defaultPinTheme: defaultPinTheme,
                // focusedPinTheme: focusedPinTheme,
                // submittedPinTheme: submittedPinTheme,

                showCursor: true,
                onCompleted: (pin) => print(pin),
              ),
              const SizedBox(
                height: 20,
              ),
              customSignUpButton(() => verifyOTP(), 50, double.infinity,
                      Text(
            'Verify Phone Number',
            style: const TextStyle(
                fontSize: 16, fontFamily: 'Poppins', color: Colors.white),
          ), phoneFocusNode, otpController)
                  .px(10.0),
              Row(
                children: [
                  const Text(
                    "Did not receive Code?",
                    style: TextStyle(color: kDarkBlue),
                  ),
                  TextButton(
                      onPressed: () {
                        // Navigator.pushNamedAndRemoveUntil(
                        //   context,
                        //   'phone',
                        //   (route) => false,
                        // );
                      },
                      child: const Text(
                        "Resend",
                        style: TextStyle(color: klightBlue),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
