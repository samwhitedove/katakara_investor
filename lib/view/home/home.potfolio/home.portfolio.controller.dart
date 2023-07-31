import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.widget.dart';

class PortfolioController extends GetxController {

  List<String> productStatus = ["Pending", "Active", "Sold"];
  int currentViewIndex = 1;
  PageController pageController = PageController(initialPage: 1);

  void changeStatus(int index){
    currentViewIndex = index;
    pageController.animateToPage(index, duration: CW.quarterSec, curve: Curves.linear);
    update();
  }
}
