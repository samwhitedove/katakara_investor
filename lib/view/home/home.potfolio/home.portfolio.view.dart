import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/home/home.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PortfolioController>(
      init: PortfolioController(),
      initState: (_) {},
      builder: (_) {
        return CW.baseStackWidget(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  color: AppColor.primary,
                  width: Get.width,
                  height: HC.spaceHorizontal(218),
                  child: CW.column(
                    children: [
                      CW.AppSpacer(h: 70),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CW.backButton(
                              innerBgColor: AppColor.primary,
                              iconColor: AppColor.white,
                              outerBgColor: AppColor.white,
                              bgVisible: 1),
                          Text(tPortfolio).title(
                            color: AppColor.white,
                          ),
                          SizedBox(
                            width: 25,
                          ),
                        ],
                      ),
                      CW.AppSpacer(h: 30),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(tBusinessName)
                              .title(fontSize: 20, color: AppColor.white),
                          Text(tSendReceipt).subTitle(
                            color: AppColor.white.withOpacity(.7),
                          ),
                        ],
                      ).align(Al.center),
                    ],
                  ),
                ),
                Positioned(
                  bottom: -25,
                  left: 0,
                  right: 0,
                  child: CW.column(
                    children: [
                      Container(
                        height: 60,
                        color: AppColor.white,
                        width: Get.width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Text("03").title(fontSize: 13, color: AppColor.text,),
                              Text(tActiveProduct).subTitle(fontSize: 12, color: AppColor.grey,),
                            ],),
                            Column(
                               crossAxisAlignment: CrossAxisAlignment.end,children: [
                              Text("03").title(fontSize: 13, color: AppColor.text,),
                              Text(tPending).subTitle(fontSize: 12, color: AppColor.grey,),
                            ],),
                          ],
                        ).paddingSymmetric(horizontal: 15, vertical: 5)
                      ).roundCorner(
                        showShadow: true,
                       borderColor: AppColor.white,
                       blurRadius: 1
                      )
                    ],
                  ),
                ),
              ],
            ),
            CW.AppSpacer(h: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(_.productStatus.length, (index) => 
              Text(_.productStatus[index])
                .subTitle(color: _.currentViewIndex == index ? AppColor.white : AppColor.primary).align(Al.center)
                .toButton(onTap: ()=> _.changeStatus(index))
                .roundCorner(
                  bgColor:_.currentViewIndex == index ? AppColor.primary : AppColor.primaryLight,
                  radius: 30,
                  showShadow: false, showBorder: false,height: 30,
                  width: HC.spaceHorizontal(70),
                  padding: EdgeInsets.symmetric( horizontal: 10),),),)
                .marginSymmetric(horizontal: HC.spaceHorizontal(63),),
             CW.AppSpacer(h: 15),
            Container(
              height: Get.height * .63,
              child: Expanded(
                child: PageView(
                  controller: _.pageController,
                  onPageChanged: (value) => _.changeStatus(value),
                  children: List.generate(_.productStatus.length, (index) => Wrap(children: List.generate(3, (index) => Container(
                    
                    width: HC.spaceHorizontal(104),
                    margin: EdgeInsets.all(3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Container(decoration: BoxDecoration(
                        image: DecorationImage
                        (image: CachedNetworkImageProvider(userData.profileImageUrl!,),fit: BoxFit.cover
                        ),
                      ),
                      height: HC.spaceVertical(70)
                      ),
                      Text("testing dummy content").subTitle(fontSize: 10),
                      Text(tNaira + "200,000").title(fontSize: 12,color: AppColor.text),
                    ],)
                  )//,
                  ),
                  ).marginSymmetric(horizontal: 15),
                  )
                ),
              ),
            )
          ],
        );
      },
    );
  }

}
