import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/admin/dashboard/admin.dashbord.controller.dart';

class AdminDashBoard extends StatefulWidget {
  const AdminDashBoard({super.key});

  @override
  State<AdminDashBoard> createState() => _AdminDashBoardState();
}

class _AdminDashBoardState extends State<AdminDashBoard> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminDashboardController>(
      init: AdminDashboardController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.white,
            elevation: 1,
            leading: const Icon(
              Icons.arrow_back,
              size: 20,
              color: AppColor.primary,
            ).toButton(onTap: Get.back),
            title: const Text("Admin Dashboard").title(fontSize: 14),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns
                      mainAxisSpacing: 16.0, // Spacing between rows
                      crossAxisSpacing: 16.0, // Spacing between columns
                      childAspectRatio: 1.5,
                    ),
                    itemCount: _.data.length, // Number of grid items
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 17,
                              backgroundColor: AppColor.white.withAlpha(70),
                              child: Icon(
                                _.data[index]['icon'],
                                color: AppColor.white,
                                size: 20,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: FittedBox(
                                child: Text(_.data[index]['title']
                                        .toString()
                                        .split(" ")[0])
                                    .title(fontSize: 18, color: AppColor.white),
                              ),
                            ),
                            Text(_.data[index]['title'].toString())
                                .subTitle(fontSize: 14, color: AppColor.white)
                          ],
                        ),
                      )
                          .roundCorner(
                            showShadow: false,
                            bgColor: _.data[index]['color']! as Color,
                            borderColor: AppColor.transparent,
                          )
                          .toButton(onTap: _.data[index]['onTap']);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
