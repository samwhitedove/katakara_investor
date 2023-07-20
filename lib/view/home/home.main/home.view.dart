import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/customs.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/widgets/widgets.dart';

import '../home.sub/home.sub.dart';
import 'home.main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<HomeScreenController>(
      init: HomeScreenController(),
      builder: (_) => CW.baseStackWidget(
        bottomNavigationBar: BottomNavigationBar(
          onTap: _.isActive.value
              ? (value) => _.currentIndex(value)
              : (w) => HC.snack(tGoLiveToActive),
          showUnselectedLabels: true,
          currentIndex: _.currentIndex.value,
          backgroundColor:
              _.isActive.value ? AppColor.primary : AppColor.inActiveBlack,
          selectedItemColor: _.isActive.value ? AppColor.white : AppColor.grey,
          unselectedItemColor:
              _.isActive.value ? AppColor.white.withOpacity(.4) : AppColor.grey,
          items: List.generate(
            _.navBar.length,
            (index) => BottomNavigationBarItem(
              backgroundColor:
                  _.isActive.value ? AppColor.primary : AppColor.inActiveBlack,
              icon: SvgPicture.asset(_.isActive.value
                  ? _.currentIndex.value == index
                      ? _.navBar[index]['active']
                      : _.navBar[index]['inActive']
                  : _.navBar[index]['inActive']),
              label: _.navBar[index]['label'],
            ),
          ),
        ),
        isLoading: _.isLoading.value,
        key: _.scaffoldKey,
        drawer: SizedBox(
          width: Get.width * .7,
          child: _.isActive.value
              ? Drawer(
                  child: AppDrawer(),
                )
              : const SizedBox(),
        ),
        children: [
          IndexedStack(
            index: _.currentIndex.value,
            children: [
              // KFIPageScreen(ctr: _),
              InboxPageScreen(ctr: _),
              HomePageScreen(ctr: _),
              ProfilePageScreen(ctr: _),
            ],
          ),
        ],
      ),
    );
  }
}
