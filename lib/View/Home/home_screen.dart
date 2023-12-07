import 'package:ecommerce_app/Utils/Constant/colors.dart';
import 'package:ecommerce_app/Utils/Constant/string_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../Controllers/home_page_cotroller.dart';
import '../../Utils/Widgets/customWidget.dart';
import '../../Utils/Widgets/general_warning_exception.dart';
import '../../Utils/Widgets/internetExceptionWidget.dart';
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
  void initState() {
    controller.userListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: context.screenHeight,
        width: context.screenWidth,
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
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
            gridViewWidget(),

            //text
            Align(
              alignment: Alignment.centerLeft,
              child: 'Store'
                  .text
                  .color(kDarkBlue)
                  .xl2
                  .fontFamily('Poppins')
                  .make()
                  .pOnly(left: 10.0),
            ),

            //strore
            stores()
          ],
        ),
      )),
    );
  }

  Widget stores() {
    return Obx(() {
      switch (controller.rxRequestStatus.value) {
        case Status.LOADING:
          return const Center(
              child: CupertinoActivityIndicator(
            color: kgreenTextColor,
          ));
        case Status.ERROR:
          if (controller.error.value == 'No internet') {
            return InterNetExceptionWidget(
              onPress: () {
                controller.refreshApi();
              },
            );
          } else {
            return GeneralExceptionWidget(
              onPress: () {
              controller.refreshApi();
            });
          }
        case Status.COMPLETED:
          return SizedBox(
            height: 170.0,
            child: ListView(
              clipBehavior: Clip.antiAlias,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: List.generate(controller.userList.length, (int index) {
                var list = controller.userList[index];
                return GestureDetector(
                  onTap: () {
                    flushBarMessage(
                        'Bying not Supported yet', context, kgreenTextColor);
                  },
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.transparent),
                      width: 80.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.network(list.image.toString()),
                          5.heightBox,
                          Align(
                            alignment: Alignment.center,
                            child: list.category
                                .toString()
                                .toUpperCase()
                                .text
                                .size(10)
                                .overflow(TextOverflow.clip)
                                .make(),
                          )
                        ],
                      )),
                );
              }),
            ),
          );
      }
    });
  }

  Widget gridViewWidget() {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 380,
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
