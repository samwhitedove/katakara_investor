import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/home/home.dart';

class HomeKFIController extends GetxController {
  List<String> fkis = [tNearMe, tRecommended, tNewest];
  RxInt currentKfi = 1.obs;
  RxBool isLoading = false.obs;
  HomeScreenController? homeScreenController;

  List<Map<String, dynamic>> fkiData = [
    {
      'name': "Emeka Emaku Alios",
      'state': 'Abuja',
      'lga': "Gwaladwa",
      'workDays': ['Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun']
    },
    {
      'name': "Emeka Emaku Alios",
      'state': 'Abuja',
      'lga': "Gwaladwa",
      'workDays': ['Mon', 'Sun']
    },
    {
      'name': "Emeka Emaku Alios",
      'state': 'Abuja',
      'lga': "Gwaladwa",
      'workDays': ['Mon', 'Tue', 'Wed', 'Thur', 'Sun']
    },
    {
      'name': "Emeka Emaku Alios",
      'state': 'Abuja',
      'lga': "Gwaladwa",
      'workDays': ['Mon', 'Tue', 'Wed', 'Thur', 'Fri']
    },
    {
      'name': "Emeka Emaku Alios",
      'state': 'Abuja',
      'lga': "Gwaladwa",
      'workDays': ['Thur', 'Fri', 'Sat', 'Sun']
    }
  ];

  findKFI(int value) async {
    homeScreenController!.isLoading.value = true;
    isLoading.value = true;
    await Future.delayed(CW.onesSec);
    currentKfi.value = value;
    isLoading.value = false;
    homeScreenController!.isLoading.value = false;
  }
}
