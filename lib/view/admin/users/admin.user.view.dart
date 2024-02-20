import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.listview.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/models/admin/model.fetch.user.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/admin/users/admin.user.controller.dart';
import 'package:katakara_investor/view/view.dart';
import 'package:katakara_investor/view/widgets/popup.menu.dart';

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
                                '${_.fetchedUser?.length}/${_.pagination?.total}',
                              ).title(
                                fontSize: 16,
                                color: AppColor.white,
                              ),
                            ),
                          ),
                        ),
                  _.isFetchingAllUser.value
                      ? const SizedBox()
                      : CustomPopUpMenu(
                          data: _.userListType,
                          onChange: _.changeUserType,
                          selected: _.selected)

                  // PopupMenuButton<String>(
                  //     icon: const Icon(Icons.sort),
                  //     onSelected: _.changeUserType,
                  //     itemBuilder: (BuildContext context) {
                  //       return <PopupMenuEntry<String>>[
                  //         ...List.generate(
                  //           _.userListType.length,
                  //           (index) => PopupMenuItem<String>(
                  //             textStyle: const TextStyle(
                  //                 fontSize: 12, color: AppColor.text),
                  //             value: _.userListType[index],
                  //             child: Row(
                  //               children: [
                  //                 Text(_.userListType[index]),
                  //                 _.selected == index
                  //                     ? const Padding(
                  //                         padding:
                  //                             EdgeInsets.only(left: 8.0),
                  //                         child: CircleAvatar(
                  //                           radius: 3,
                  //                           backgroundColor:
                  //                               AppColor.primary,
                  //                         ),
                  //                       )
                  //                     : const SizedBox()
                  //               ],
                  //             ),
                  //           ),
                  //         )
                  //       ];
                  //     },
                  //   ),
                ],
              ),
              body: Stack(
                children: [
                  Visibility(
                    visible: !_.isFetchingAllUser.value,
                    child: Column(
                      children: [
                        Expanded(
                          child: _.fetchedUser!.isEmpty
                              ? Center(
                                  child: NoDataScreen(
                                    oncall: () {},
                                    message: "No user found",
                                  ),
                                )
                              : CustomListViewWithFetchMore(
                                  child: UserView,
                                  pagination: _.pagination,
                                  count: _.fetchedUser!.length,
                                  getMoreUser: _.fetchMoreData,
                                  fetchingMore: _.isFetchingMoreUser,
                                  type: _.pageType,
                                  fetchedata: _.fetchedUser!),
                          // : ListView.builder(
                          //     itemCount: _.fetchedUser!.length,
                          // itemBuilder: (context, index) =>  _
                          //             .fetchedUser![index].id ==
                          //         userData.id
                          //     ? const SizedBox()
                          //         : UserOverviewListTile(
                          //             fullName:
                          //                 _.fetchedUser![index].fullName!,
                          //             phone: _
                          //                 .fetchedUser![index].phoneNumber!,
                          //             lga: _.fetchedUser![index].lga!,
                          //             state: _.fetchedUser![index].state!,
                          //             image: _.fetchedUser![index]
                          //                 .profileImageUrl,
                          //             onTap: () => Get.toNamed(
                          //               RouteName.viewInformationCard.name,
                          //               arguments: _.fetchedUser![index],
                          //             ),
                          //           ),
                          //   ),
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

Widget UserView(int index, List<FetchedUser> fetchedUser,
    Function(String) handleStatusView, Function(int) viewReceipt) {
  return fetchedUser[index].id == userData.id
      ? const SizedBox()
      : UserOverviewListTile(
          fullName: fetchedUser[index].fullName!,
          phone: fetchedUser[index].phoneNumber!,
          lga: fetchedUser[index].lga!,
          state: fetchedUser[index].state!,
          image: fetchedUser[index].profileImageUrl,
          onTap: () => Get.toNamed(
            RouteName.viewInformationCard.name,
            arguments: fetchedUser[index],
          ),
        );
}
