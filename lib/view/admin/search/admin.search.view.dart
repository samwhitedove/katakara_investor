import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.widget.dart';

import '../../../customs/custom.product.type.dart';
import '../../../values/strings.dart';
import '../../widgets/widget.user.overview.dart';
import 'admin.search.controller.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppSearchController>(
      init: AppSearchController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: Text("Search ${_.title}")),
          body: CW.column(
            scroll: const NeverScrollableScrollPhysics(),
            children: [
              CW.textField(
                label: "",
                controller: _.searchController,
                onChangeValue: () {},
                hint: "Search Name, email",
                suffix: Obx(() => Visibility(
                      visible: !_.isFetching.value,
                      child: InkWell(
                          onTap: _.searchUser, child: const Icon(Icons.search)),
                    )),
              ),
              CW.CircleLoader(show: _.isFetching),
              Obx(
                () => Visibility(
                  visible: !_.isFetching.value,
                  child: _.searchedUser['users'].isEmpty
                      ? _.hasSearch.value
                          ? Center(
                              child: NoDataScreen(
                                  oncall: () {}, message: 'No user found'),
                            )
                          : const SizedBox()
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: _.searchedUser['users'].length,
                          itemBuilder: (context, index) => _
                                      .searchedUser['users'][index].id ==
                                  userData.id
                              ? const SizedBox()
                              : UserOverviewListTile(
                                  fullName:
                                      _.searchedUser['users'][index].fullName,
                                  phone: _
                                      .searchedUser['users'][index].phoneNumber,
                                  lga: _.searchedUser['users'][index].lga,
                                  state: _.searchedUser['users'][index].state,
                                  image: _.searchedUser['users'][index]
                                      .profileImageUrl,
                                  onTap: () => Get.toNamed(
                                    RouteName.viewInformationCard.name,
                                    arguments: _.searchedUser['users'][index],
                                  ),
                                ),
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
