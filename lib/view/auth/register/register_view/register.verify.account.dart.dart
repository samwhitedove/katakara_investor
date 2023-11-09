// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:katakara_investor/customs/custom.widget.dart';
// import 'package:katakara_investor/extensions/extensions.dart';
// import 'package:katakara_investor/values/values.dart';

// import 'register.dart';

// class VerifyAccountRegisterScreen extends StatelessWidget {
//   VerifyAccountRegisterScreen({super.key});

//   final _ = Get.find<RegisterScreenController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CW.form(
//         size: 0,
//         formKey: _.createAccountFormKey,
//         children: [
//           GetX<RegisterScreenController>(
//             init: _,
//             builder: (controller) => CW.baseWidget(
//               children: [
//                 CW.AppSpacer(h: 40),
//                 CW.backButton(onTap: Get.back),
//                 CW.AppSpacer(h: 16),
//                 const Text(tRegister).title(),
//                 CW.AppSpacer(h: 8),
//                 const Text(tCreateYourLogin).subTitle(),
//                 CW.AppSpacer(h: 20.7),
//                 CW.textField(
//                     label: tEmailAddress,
//                     controller: _.email!,
//                     focus: _.emailFocus,
//                     fieldName: tCode,
//                     validate: true,
//                     onChangeValue: () => _.stepChecker('step4')),
//                 CW.AppSpacer(h: 16),
//                 CW.passwordField(
//                     label: tPassword,
//                     showText: _.isPasswordVisible.value,
//                     controller: _.password!,
//                     customValidation: _.checkPasswordStrenght,
//                     onHide: _.isPasswordVisible.toggle,
//                     validate: true,
//                     onChangeValue: () => _.stepChecker('step4')),
//                 CW.AppSpacer(h: 16),
//                 CW.passwordField(
//                     label: tConfirmPassword,
//                     showText: _.isPasswordVisible.value,
//                     controller: _.confirmPassword!,
//                     validate: true,
//                     onHide: _.isPasswordVisible.toggle,
//                     customValidation: _.checkMatchLoginPassword,
//                     onChangeValue: () => _.stepChecker('step4')),
//                 CW.AppSpacer(h: 48),
//                 CW.button(
//                     onPress: _.isValidCredentails.value ? _.submit : null,
//                     text: tSubmit),
//                 CW.AppSpacer(h: 24),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
