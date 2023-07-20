import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/customs.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/services/service.http.dart';

import '../../../values/values.dart';
import 'register.dart';

Padding stepOne(RegisterScreenController _) {
  return CW.form(
    size: 0,
    formKey: _.stepFormKey,
    children: [
      Column(
        children: [
          CW.textField(
            label: tFullName,
            controller: _.fullName!,
            fieldName: 'Full Name',
            validate: true,
            onChangeValue: () => _.stepChecker('step1'),
          ),
          CW.AppSpacer(h: 16),
          CW.textField(
            label: tCompanyName,
            controller: _.companyName!,
            onChangeValue: () => _.stepChecker('step1'),
          ),
          CW.AppSpacer(h: 16),
          Row(
            children: [
              CW
                  .dropdownString(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: AppColor.grey,
                      ),
                    ),
                    label: tState,
                    value: _.selectedState.value,
                    onChange: (text) {
                      _.selectedState.value = text;
                      _.selectedLga.value = stateAndLga[text]!.first;
                      _.stepChecker('step1');
                    },
                    data: stateAndLga.keys.toList(),
                  )
                  .halfWidth(marginRight: true, margin: 6),
              CW
                  .dropdownString(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: AppColor.grey,
                      ),
                    ),
                    label: tLga,
                    value: _.selectedLga.value,
                    onChange: (text) {
                      _.selectedLga.value = text;
                    },
                    data: stateAndLga[_.selectedState.value]!,
                  )
                  .halfWidth(),
            ],
          ),
          CW.AppSpacer(h: 16),
          Row(
            children: [
              CW
                  .textField(
                    label: tPhone,
                    maxLength: 11,
                    fieldName: tNumber,
                    inputType: TextInputType.number,
                    controller: _.phoneNumber!,
                    onChangeValue: () => _.stepChecker('step1'),
                  )
                  .halfWidth(marginRight: true, margin: 6),
              CW
                  .textField(
                    label: tPhone2,
                    fieldName: tNumber,
                    maxLength: 11,
                    inputType: TextInputType.number,
                    controller: _.phoneNumber2!,
                    onChangeValue: () {},
                  )
                  .halfWidth()
            ],
          ),
          CW.AppSpacer(h: 24),
          Obx(
            () => CW
                .imageUploaderContainer(
                  hasUpload: _.profileImageUrl.value.isNotEmpty,
                  imageUrl: _.profileImageUrl.value,
                  isUploading: _.isUploadingProfileImage.value,
                  onRemovePressed: () => _.deleteUploadedImage(
                      _.profileImageUrl.value, IdType.profleImage),
                  uploadProgress: _.uploadProgress.value,
                )
                .toButton(
                  onTap: _.profileImageUrl.value.isNotEmpty ||
                          _.isUploadingProfileImage.value
                      ? null
                      : () => _.uploadImage(
                          type: UploadType.Profile,
                          idType: IdType.profleImage,
                          controller: _),
                ),
          )
        ],
      ),
    ],
  );
}
