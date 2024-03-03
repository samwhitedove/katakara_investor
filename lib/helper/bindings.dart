import 'dart:developer';

import 'package:get/get.dart';
import 'package:katakara_investor/services/service.receipt.dart';
import 'package:katakara_investor/services/services.auth.dart';
import 'package:katakara_investor/services/services.home.dart';
import 'package:katakara_investor/services/service.profile.dart';
import 'package:katakara_investor/services/services.portfolio.dart';
import 'package:katakara_investor/view/admin/product/user.products.controller.dart';
import 'package:katakara_investor/view/home/home.notification/home.notification.controller.dart';

class AllBindings implements Bindings {
  @override
  void dependencies() {
    log("initalizing all services bindings...");
    Get.put<AuthService>(AuthService(), permanent: true);
    Get.put<HomeService>(HomeService(), permanent: true);
    Get.put<ProfileService>(ProfileService(), permanent: true);
    Get.put<PortfolioService>(PortfolioService(), permanent: true);
    Get.put<ReceiptService>(ReceiptService(), permanent: true);
    Get.put<UserProductsController>(UserProductsController(), permanent: true);
    Get.put<AppNotificationController>(AppNotificationController(),
        permanent: true);
  }
}
