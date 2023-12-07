import 'package:ecommerce_app/Utils/Constant/colors.dart';
import 'package:ecommerce_app/Utils/Constant/string_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../Controllers/home_page_cotroller.dart';
import '../../Utils/utils.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key})
      : assert(feturesList.length == feturesListdesc.length),
        assert(feturesList.length == featuresImageList.length);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: context.screenHeight,
        width: context.screenWidth,
        child: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 5.0,
            ),
            //location widget
            locationWidget().px(5.0),
            const SizedBox(
              height: 5.0,
            ),
            serchButton().px(16.0),
            const SizedBox(
              height: 15.0,
            ),
            //swiper
            swipperWidget(),

            //grid view
            gridViewWidget()
          ],
        ),
      )),
    );
  }

  Widget gridViewWidget() {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 100,
      child: MasonryGridView.builder(
        padding: const EdgeInsets.fromLTRB(8.0, 25.0, 8.0, 8.0),
        mainAxisSpacing: 8.0, // spacing between rows
        crossAxisSpacing: 8.0,
        itemCount: feturesList.length,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          assert(index >= 0 && index < feturesList.length);

          return Container(
              decoration: BoxDecoration(
                  color: kLightGreyColor,
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  //Text
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      feturesList[index],
                      style: const TextStyle(
                          fontSize: 18.0,
                          color: kDarkBlue,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                  Text(
                    feturesListdesc[index],
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                        fontSize: 13, fontFamily: 'Poppins', color: kgreyColor),
                  ),
                  5.heightBox,
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset(featuresImageList[index]))
                ],
              ).p(10.0));
        },
      ),
    );
  }

  Widget stores() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          
        ],
      ),
    );
  }

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
                          () {},
                        ).pOnly(right: 15.0),
                      ],
                    )),

                    //date text
                    const Text(
                      'Valid until Mar 23',
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: kgreyColor,
                          fontSize: 12),
                    )
                  ],
                ).pOnly(top: 20.0),
              ),

              //image conatiner
              Image.asset('assets/images/Pizza.png')
            ],
          ).pOnly(left: 5.0, bottom: 3.0),
        );
      },
    );
  }

  Widget locationWidget() {
    return Row(
      children: [
        Expanded(
            child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.location_on_outlined,
              color: korangeColor,
            ),
            //text
            'Shopping in Riyadh'
                .text
                .color(kDarkBlue)
                .fontFamily('Heading')
                .make()
                .pOnly(left: 5.0),
            //outlineButton
            OutlinedButton(
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size>(
                            const Size(0.0, 30)),
                        side: MaterialStateProperty.all<BorderSide>(
                            const BorderSide(color: korangeColor))),
                    onPressed: () => customDialog(),
                    child: 'Change Location'
                        .text
                        .color(korangeColor)
                        .fontFamily('Heading')
                        .makeCentered())
                .pOnly(left: 7.0)
          ],
        )),
        //icon
        Obx(
          () => IconButton(
              onPressed: () => controller.favouriteBool.value =
                  !controller.favouriteBool.value,
              icon: controller.favouriteBool.value
                  ? const Icon(
                      CupertinoIcons.heart_fill,
                      color: kgreenTextColor,
                    )
                  : const Icon(
                      CupertinoIcons.heart,
                      color: kgreenTextColor,
                    )),
        )
      ],
    );
  }
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
