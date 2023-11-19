import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/home/home.notification/home.notification.controller.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppNotificationController>(
      init: AppNotificationController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          body: CW.pageWithAppBar(title: "Notifications", children: [
            CW.AppSpacer(h: 20),
            SizedBox(
              height: Get.height * .86,
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 30,
                  itemBuilder: (context, index) => Column(
                        children: [
                          Card(
                            elevation: .5,
                            clipBehavior: Clip.hardEdge,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxWidth: Get.width * .65),
                                        child: const Text(
                                                "Title from thhat enand some other end so look out for long message title")
                                            .title(
                                                lines: 5,
                                                fontSize: 12,
                                                color: AppColor.text),
                                      ),
                                      CW.AppSpacer(w: 20),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(DateTime.now()
                                                  .toLocal()
                                                  .toString()
                                                  .split(" ")[0])
                                              .subTitle(
                                                  fontSize: 12,
                                                  color: AppColor.text),
                                          CW.AppSpacer(h: 8),
                                          Text(DateTime.now()
                                                  .toLocal()
                                                  .toString()
                                                  .split(" ")[1]
                                                  .split(".")[0])
                                              .subTitle(
                                                  fontSize: 12,
                                                  color: AppColor.text),
                                          CW.AppSpacer(h: 4),
                                        ],
                                      )
                                    ],
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(_.isOpened.value &&
                                                _.currentOpened == index
                                            ? "> Hide <"
                                            : "< View >")
                                        .subTitle(),
                                  )
                                ],
                              ),
                            ),
                          ).toButton(onTap: () => _.openSelected(index)),
                          Visibility(
                            visible:
                                _.isOpened.value && _.currentOpened == index,
                            child: SlideInDown(
                              child: Column(
                                children: [
                                  Image.asset(
                                    Assets.assetsImagesImage,
                                    fit: BoxFit.cover,
                                  ),
                                  CW.AppSpacer(h: 6),
                                  Text(
                                      "some randome message, some randome messagesome randome messagesome randome message some randome messagesome randome messagesome randome messagesome randome messagesome randome messagesome randome messagesome randome messagesome randome messagesome randome messagesome randome messagesome randome messagesome randome messagesome randome message"),
                                  Visibility(
                                      visible: true,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text("Click here")
                                              .subTitle(fontSize: 10),
                                          Icon(Icons.arrow_right_alt_rounded),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Accept")
                                                .title(fontSize: 12)
                                                .toButton(onTap: () {}),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ),
                          CW.AppSpacer(h: 20),
                        ],
                      )),
            )
          ]),
        );
      },
    );
  }
}
