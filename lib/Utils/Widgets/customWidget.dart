import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Constant/colors.dart';
import '../utils.dart';

Widget swipperWidget() {
  return VxSwiper.builder(
    aspectRatio: 16 / 9,
    autoPlay: true,
    height: 150,
    enlargeCenterPage: true,
    itemCount: 3,
    itemBuilder: (context, index) {
      return Container(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: klightredColor,
            image: const DecorationImage(
                image: AssetImage('assets/images/swiperBackground.png'),
                fit: BoxFit.cover)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(children: [
                            '20% OFF\n'
                                .textSpan
                                .color(korangeColor)
                                .bold
                                .size(20)
                                .fontFamily('Poppins')
                                .make(),
                            'on any fast food item'
                                .textSpan
                                .color(kDarkBlue)
                                .make()
                          ])),
                      const SizedBox(
                        height: 5.0,
                      ),
                      //order button
                      customOrderButton(
                        () {
                          flushBarMessage('Bying not Supported yet', context,
                              kgreenTextColor);
                        },
                      ).pOnly(right: 15.0),
                    ],
                  )),

                  //date text
                  const Text(
                    'Valid until Mar 23',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontFamily: 'Poppins', color: kgreyColor, fontSize: 12),
                  )
                ],
              ).pOnly(top: 20.0),
            ),

            //image conatiner
            Image.asset(
              'assets/images/Pizza.png',
              fit: BoxFit.cover,
              height: 125,
            )
          ],
        ).pOnly(left: 5.0, bottom: 3.0),
      );
    },
  );
}

Widget serchButton() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
    ),
    height: 50,
    child: TextFormField(
      cursorColor: kgreyColor,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
          hintText: 'Seach for shops & restaurants',
          hintStyle: const TextStyle(
              color: kgreyColor,
              fontFamily: 'Heading',
              fontSize: 15,
              fontWeight: FontWeight.normal),
          prefixIcon: const Icon(
            CupertinoIcons.search,
            color: kgreyColor,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: kOutLineColor, width: 2.0)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: kOutLineColor, width: 2.0))),
    ),
  );
}
