import 'package:ecommerce_app/Controllers/home_page_cotroller.dart';
import 'package:ecommerce_app/Utils/Constant/colors.dart';
import 'package:ecommerce_app/View/Chats/chats_screen.dart';
import 'package:ecommerce_app/View/Home/home_screen.dart';
import 'package:ecommerce_app/View/Order/order_screen.dart';
import 'package:ecommerce_app/View/Profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../Utils/utils.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var controller = Get.put(HomePageController());

  var navBody = [
    HomeScreen(),
    const OrderSreen(),
    const SizedBox.shrink(),
    const ChatScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Obx(() =>
                Expanded(child: navBody.elementAt(controller.pageIndex.value)))
          ],
        ),
        bottomNavigationBar: bottomNavigationBar());
  }

  Widget bottomNavigationBar() {
    return Obx(
      () => Stack(
        children: [
          Container(
            height: 85,
            decoration: const BoxDecoration(
              gradient: kprimaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: BottomNavigationBar(
              currentIndex: controller.pageIndex.value,
              onTap: (index) {
                controller.pageIndex.value = index;
              },
              selectedLabelStyle:
                  const TextStyle(color: Colors.white, fontFamily: 'Heading'),
              unselectedLabelStyle:
                  const TextStyle(color: kgreyColor, fontFamily: 'Heading'),
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              unselectedItemColor: kgreyColor,
              selectedItemColor: Colors.white,
              items: [
                BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage(controller.pageIndex.value == 0
                          ? 'assets/Icons/home-Filled.png'
                          : 'assets/Icons/home-Regular.png'),
                    ),
                    label: 'Home'),
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage(controller.pageIndex.value == 1
                        ? 'assets/Icons/package-Filled.png'
                        : 'assets/Icons/package-Regular.png')),
                    label: 'Order'),
                const BottomNavigationBarItem(
                  icon: SizedBox(width: 20), // Add space between icons
                  label: ' ', // Empty label to keep space for the SizedBox
                ),
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage(controller.pageIndex.value == 3
                        ? 'assets/Icons/comment-dots-Filled.png'
                        : 'assets/Icons/message-regular.png')),
                    label: 'Chats'),
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage(controller.pageIndex.value == 4
                        ? 'assets/Icons/user-Filled.png'
                        : 'assets/Icons/user-Regular.png')),
                    label: 'Profile')
              ],
            ),
          ),
          Positioned(
            top: 6,
            left: MediaQuery.of(context).size.width * 0.5 -
                30, // Adjust this value to position the button vertically
            child: GestureDetector(
              onTap: () {
                // Handle button tap
              },
              child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3), // Shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 5, // Blur radius
                      offset:
                          const Offset(0, 3), // Offset in x and y directions
                    ),
                  ], shape: BoxShape.circle, gradient: kGrediantButtonColor),
                  child: const ImageIcon(
                    color: Colors.white,
                    AssetImage(
                      'assets/Icons/shopping-basket-Filled.png',
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
