import 'package:flutter/material.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class ProductTypeCategoryLoadingState extends StatelessWidget {
  const ProductTypeCategoryLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(
              6,
              (index) => Container(
                height: HC.spaceHorizontal(148),
                width: HC.spaceVertical(130),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColor.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: .1,
                      spreadRadius: 3,
                      color: AppColor.greyLigth.withAlpha(10),
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: AppColor.grey,
                      highlightColor: AppColor.inActiveBlack,
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
                          image: DecorationImage(
                            image: AssetImage(Assets.assetsImagesLoading),
                            scale: 4,
                          ),
                        ),
                        height: HC.spaceVertical(100),
                      ),
                    ),
                    CW.AppSpacer(h: 7),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Shimmer.fromColors(
                        baseColor: AppColor.grey,
                        highlightColor: AppColor.inActiveBlack,
                        child: Container(
                          color: AppColor.grey,
                          width: HC.spaceHorizontal(100),
                          height: 5,
                        ),
                      ),
                    ),
                    CW.AppSpacer(h: 7),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Shimmer.fromColors(
                        baseColor: AppColor.grey,
                        highlightColor: AppColor.inActiveBlack,
                        child: Container(
                          color: AppColor.grey,
                          width: HC.spaceHorizontal(80),
                          height: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
