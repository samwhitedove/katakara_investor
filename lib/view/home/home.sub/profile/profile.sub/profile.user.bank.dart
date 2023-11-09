import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/customs.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/home/home.dart';

class UserBanksDetails extends StatelessWidget {
  const UserBanksDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<ProfileController>(
      initState: (_) {},
      builder: (_) => CW.baseStackWidget(
        isLoading: _.isSavingBankDetails.value,
        side: 15,
        children: [
          CW.AppSpacer(h: 70),
          CW.backButton(onTap: Get.back),
          CW.AppSpacer(h: 20),
          const Text(tBankDetails).title(),
          CW.AppSpacer(h: 30),
          CW.dropdownString(
            // dropDownWidth: .8,
            decoration: BoxDecoration(
                border: Border.all(color: AppColor.grey),
                borderRadius: BorderRadius.circular(8)),
            data: banks..sort(),
            label: tBankName,
            onChange: (value) => _.changeBankName(value),
            value: _.bankName,
          ),
          CW.AppSpacer(h: 10),
          CW.textField(
              label: tAccountName,
              controller: _.accountName,
              onChangeValue: () {}),
          CW.AppSpacer(h: 10),
          CW.textField(
              maxLength: 10,
              inputType: TextInputType.number,
              label: tAccountNumber,
              controller: _.accountNumber,
              onChangeValue: () {}),
          CW.AppSpacer(h: 30),
          CW.button(onPress: _.updateBankDetails, text: tSave)
        ],
      ),
    ));
  }
}
