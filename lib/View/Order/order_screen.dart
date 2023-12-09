import 'package:ecommerce_app/Utils/Constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderSreen extends StatelessWidget {
  const OrderSreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: 'Comming Soon'.text.xl3.color(kgreenTextColor).makeCentered(),
      ),
    );
  }
}
