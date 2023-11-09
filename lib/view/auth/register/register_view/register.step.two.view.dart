import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/customs.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/auth/register/register_controller/stepTwo.controller.dart';

class StepTwo extends StatelessWidget {
  StepTwo({super.key});
  final k = Get.put(StepTwoController);
  final _twoController = Get.find<StepTwoController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StepTwoController>(
      init: _twoController,
      // tag: "two",
      builder: (_) {
        return Column(
          children: [
            CW.dropdownString(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: AppColor.grey,
                ),
              ),
              label: tBankName,
              value: _.selectedBank.value,
              onChange: _.setBankName,
              data: banks..sort(),
            ),
            CW.AppSpacer(h: 16),
            CW.textField(
                label: tAccountNumber,
                maxLength: 10,
                fieldName: tNumber,
                inputType: TextInputType.number,
                controller: _.accountNumber,
                onChangeValue: () => _.stepTwoChecker()),
            CW.AppSpacer(h: 16),
            CW.textField(
                label: tAccountName,
                controller: _.accountName,
                onChangeValue: () => _.stepTwoChecker()),
            CW.AppSpacer(h: 16),
            CW.textField(
                label: tFullAddress,
                controller: _.fullAddress,
                lines: 4,
                maxLength: 150,
                inputType: TextInputType.multiline,
                onChangeValue: () {}),
            CW.AppSpacer(h: 16),
            CW.dropdownString(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: AppColor.grey,
                ),
              ),
              label: tFinaceCapacity,
              value: _.financialCapacity.value,
              onChange: (text) {
                _.financialCapacity.value = text;
              },
              data: finance,
            ),
            CW.AppSpacer(h: 16),
            CW.dropdownString(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: AppColor.grey,
                ),
              ),
              label: tOwnVehicle,
              value: _.ownVehicle.value,
              onChange: _.setCapital,
              data: yesVehicle,
            ),
          ],
        );
      },
    );
  }
}
