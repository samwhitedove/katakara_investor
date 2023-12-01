import 'package:animate_do/animate_do.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/home/home.notification/home.notification.controller.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final ScrollController scrollController = ScrollController();
  final notify = Get.find<AppNotificationController>();

  void scrollListener() {
    // Check if the scroll position is at the end of the list
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      // Scrolled to the end
      notify.fetchMoreNotification();
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
    notify.notification.clear();
    notify.page = 1;
    notify.hasFullFetch = true;
    notify.fetchNotification();
    AwesomeNotifications().dismissAllNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppNotificationController>(
      init: AppNotificationController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          body: CW.pageWithAppBar(title: "Notifications", children: [
            Column(
              children: [
                SizedBox(
                  height: Get.height * .9,
                  child: ListView.builder(
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _.notification.length,
                      itemBuilder: (context, index) => Column(
                            children: [
                              Card(
                                margin: EdgeInsets.zero,
                                elevation: .5,
                                clipBehavior: Clip.hardEdge,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                                maxWidth: Get.width * .65),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(_.notification[index]
                                                        .title!)
                                                    .subTitle(
                                                        bold: _
                                                                .notification[
                                                                    index]
                                                                .isRead! ==
                                                            false,
                                                        lines: 5,
                                                        fontSize: 11,
                                                        color: AppColor.text),
                                                CW.AppSpacer(h: 4),
                                                Text(_.notification[index]
                                                        .body!)
                                                    .subTitle(
                                                        lines: 2,
                                                        fontSize: 10,
                                                        color: AppColor.text),
                                              ],
                                            ),
                                          ),
                                          CW.AppSpacer(w: 20),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(_.notification[index].date!
                                                      .toLocal()
                                                      .toString()
                                                      .split(" ")[0])
                                                  .subTitle(
                                                      fontSize: 10,
                                                      color: AppColor.text),
                                              CW.AppSpacer(h: 8),
                                              Text(_.notification[index].date!
                                                      .toLocal()
                                                      .toString()
                                                      .split(" ")[1]
                                                      .split(".")[0])
                                                  .subTitle(
                                                      fontSize: 10,
                                                      color: AppColor.text),
                                              CW.AppSpacer(h: 4),
                                            ],
                                          )
                                        ],
                                      ),
                                      const Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Visibility(
                                            visible:
                                                _.notification[index].isRead! ==
                                                    false,
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 4.0),
                                              child: Icon(
                                                Icons.circle,
                                                color: AppColor.red,
                                                size: 10,
                                              ),
                                            ),
                                          ),
                                          Text(_.isOpened.value &&
                                                      _.currentOpened == index
                                                  ? "> Hide <"
                                                  : "< View >")
                                              .subTitle(fontSize: 10)
                                              .align(Al.right),
                                        ],
                                      ),
                                      Visibility(
                                        visible: _.isOpened.value &&
                                            _.currentOpened == index,
                                        child: SlideInUp(
                                          child: Column(
                                            children: [
                                              _.notification[index].image !=
                                                      null
                                                  ? CachedNetworkImage(
                                                      imageUrl: _
                                                          .notification[index]
                                                          .image!)
                                                  : const SizedBox(),
                                              CW.AppSpacer(h: 6),
                                              Text(_.notification[index].body!)
                                                  .subTitle(
                                                      fontSize: 10,
                                                      lines: 100,
                                                      color: AppColor.text),
                                              Visibility(
                                                  visible: _.notification[index]
                                                      .hasAction!,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      const Text("click here")
                                                          .subTitle(
                                                              fontSize: 10),
                                                      const Icon(Icons
                                                          .arrow_right_alt_rounded),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: const Text(
                                                                "Accept")
                                                            .title(fontSize: 12)
                                                            .toButton(
                                                                onTap: () {}),
                                                      ),
                                                    ],
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ).toButton(onTap: () => _.openSelected(index)),
                              CW.AppSpacer(h: 20),
                            ],
                          )),
                ),
              ],
            )
          ]),
        );
      },
    );
  }
}
