import 'package:flutter/material.dart';
import 'package:katakara_investor/customs/customs.dart';

import '../../../values/values.dart';
import 'register.dart';

Column stepTwo(RegisterScreenController _) {
  return Column(
    children: [
      CW.dropdownString(
        dropDownWidth: .8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: AppColor.grey,
          ),
        ),
        label: tBankName,
        value: _.selectedBank.value,
        onChange: (text) {
          _.selectedBank.value = text;
          _.stepChecker('step2');
        },
        data: banks..sort(),
      ),
      CW.AppSpacer(h: 16),
      CW.textField(
          label: tAccountNumber,
          maxLength: 10,
          fieldName: tNumber,
          inputType: TextInputType.number,
          controller: _.accountNumber!,
          onChangeValue: () => _.stepChecker('step2')),
      CW.AppSpacer(h: 16),
      CW.textField(
          label: tAccountName,
          controller: _.accountName!,
          onChangeValue: () => _.stepChecker('step2')),
      CW.AppSpacer(h: 16),
      CW.dropdownString(
        dropDownWidth: .8,
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
        dropDownWidth: .8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: AppColor.grey,
          ),
        ),
        label: tOwnVehicle,
        value: _.ownVehicle.value,
        onChange: (text) {
          _.ownVehicle.value = text;
        },
        data: yesVehicle,
      ),
    ],
  );
}
