import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:ecommerce_app/Utils/Constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

void customDialog() {
  Get.dialog(
    AlertDialog(
      title: const Text(
        'Comming Soon',
        style: TextStyle(color: kDarkBlue, fontSize: 20),
      ),
      content: const Text("This feature is'nt available right now"),
      actions: [
        TextButton(
          child: const Text(
            "Close",
            style: TextStyle(color: korangeColor),
          ),
          onPressed: () => Get.back(),
        ),
      ],
    ),
  );
}

Widget customOrderButton(VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), gradient: kprimaryColor),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        //text
        'Order Now'.text.white.fontFamily('Poppins').makeCentered(),
        //Icon
        const Icon(
          Icons.arrow_forward_rounded,
          color: Colors.white,
        )
      ]).p(5),
    ),
  );
}

enum Status { LOADING, COMPLETED, ERROR }

void flushBarMessage(String message, BuildContext context, Color color) {
  showFlushbar(
    context: context,
    flushbar: Flushbar(
      forwardAnimationCurve: Curves.decelerate,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(15),
      message: message,
      duration: const Duration(seconds: 3),
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: color,
      reverseAnimationCurve: Curves.easeInOut,
      positionOffset: 20,
      icon: const Icon(
        Icons.error,
        size: 28,
        color: Colors.white,
      ),
    )..show(context),
  );
}
