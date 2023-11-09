import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/admin/users/admin.user.controller.dart';

class UserListView extends StatelessWidget {
  const UserListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserListController>(
      init: UserListController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
            appBar: AppBar(
              title: Text(_.setTitle()),
            ),
            body: Column(
              children: [
                ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    onTap: () => {},
                    leading: SizedBox(
                      height: HC.spaceVertical(50),
                      width: HC.spaceVertical(50),
                      child: Image.asset(Assets.assetsImagesImage),
                    ),
                    title: const Text('User Name').title(fontSize: 14),
                    subtitle: const Text("074673673434 * Ikeja * Lagos State")
                        .subTitle(fontSize: 10),
                  ),
                )
              ],
            ));
      },
    );
  }
}
