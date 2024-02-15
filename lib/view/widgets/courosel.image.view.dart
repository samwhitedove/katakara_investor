import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/helper/helper.function.dart';
import 'package:katakara_investor/values/colors.dart';

import '../../values/strings.dart';

class CouroselImageView extends StatefulWidget {
  List<String> productImage;
  Function()? onTap;
  String sku;
  CouroselImageView({
    super.key,
    required this.productImage,
    this.onTap,
    required this.sku,
  });

  @override
  State<CouroselImageView> createState() => _CouroselImageViewState();
}

class _CouroselImageViewState extends State<CouroselImageView> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    time?.cancel();
    pageController.dispose();
    super.dispose();
  }

  PageController pageController = PageController();

  Timer? time;

  bool isGoingBack = false;
  RxInt currentImageView = 0.obs;

  startTimer() {
    if (time != null) return;
    final imageLenght = widget.productImage.length;
    if (imageLenght <= 1) return;
    time = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (isGoingBack) isGoingBack = currentImageView.value == 0 ? false : true;
      if (!isGoingBack) {
        isGoingBack = (currentImageView.value + 1) == imageLenght;
      }
      if (isGoingBack) {
        currentImageView.value -= 1;
        pageController.animateToPage(currentImageView.value,
            duration: CW.onesSec, curve: Curves.easeInOut);
      } else {
        currentImageView.value += 1;
        pageController.nextPage(duration: CW.onesSec, curve: Curves.easeInOut);
      }
    });
  }

  changeView(value) {
    currentImageView.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: HC.spaceVertical(312),
      child: Column(
        children: [
          SizedBox(
            height: HC.spaceVertical(280),
            child: Hero(
                tag: widget.sku,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: widget.productImage.length,
                  onPageChanged: changeView,
                  physics: const BouncingScrollPhysics(),
                  allowImplicitScrolling: true,
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          widget.productImage[index].toString(),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: HC.spaceVertical(312),
                    width: HC.spaceHorizontal(380),
                  ).toButton(
                      onTap: () =>
                          Get.toNamed(RouteName.fullImageView.name, arguments: {
                            'tag': widget.sku,
                            'image': widget.productImage[currentImageView.value]
                          })),
                )),
          ),
          CW.AppSpacer(h: 10),
          CW.PageDot(
            count: widget.productImage.length,
            current: currentImageView,
            activeColor: AppColor.grey,
            inactiveColor: AppColor.greyLigth,
          )
        ],
      ),
    );
  }
}
