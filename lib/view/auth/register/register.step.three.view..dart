import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/customs.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/services/service.http.dart';
import 'package:katakara_investor/values/values.dart';

import 'regiser.controller.dart';

Column stepThree(RegisterScreenController _) {
  return Column(
    children: [
      CW.AppSpacer(h: 16),
      CW.textField(
          label: tFullAddress,
          controller: _.fullAddress!,
          lines: 4,
          maxLength: 150,
          inputType: TextInputType.multiline,
          onChangeValue: () => _.stepChecker('step3')),
      CW.AppSpacer(h: 10),
      CW.dropdownString(
        dropDownWidth: .8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: AppColor.grey,
          ),
        ),
        label: tGovernmentId,
        value: _.selectedId.value,
        onChange: (text) {
          _.selectedId.value = text;
          _.stepChecker('step3');
        },
        data: governmentIds,
      ),
      CW.AppSpacer(h: 24),
      Obx(
        () => CW
            .imageUploaderContainer(
              label: tUploadGovernmentId,
              hasUpload: _.govermentImageUrl.value.isNotEmpty,
              imageUrl: _.govermentImageUrl.value,
              isUploading: _.isUploadingGovImage.value,
              onRemovePressed: () => _.deleteUploadedImage(
                  _.govermentImageUrl.value, IdType.government),
              uploadProgress: _.uploadProgress.value,
            )
            .toButton(
              onTap: _.govermentImageUrl.value.isNotEmpty ||
                      _.isUploadingGovImage.value
                  ? null
                  : () => _.uploadImage(
                        type: UploadType.Document,
                        idType: IdType.government,
                        controller: _,
                      ),
            ),
      ),
      CW.AppSpacer(h: 14),
      Obx(
        () => CW
            .imageUploaderContainer(
              label: tUploadCAC,
              hasUpload: _.cacImageUrl.value.isNotEmpty,
              imageUrl: _.cacImageUrl.value,
              isUploading: _.isUploadingCacImage.value,
              onRemovePressed: () =>
                  _.deleteUploadedImage(_.cacImageUrl.value, IdType.cac),
              uploadProgress: _.uploadProgress.value,
            )
            .toButton(
              onTap:
                  _.cacImageUrl.value.isNotEmpty || _.isUploadingCacImage.value
                      ? null
                      : () => _.uploadImage(
                            type: UploadType.Document,
                            idType: IdType.cac,
                            controller: _,
                          ),
            ),
      ),
      CW.AppSpacer(h: 14),
      Obx(
        () => CW
            .imageUploaderContainer(
              label: tUploadLetter,
              hasUpload: _.letterHeadUrl.value.isNotEmpty,
              imageUrl: _.letterHeadUrl.value,
              isUploading: _.isUploadingLetterImage.value,
              onRemovePressed: () => _.deleteUploadedImage(
                  _.letterHeadUrl.value, IdType.letterHeaded),
              uploadProgress: _.uploadProgress.value,
            )
            .toButton(
              onTap: _.letterHeadUrl.value.isNotEmpty ||
                      _.isUploadingLetterImage.value
                  ? null
                  : () => _.uploadImage(
                        type: UploadType.Document,
                        idType: IdType.letterHeaded,
                        controller: _,
                      ),
            ),
      ),
      // CW
      //     .imageUploaderContainer(
      //         label: tUploadGovernmentId,
      //         isUploading: false,
      //         onRemovePressed: () {},
      //         uploadProgress: .2)
      //     .toButton(
      //         onTap: () => _.uploadImage(
      //               type: UploadType.Document,
      //               idType: IdType.government,
      //               controller: _,
      //             )),
      // CW.AppSpacer(h: 14),
      // CW
      //     .imageUploaderContainer(
      //         label: tUploadCAC,
      //         isUploading: false,
      //         onRemovePressed: () {},
      //         uploadProgress: .2)
      //     .toButton(
      //         onTap: () => _.uploadImage(
      //             type: UploadType.Document,
      //             idType: IdType.cac,
      //             controller: _)),
      // CW.AppSpacer(h: 14),
      // CW
      //     .imageUploaderContainer(
      //         label: tUploadLetter,
      //         isUploading: false,
      //         onRemovePressed: () {},
      //         uploadProgress: .2)
      //     .toButton(
      //         onTap: _.isUploadingImage.value
      //             ? null
      //             : () => _.uploadImage(
      //                 type: UploadType.Document,
      //                 idType: IdType.letterHeaded,
      //                 controller: _)),
    ],
  );
}
