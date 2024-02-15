import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/extensions/extensions.dart';

import '../helper/helper.function.dart';
import '../values/colors.dart';
import '../values/strings.dart';
import 'custom.widget.dart';

class LoadMore extends StatelessWidget {
  bool hasNextPage;
  bool showAtBottom;
  RxBool isLoading;
  Function() onTap;
  LoadMore(
      {super.key,
      required this.onTap,
      required this.hasNextPage,
      required this.isLoading,
      required this.showAtBottom});

  @override
  Widget build(BuildContext context) {
    return hasNextPage && showAtBottom
        ? Column(
            children: [
              CW.AppSpacer(h: 10),
              Obx(
                () => !isLoading.value
                    ? SizedBox(
                        width: HC.spaceHorizontal(150),
                        child: CW.button(
                          onPress: onTap,
                          text: "",
                          color: AppColor.white,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.touch_app,
                                color: AppColor.grey,
                              ),
                              CW.AppSpacer(w: 10),
                              const Text("Load More")
                                  .title(fontSize: 12, color: AppColor.grey)
                                  .align(Al.left),
                            ],
                          ),
                        ),
                      ).align(Al.left)
                    : const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                        ),
                      ).align(Al.left),
              ),
              CW.AppSpacer(h: 30),
            ],
          )
        : const SizedBox();
  }
}
