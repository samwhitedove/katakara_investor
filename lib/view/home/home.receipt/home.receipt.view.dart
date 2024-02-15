import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.listview.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/models/receipt/model.fetch.reponse.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/home/home.dart';
import 'package:katakara_investor/view/home/home.receipt/home.receipt.create.dart';

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({super.key});

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReceiptController>(
      init: ReceiptController(),
      initState: (_) {},
      builder: (_) {
        return CW.baseStackWidget(
          isLoading: _.isLoading,
          appBar: PreferredSize(
              preferredSize: Size(double.infinity, HC.spaceVertical(100)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CW.AppSpacer(h: 60),
                    _.isLoading
                        ? const SizedBox()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CW.backButton(),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => Get.toNamed(
                                      RouteName.userReceiptSearch.name,
                                      arguments: Get.arguments,
                                    ),
                                    child: const Icon(Icons.search),
                                  ),
                                  PopupMenuButton<String>(
                                    icon: const Icon(Icons.sort),
                                    onSelected: _.changeUserType,
                                    itemBuilder: (BuildContext context) {
                                      return <PopupMenuEntry<String>>[
                                        ...List.generate(
                                          receiptType.length,
                                          (index) => PopupMenuItem<String>(
                                            textStyle: const TextStyle(
                                                fontSize: 12,
                                                color: AppColor.text),
                                            value: receiptType[index],
                                            child: Row(
                                              children: [
                                                Text(receiptType[index]),
                                                _.selected == index
                                                    ? const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8.0),
                                                        child: CircleAvatar(
                                                          radius: 3,
                                                          backgroundColor:
                                                              AppColor.primary,
                                                        ),
                                                      )
                                                    : const SizedBox()
                                              ],
                                            ),
                                          ),
                                        )
                                      ];
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                  ],
                ),
              )),
          // scroll: const NeverScrollableScrollPhysics(),
          floatingActionButton: _.fetchedReceipt!.isNotEmpty
              ? CW
                  .button(
                      onPress: () => Get.to(() => const CreateReceiptView()),
                      text: "Create Receipt",
                      child: Row(
                        children: [
                          const Icon(Icons.add),
                          CW.AppSpacer(w: 6),
                          const Text("Create Receipt")
                        ],
                      ))
                  .halfWidth()
              : null,
          side: 15,
          children: [
            RefreshIndicator(
              onRefresh: () async {
                await _.fetchReceipt();
                return Future(() => null);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: _.fetchedReceipt!.isEmpty,
                    child: Center(
                      child: SizedBox(
                        height: Get.height * .8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: AppColor.primaryLight,
                              child: Image.asset(Assets.assetsImagesReciept,
                                  scale: 5),
                            ),
                            CW.AppSpacer(h: 65),
                            const Text(tCreateAReceipt).title(),
                            CW.AppSpacer(h: 8),
                            const Text(tSendProffessinal).subTitle(),
                            CW.AppSpacer(h: 46),
                            CW.button(
                              onPress: () =>
                                  Get.toNamed(RouteName.createReceipt.name),
                              text: tCreateReceipt,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.add),
                                  const Text(tCreateReceipt).subTitle(
                                    color: AppColor.white,
                                  )
                                ],
                              ),
                            ),
                            CW.AppSpacer(h: 8),
                            // Visibility(
                            //   visible: _.isLoading,
                            //   child: Column(
                            //     children: [
                            //       const Text("Fetching Receipt").subTitle(),
                            //       CW.AppSpacer(h: 8),
                            //       SizedBox(
                            //         width: HC.spaceHorizontal(100),
                            //         child: const LinearProgressIndicator(),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            CW.AppSpacer(h: 46),
                          ],
                        ),
                      ),
                    ),
                  ),
                  CustomListViewWithFetchMore(
                      pagination: _.pagination,
                      count: _.fetchedReceipt!.length,
                      getMoreReceipt: _.getMoreReceipt,
                      fetchingMore: _.fetchingMore,
                      fetchedata: _.fetchedReceipt!,
                      handleStatusView: HC.handleStatusView,
                      previewData: _.viewReceipt,
                      child: recieptChildDataView)

                  // Visibility(
                  //   visible: _.fetchedReceipt!.isNotEmpty,
                  //   child: ListView.builder(
                  //     controller: _scrollController,
                  //     shrinkWrap: true,
                  //     itemCount: _.fetchedReceipt!.length,
                  //     itemBuilder: (context, index) => RefreshIndicator(
                  //       onRefresh: () async {
                  //         await _.fetchReceipt();
                  //         return Future(() => null);
                  //       },
                  //       child: Column(
                  //         children: [
                  //           Card(
                  //             margin: const EdgeInsets.symmetric(vertical: 4),
                  //             child: Padding(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: Column(
                  //                 children: [
                  //                   Row(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.spaceBetween,
                  //                     children: [
                  //                       Text(_.fetchedReceipt![index]
                  //                               .receiptCode!)
                  //                           .title(fontSize: 12),
                  //                       Container(
                  //                         constraints: BoxConstraints(
                  //                             minWidth: Get.width * .4),
                  //                         child: Text(_.fetchedReceipt![index]
                  //                                 .customerName!)
                  //                             .title(
                  //                                 lines: 1,
                  //                                 fontSize: 12,
                  //                                 color: AppColor.black)
                  //                             .align(Al.right),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                   Row(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.spaceBetween,
                  //                     children: [
                  //                       Text("Created on ${_.fetchedReceipt![index].createdAt!.toString().split(" ")[0]}")
                  //                           .subTitle(fontSize: 10),
                  //                       Padding(
                  //                         padding: const EdgeInsets.symmetric(
                  //                             vertical: 4.0),
                  //                         child: Text(
                  //                                 '$tNaira ${_.fetchedReceipt![index].totalAmount!.formatMoney}')
                  //                             .subTitle(fontSize: 10),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                   Row(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.spaceBetween,
                  //                     children: [
                  //                       const Text("Status")
                  //                           .subTitle(fontSize: 10),
                  //                       Padding(
                  //                         padding: const EdgeInsets.symmetric(
                  //                             vertical: 4.0),
                  //                         child: Text(_.fetchedReceipt![index]
                  //                                 .status!)
                  //                             .subTitle(
                  //                                 fontSize: 10,
                  //                                 color: _.  (_
                  //                                     .fetchedReceipt![index]
                  //                                     .status!)),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ).toButton(onTap: () => _.viewReceipt(index)),
                  //           LoadMore(
                  //               onTap: _.getMoreReceipt,
                  //               hasNextPage: _.pagination!.nextPage != null,
                  //               isLoading: _.fetchingMore,
                  //               showAtBottom:
                  //                   _.fetchedReceipt!.length - 1 == index)
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

recieptChildDataView(int index, List<FetchedReceipt> fetchedReceipt,
    Function(String) handleStatusView, Function(int) viewReceipt) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 4),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(fetchedReceipt[index].receiptCode!).title(fontSize: 12),
              Container(
                constraints: BoxConstraints(minWidth: Get.width * .4),
                child: SelectableText(
                  fetchedReceipt[index].customerName!,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    overflow: TextOverflow.ellipsis,
                    color: AppColor.black,
                  ),
                )
                    // .title(lines: 1, fontSize: 12, color: AppColor.black)
                    .align(Al.right),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Created on ${fetchedReceipt[index].createdAt.toString().split(" ")[0]}")
                  .subTitle(fontSize: 10),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                        '$tNaira ${fetchedReceipt[index].totalAmount!.formatMoney}')
                    .subTitle(fontSize: 10),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Status").subTitle(fontSize: 10),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(fetchedReceipt[index].status!).subTitle(
                    fontSize: 10,
                    color: handleStatusView(fetchedReceipt[index].status!)),
              ),
            ],
          ),
        ],
      ),
    ),
  ).toButton(onTap: () => viewReceipt(index));
}
