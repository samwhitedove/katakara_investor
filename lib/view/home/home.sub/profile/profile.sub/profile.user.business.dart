import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/customs.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/services/service.http.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/home/home.dart';

class UserBusinessDetails extends StatelessWidget {
  const UserBusinessDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProfileController>(
        initState: (_) {},
        builder: (_) {
          return CW.baseStackWidget(
            isLoading: _.isSavingCompanyDetails.value,
            side: 15,
            children: [
              CW.AppSpacer(h: 70),
              CW.backButton(onTap: Get.back),
              CW.AppSpacer(h: 20),
              Text(tBusinessDetails).title(),
              CW.AppSpacer(h: 30),
              CW.textField(
                  label: tCompanyName,
                  controller: _.company,
                  onChangeValue: () {}),
              CW.AppSpacer(h: 10),
              CW.dropdownString(
                dropDownWidth: .8,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColor.grey),
                    borderRadius: BorderRadius.circular(8)),
                data: yesVehicle,
                label: tOwnVehicle,
                onChange: (value) => _.changeHasVehicle(value),
                value: _.hasVehicle,
              ),
              CW.AppSpacer(h: 10),
              CW.textField(
                  label: tFullAddress,
                  controller: _.fullAdress,
                  onChangeValue: () {}),
              CW.AppSpacer(h: 20),
              Obx(
                () => CW
                    .imageUploaderContainer(
                      label: tUploadSign,
                      imageUrl: _.signature,
                      isUploading: _.isUploadingSignature.value,
                      hasUpload: _.hasUploadSignature.value,
                      onRemovePressed: _.deleteSignaure,
                      uploadProgress: _.uploadProgress.value,
                    )
                    .toButton(
                      onTap: _.signature.isNotEmpty || _.isUploadingImage.value
                          ? null
                          : () => _.uploadImage(
                              type: UploadType.Signature, controller: _),
                    ),
              ),
              Text(tSnapAnsSign).subTitle(fontSize: 10),
              CW.AppSpacer(h: 30),
              CW.button(
                  onPress: () => _.saveUserInfo({
                        "companyName": _.company.text,
                        "ownVehicle": _.hasVehicle,
                        "address": _.fullAdress.text,
                      }, page: 2),
                  text: tSave)
            ],
          );
        },
      ),
    );
  }
}
