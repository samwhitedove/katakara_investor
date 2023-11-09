// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:katakara_investor/customs/customs.dart';
// import 'package:katakara_investor/extensions/extensions.dart';
// import 'package:katakara_investor/services/service.http.dart';
// import 'package:katakara_investor/values/values.dart';
// import 'package:katakara_investor/view/auth/register/register_controller/register_controller.dart';
// import 'package:katakara_investor/view/auth/register/register_controller/stepThree.controller.dart';

// class StepThree extends StatelessWidget {
//   const StepThree({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<StepThreeController>(
//       init: StepThreeController(),
//       initState: (_) {},
//       builder: (step3Controller) {
//         return Column(
//           children: [
//             CW.AppSpacer(h: 16),
//             CW.textField(
//                 label: tFullAddress,
//                 controller: step3Controller.fullAddress,
//                 lines: 4,
//                 maxLength: 150,
//                 inputType: TextInputType.multiline,
//                 onChangeValue: () {}),
//             CW.AppSpacer(h: 10),
//             CW.dropdownString(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(4),
//                 border: Border.all(
//                   color: AppColor.grey,
//                 ),
//               ),
//               label: tGovernmentId,
//               value: step3Controller.selectedId.value,
//               onChange: (text) {
//                 step3Controller.selectedId.value = text;
//                 step3Controller.stepThreeChecker();
//               },
//               data: governmentIds,
//             ),
//             CW.AppSpacer(h: 24),
//             GetBuilder<RegisterScreenController>(
//               init: RegisterScreenController(),
//               initState: (_) {},
//               builder: (_) {
//                 return Obx(
//                   () => CW
//                       .imageUploaderContainer(
//                         label: tUploadGovernmentId,
//                         hasUpload:
//                             step3Controller.govermentImageUrl.value.isNotEmpty,
//                         imageUrl: step3Controller.govermentImageUrl.value,
//                         isUploading: _.isUploadingGovImage.value,
//                         onRemovePressed: () => _.deleteUploadedImage(
//                             step3Controller.govermentImageUrl.value,
//                             IdType.government),
//                         uploadProgress: _.uploadProgress.value,
//                       )
//                       .toButton(
//                         onTap: step3Controller
//                                     .govermentImageUrl.value.isNotEmpty ||
//                                 _.isUploadingGovImage.value
//                             ? null
//                             : () => _.uploadImage(
//                                   type: UploadType.Document,
//                                   idType: IdType.government,
//                                   controller: _,
//                                 ),
//                       ),
//                 );
//               },
//             ),
//             CW.AppSpacer(h: 14),
//             GetBuilder<RegisterScreenController>(
//               init: RegisterScreenController(),
//               initState: (_) {},
//               builder: (_) {
//                 return Obx(
//                   () => CW
//                       .imageUploaderContainer(
//                         label: tUploadCAC,
//                         hasUpload: step3Controller.cacImageUrl.value.isNotEmpty,
//                         imageUrl: step3Controller.cacImageUrl.value,
//                         isUploading: _.isUploadingCacImage.value,
//                         onRemovePressed: () => _.deleteUploadedImage(
//                             step3Controller.cacImageUrl.value, IdType.cac),
//                         uploadProgress: _.uploadProgress.value,
//                       )
//                       .toButton(
//                         onTap: step3Controller.cacImageUrl.value.isNotEmpty ||
//                                 _.isUploadingCacImage.value
//                             ? null
//                             : () => _.uploadImage(
//                                   type: UploadType.Document,
//                                   idType: IdType.cac,
//                                   controller: _,
//                                 ),
//                       ),
//                 );
//               },
//             ),
//             CW.AppSpacer(h: 14),
//             GetBuilder<RegisterScreenController>(
//               init: RegisterScreenController(),
//               initState: (_) {},
//               builder: (_) {
//                 return Obx(
//                   () => CW
//                       .imageUploaderContainer(
//                         label: tUploadLetter,
//                         hasUpload:
//                             step3Controller.letterHeadUrl.value.isNotEmpty,
//                         imageUrl: step3Controller.letterHeadUrl.value,
//                         isUploading: _.isUploadingLetterImage.value,
//                         onRemovePressed: () => _.deleteUploadedImage(
//                             step3Controller.letterHeadUrl.value,
//                             IdType.letterHeaded),
//                         uploadProgress: _.uploadProgress.value,
//                       )
//                       .toButton(
//                         onTap: step3Controller.letterHeadUrl.value.isNotEmpty ||
//                                 _.isUploadingLetterImage.value
//                             ? null
//                             : () => _.uploadImage(
//                                   type: UploadType.Document,
//                                   idType: IdType.letterHeaded,
//                                   controller: _,
//                                 ),
//                       ),
//                 );
//               },
//             ),
//             // CW
//             //     .imageUploaderContainer(
//             //         label: tUploadGovernmentId,
//             //         isUploading: false,
//             //         onRemovePressed: () {},
//             //         uploadProgress: .2)
//             //     .toButton(
//             //         onTap: () => _.uploadImage(
//             //               type: UploadType.Document,
//             //               idType: IdType.government,
//             //               controller: _,
//             //             )),
//             // CW.AppSpacer(h: 14),
//             // CW
//             //     .imageUploaderContainer(
//             //         label: tUploadCAC,
//             //         isUploading: false,
//             //         onRemovePressed: () {},
//             //         uploadProgress: .2)
//             //     .toButton(
//             //         onTap: () => _.uploadImage(
//             //             type: UploadType.Document,
//             //             idType: IdType.cac,
//             //             controller: _)),
//             // CW.AppSpacer(h: 14),
//             // CW
//             //     .imageUploaderContainer(
//             //         label: tUploadLetter,
//             //         isUploading: false,
//             //         onRemovePressed: () {},
//             //         uploadProgress: .2)
//             //     .toButton(
//             //         onTap: _.isUploadingImage.value
//             //             ? null
//             //             : () => _.uploadImage(
//             //                 type: UploadType.Document,
//             //                 idType: IdType.letterHeaded,
//             //                 controller: _)),
//           ],
//         );
//       },
//     );
//   }
// }
