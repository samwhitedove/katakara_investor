import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/customs.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/auth/register/register_controller/stepOne.controller.dart';

class StepOne extends StatelessWidget {
  StepOne({super.key});
  final k = Get.put(StepOneController);
  final oneController = Get.find<StepOneController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CW.form(
        size: 0,
        formKey: const ValueKey('stepOneForm'),
        children: [
          Column(
            children: [
              CW.textField(
                label: tFullName,
                controller: oneController.fullName!,
                fieldName: 'Full Name',
                validate: true,
                onChangeValue: () {},
              ),
              CW.AppSpacer(h: 16),
              CW.textField(
                label: tCompanyName,
                controller: oneController.companyName!,
                onChangeValue: () {},
              ),
              CW.AppSpacer(h: 10).marginZero,
              Column(
                children: [
                  CW.dropdownString(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: AppColor.grey,
                      ),
                    ),
                    label: tState,
                    value: oneController.selectedState.value,
                    onChange: oneController.setLga,
                    data: stateAndLga.keys.toList(),
                  ),
                  CW.AppSpacer(h: 16),
                  CW.dropdownString(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: AppColor.grey,
                      ),
                    ),
                    label: tLga,
                    value: oneController.selectedLga.value,
                    onChange: oneController.setState,
                    data: stateAndLga[oneController.selectedState.value]!,
                  )
                ],
              ),
              CW.AppSpacer(h: 16),
              CW.textField(
                label: tPhone,
                maxLength: 11,
                fieldName: tNumber,
                inputType: TextInputType.number,
                controller: oneController.phoneNumber!,
                onChangeValue: () {},
              ),
              CW.AppSpacer(h: 16),
              CW.textField(
                label: tPhone2,
                fieldName: tNumber,
                maxLength: 11,
                inputType: TextInputType.number,
                controller: oneController.phoneNumber2!,
                onChangeValue: () {},
              ),
              CW.AppSpacer(h: 24),
            ],
          ),
        ],
      ),
    );
  }
}
