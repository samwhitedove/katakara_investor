import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/home/home.dart';
import 'package:katakara_investor/view/home/home.receipt/home.receipt.create.dart';

class ReceiptScreen extends StatelessWidget {
  const ReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReceiptController>(
      init: ReceiptController(),
      initState: (_) {},
      builder: (_) {
        return CW.baseStackWidget(
          floatingActionButton: _.fetchedReceipt!.isNotEmpty
              ? CW
                  .button(
                      onPress: () => Get.to(() => const CreateReceiptView()),
                      text: "Create Receipt",
                      child: Row(
                        children: [
                          const Icon(Icons.add),
                          CW.AppSpacer(w: 10),
                          const Text("Create Receipt")
                        ],
                      ))
                  .halfWidth()
                  .simpleRoundCorner(width: 180, height: 60)
              : null,
          side: 15,
          children: [
            RefreshIndicator(
              onRefresh: () async {
                await _.fetchReceipt();
                return true as Future;
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CW.AppSpacer(h: 60),
                  CW.backButton(),
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
                            Visibility(
                              visible: _.isLoading,
                              child: Column(
                                children: [
                                  const Text("Fetching Receipt").subTitle(),
                                  CW.AppSpacer(h: 8),
                                  SizedBox(
                                    width: HC.spaceHorizontal(100),
                                    child: const LinearProgressIndicator(),
                                  ),
                                ],
                              ),
                            ),
                            CW.AppSpacer(h: 46),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _.fetchedReceipt!.isNotEmpty,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _.fetchedReceipt!.length,
                      itemBuilder: (context, index) => Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(_.fetchedReceipt![index].receiptCode!)
                                      .title(fontSize: 12),
                                  Container(
                                    constraints: BoxConstraints(
                                        minWidth: Get.width * .4),
                                    child: Text(_.fetchedReceipt![index]
                                            .customerName!)
                                        .title(
                                            lines: 1,
                                            fontSize: 12,
                                            color: AppColor.black)
                                        .align(Al.right),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Created on ${_.fetchedReceipt![index].createdAt!.toString().split(" ")[0]}")
                                      .subTitle(fontSize: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Text(
                                            '$tNaira ${_.fetchedReceipt![index].totalAmount!.formatMoney}')
                                        .subTitle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ).toButton(onTap: () => _.viewReceipt(index)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
