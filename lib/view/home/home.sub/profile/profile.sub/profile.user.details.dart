import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/customs.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/view.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (_) {
          return CW.baseStackWidget(
            isLoading: _.isLoading(),
            children: [
              CW.column(
                children: [
                  CW.AppSpacer(h: 70),
                  CW.backButton(onTap: Get.back),
                  CW.AppSpacer(h: 30),
                  const Text(tUserDetails).title(),
                  CW.AppSpacer(h: 20),
                  CW.textField(
                      label: tFullName,
                      controller: _.fulName,
                      onChangeValue: () {}),
                  CW.AppSpacer(h: 10),
                  CW.textField(
                      label: tEmail.capitalize,
                      fieldName: tEmail,
                      readOnly: true,
                      controller: _.email,
                      onChangeValue: () {}),
                  CW.AppSpacer(h: 10),
                  CW.textField(
                    label: tPhone,
                    maxLength: 11,
                    fieldName: tNumber,
                    inputType: TextInputType.number,
                    controller: _.phone,
                    onChangeValue: () {},
                  ),
                  CW.AppSpacer(h: 10),
                  CW.textField(
                    label: tPhone2,
                    maxLength: 11,
                    fieldName: tNumber,
                    inputType: TextInputType.number,
                    controller: _.phone2,
                    onChangeValue: () {},
                  ),
                  CW.AppSpacer(h: 10),
                  Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(tState).subTitle(fontSize: 12),
                          CW.AppSpacer(h: 5),
                          Container(
                            child: Text(userData.state!)
                                .subTitle(fontSize: 14)
                                .align(Al.left)
                                .paddingOnly(left: 10),
                          ).roundCorner(
                            width: Get.width,
                          )
                        ],
                      ),
                      CW.AppSpacer(h: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(tLga).subTitle(fontSize: 12),
                          CW.AppSpacer(h: 5),
                          Container(
                            child: Text(userData.lga!)
                                .subTitle(fontSize: 14)
                                .align(Al.left)
                                .paddingOnly(left: 10),
                          ).roundCorner(
                            width: Get.width,
                          )
                        ],
                      ),
                    ],
                  ),
                  CW.AppSpacer(h: 30),
                  CW.button(onPress: _.updateProfileDetails, text: tSave)
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
