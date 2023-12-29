import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/admin/users/admin.user.controller.dart';
import 'package:katakara_investor/view/view.dart';

import '../../../customs/custom.product.type.dart';

class UserListView extends StatelessWidget {
  const UserListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(
          RouteName.search.name,
          arguments: Get.arguments,
        ),
        child: const Icon(Icons.search),
      ),
      body: GetBuilder<UserListController>(
        init: UserListController(),
        initState: (_) {},
        builder: (_) {
          return Scaffold(
              appBar: AppBar(
                title: Text(_.title!),
                actions: [
                  _.isFetchingAllUser.value
                      ? const SizedBox()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Center(
                            child: FittedBox(
                              child: Text(
                                (_.fetchedUser['pagination'].total).toString(),
                              ).title(
                                fontSize: 16,
                                color: AppColor.white,
                              ),
                            ),
                          ),
                        )
                ],
              ),
              body: Stack(
                children: [
                  Visibility(
                    visible: !_.isFetchingAllUser.value,
                    child: Column(
                      children: [
                        Expanded(
                          child: _.fetchedUser['users'].isEmpty
                              ? Center(
                                  child: NoDataScreen(
                                    oncall: () {},
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: _.fetchedUser['users'].length,
                                  itemBuilder: (context, index) => _
                                              .fetchedUser['users'][index].id ==
                                          userData.id
                                      ? const SizedBox()
                                      : UserOverviewListTile(
                                          fullName: _
                                              .fetchedUser['users'][index]
                                              .fullName,
                                          phone: _.fetchedUser['users'][index]
                                              .phoneNumber,
                                          lga:
                                              _.fetchedUser['users'][index].lga,
                                          state: _.fetchedUser['users'][index]
                                              .state,
                                          image: _.fetchedUser['users'][index]
                                              .profileImageUrl,
                                          onTap: () => Get.toNamed(
                                            RouteName.viewInformationCard.name,
                                            arguments: _.fetchedUser['users']
                                                [index],
                                          ),
                                        ),
                                ),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _.isFetchingAllUser.value,
                    child: const SafeArea(
                      child: SizedBox(
                        height: 5,
                        child: LinearProgressIndicator(),
                      ),
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}
