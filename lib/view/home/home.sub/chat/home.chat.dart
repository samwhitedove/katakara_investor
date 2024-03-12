import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.no.data.dart';
import 'package:katakara_investor/customs/customs.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/home/home.dart';

import 'model.chat.dart';

class InboxPageScreen extends StatelessWidget {
  final HomeScreenController ctr;
  const InboxPageScreen({super.key, required this.ctr});
  final bool show = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CW.column(
          children: [
            CW.AppSpacer(h: 40),
            const Text("Chat").title(fontSize: 28),
            CW.AppSpacer(h: 20),
            SizedBox(
                height: Get.height * .8,
                child: StreamBuilder(
                  stream: ctr.chatListController.stream,
                  builder: (context, snapshot) {
                    print(snapshot.connectionState);
                    if (snapshot.hasData) {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) => CW.chatTile(
                          profileImage: snapshot.data![index].profileImage,
                          name: snapshot.data![index].senderName,
                          date: DateTime.now().toUtc().toIso8601String(),
                          latestMessage: snapshot.data![index].lastMessage,
                          status: true,
                          totalUnread: snapshot.data![index].totalUnread,
                          senderUuid: snapshot.data![index].senderUuid,
                          onTap: () => Get.toNamed(RouteName.chatScreen.name,
                              arguments: snapshot.data![index].toJson()),
                        ),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      return CircularProgressIndicator();
                    }

                    return NoDataFound();
                  },
                ))
          ],
        ),
      ),
    );
  }
}
