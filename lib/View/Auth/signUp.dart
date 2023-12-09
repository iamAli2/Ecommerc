import 'package:ecommerce_app/Data/Repositories/store_repo.dart';
import 'package:ecommerce_app/Utils/Constant/colors.dart';
import 'package:ecommerce_app/View/Auth/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../Controllers/sign_up_controller.dart';
import '../../Utils/utils.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String dialCode = '';
  final repo = HomeRepository();
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  final signUpController = Get.put(SignUpController());
  FocusNode phoneFocusNode = FocusNode();

  @override
  void initState() {
    getCountryCode();
    super.initState();
  }

  void getCountryCode() async {
    try {
      var data = await repo.getCountryPhoneCode();
      setState(() {
        countryController.text = data ?? '';
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  void sendOTP() async {
    String phone = "${countryController.text}${phoneController.text.trim()}";
    signUpController.isLoading.value = true;
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        codeSent: (verificationId, resendToken) {
          signUpController.isLoading.value = false;
          Get.to(()=>Otp_verify(
                verificationId: verificationId,
              ),
      duration: const Duration(milliseconds: 200), transition: Transition.fade);
        },
        verificationCompleted: (credential) {
          signUpController.isLoading.value = false;
        },
        verificationFailed: (ex) {
          flushBarMessage(ex.toString(), context, Colors.red);
        },
        codeAutoRetrievalTimeout: (verificationId) {},
        timeout: const Duration(seconds: 30));
  }

  @override
  void dispose() {
    phoneController.dispose();
    phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kDarkBlue),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          //image
          Center(
              child: Image.asset('assets/images/phoneNo.png').pOnly(top: 70)),

          50.heightBox,
          //text
          Align(
            alignment: Alignment.centerLeft,
            child: 'Welcome to Find'
                .text
                .xl2
                .fontFamily('Poppins')
                .color(kDarkBlue)
                .make()
                .pOnly(left: 14.0),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: 'Enter your phone number below to get into Find'
                .text
                .fontFamily('Poppins')
                .color(kgreyColor)
                .make()
                .pOnly(left: 14.0),
          ),
          25.heightBox,
          Align(
            alignment: Alignment.centerLeft,
            child: 'Phone'
                .text
                .size(18)
                .fontFamily('Poppins')
                .color(kDarkBlue)
                .make()
                .pOnly(left: 14.0),
          ),
          10.heightBox,
          Align(
            alignment: Alignment.center,
            child: phoneTextField().px(10.0),
          ),
          20.heightBox,
          Obx(
            () => customSignUpButton(() {
              FocusScope.of(context).unfocus();
              sendOTP();
            },
                    50,
                    double.infinity,
                    signUpController.isLoading.value
                        ? const CupertinoActivityIndicator(
                            radius: 15,
                            color: Colors.white,
                          )
                        : const Text(
                            'Continue',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                color: Colors.white),
                          ),
                    phoneFocusNode,
                    phoneController)
                .px(10.0),
          ),
        ],
      ),
    );
  }

  Widget phoneTextField() {
    return Container(
      height: 55,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: kgreyColor),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 40,
            child: TextField(
              cursorColor: kgreyColor,
              controller: countryController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          const Text(
            "|",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: TextField(
            controller: phoneController,
            cursorColor: kgreyColor,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Phone",
            ),
          ))
        ],
      ),
    );
  }
}
