import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:katakara_investor/customs/customs.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../values/values.dart';

class CW {
  static SizedBox AppSpacer({double h = 0, double w = 0}) {
    return SizedBox(
        height: Get.height * ((h / Get.height) * 100) / 100,
        width: Get.width * ((w / Get.width) * 100) / 100);
  }

//PAGE CONTROLLER DOT
  static const onesSec = Duration(seconds: 1);
  static const halfSec = Duration(milliseconds: 500);
  static const quarterSec = Duration(milliseconds: 300);
  static const quarter100 = Duration(milliseconds: 100);
  static Row PageDot(
      {required int count,
      required RxInt current,
      Color activeColor = Colors.white,
      Color inactiveColor = Colors.blue}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(
        count,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Obx(() {
            return AnimatedContainer(
              height: 4,
              width: current.value == index ? 20 : 7,
              decoration: BoxDecoration(
                  color: current.value == index ? activeColor : inactiveColor,
                  borderRadius: BorderRadius.circular(5)),
              duration: quarterSec,
            );
          }),
        ),
      ),
    );
  }

  static Padding dropdownInt(
      {BoxDecoration? decoration,
      Color? color,
      Color? iconColor,
      double? iconSize,
      IconData? icon,
      required String? label,
      required dynamic value,
      required Function(int) onChange,
      required List<int> data}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(label!),
          ),
          Container(
            height: 50,
            decoration: decoration,
            width: Get.width * .9,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<int>(
                  value: value,
                  onChanged: (value) => onChange(value!),
                  items: data.map((value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: SizedBox(
                        width: Get.width * .3,
                        child: Text(
                          value.toString(),
                        ),
                      ),
                    );
                  }).toList(),
                  icon: const SizedBox(),
                  underline: const SizedBox(),
                ),
                Icon(
                  icon ?? Icons.keyboard_arrow_down_sharp,
                  size: iconSize,
                  color: iconColor,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  static bottomSheet(
      {required String title,
      required List<Map<String, dynamic>> data,
      double height = .25}) {
    return Get.bottomSheet(
      Container(
        height: Get.height * height,
        child: Column(
          children: [
            Text(title)
                .title(fontSize: 14, color: AppColor.text)
                .addPaddingVertical(size: 15),
            ...List.generate(
                data.length,
                (index) => CW
                    .button(
                        onPress: data[index]['onTap'],
                        color: data[index]['color'],
                        text: data[index]['label'])
                    .marginSymmetric(horizontal: 20))
          ],
        ),
      ),
      backgroundColor: AppColor.white,
      clipBehavior: Clip.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }

  static Column imageUploaderContainer(
      {String? label,
      String? title,
      String? fileSize,
      String? fileType,
      required String imageUrl,
      required bool isUploading,
      required bool hasUpload,
      required Function() onRemovePressed,
      required double uploadProgress}) {
    return Column(
      children: [
        Text(label ?? tUploadClearImage).label().align(Al.left),
        AppSpacer(h: 10),
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColor.primaryLight,
                image: DecorationImage(
                  image: imageUrl.isEmpty
                      ? const AssetImage(Assets.assetsImagesProfile)
                      : CachedNetworkImageProvider(imageUrl) as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            AppSpacer(w: 10),
            Stack(
              children: [
                isUploading
                    ? Container(
                        constraints: BoxConstraints(maxWidth: Get.width * .75),
                        width: Get.width * uploadProgress,
                        color: AppColor.primaryLight,
                        height: 50,
                      )
                    : SizedBox(),
                SizedBox(
                  height: 50,
                  width: Get.width * .75,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(width: .4),
                        borderRadius: BorderRadius.circular(4)),
                    color: AppColor.greyLigth.withOpacity(.1),
                    elevation: 0,
                    child: Builder(
                      builder: (context) {
                        if (isUploading) {
                          return Text(tUploading)
                              .title(color: AppColor.primary, fontSize: 14)
                              .align(Al.center);
                        }

                        if (hasUpload) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(tImageUploaded)
                                  .title(color: AppColor.primary, fontSize: 14),
                              Icon(
                                Icons.delete,
                                color: AppColor.red,
                              ).toButton(
                                onTap: onRemovePressed,
                              )
                            ],
                          ).addPaddingHorizontal(size: 10);
                        }

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(title ?? tUploadFile)
                                .title(color: AppColor.primary, fontSize: 14),
                            Text(fileSize != null
                                    ? "$fileSize, $fileType"
                                    : tTempText)
                                .subTitle(fontSize: 10),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  static Padding dropdownString({
    BoxDecoration? decoration,
    Color? color,
    Color? iconColor,
    double? iconSize,
    IconData? icon,
    double? dropDownWidth,
    required String? label,
    required dynamic value,
    required Function(String) onChange,
    required List<String> data,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(label!).label(),
          ),
          Container(
            height: 50,
            decoration: decoration,
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  menuMaxHeight: Get.height * .3,
                  value: value,
                  onChanged: (value) => onChange(value!),
                  items: data.map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: SizedBox(
                        width: Get.width * (dropDownWidth ?? .35),
                        child: Text(
                          value.toString(),
                        ),
                      ),
                    );
                  }).toList(),
                  icon: Icon(
                    icon ?? Icons.keyboard_arrow_down_sharp,
                    size: iconSize,
                    color: iconColor,
                  ),
                  underline: const SizedBox(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Padding button(
      {required Function()? onPress,
      required String? text,
      Widget? child,
      Color? color,
      bool isLoading = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPress,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) => color,
          ),
        ),
        child: SizedBox(
          width: Get.width,
          height: 45,
          child: isLoading
              ? const Center(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(),
                  ),
                )
              : Center(
                  child: child ??
                      Text(
                        text!,
                        textScaleFactor: 1,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                        ),
                      ),
                ),
        ),
      ),
    );
  }

  static Column textField({
    required String? label,
    String? hint,
    bool validate = false,
    bool readOnly = false,
    bool bold = false,
    String? fieldName,
    double? fontSize,
    FocusNode? focus,
    int maxLength = 50,
    int lines = 1,
    required TextEditingController controller,
    TextInputType inputType = TextInputType.text,
    required Function() onChangeValue,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Text(label!).label(),
        ),
        Card(
          margin: EdgeInsets.zero,
          elevation: 0,
          shape: RoundedRectangleBorder(
              side: const BorderSide(width: .5),
              borderRadius: BorderRadius.circular(4)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              maxLines: lines,
              focusNode: focus,
              readOnly: readOnly,
              keyboardType: fieldName == tEmail
                  ? TextInputType.emailAddress
                  : fieldName == 'code'
                      ? TextInputType.number
                      : inputType,
              onChanged: (text) => onChangeValue(),
              controller: controller,
              inputFormatters: [
                if (fieldName == 'number') ...[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                if (fieldName == 'code') ...[
                  FilteringTextInputFormatter.digitsOnly,
                  OtpInputFormatter()
                ],
                LengthLimitingTextInputFormatter(
                    fieldName == 'code' ? 7 : maxLength)
              ],
              validator: (String? text) {
                if (!validate) return null;
                if (fieldName == null && validate) {
                  throw 'Invalid Field name';
                }
                // if (text!.isEmpty) {
                //   return "Field is required";
                // }
                // if (text!.length < 3) {
                //   return "Invalid value for field, must be more than 3 characters";
                // }
                if (fieldName!.toLowerCase() == tEmail) {
                  return HC.validateEmail(text!)
                      ? null
                      : 'invalid email address';
                }
                if (fieldName.toLowerCase() == 'phone') {
                  return text!.length < 10
                      ? "invalid phone, must be more than 10 digits"
                      : null;
                }
                return null;
              },
              style: TextStyle(
                  fontSize: fontSize ?? 16,
                  fontFamily: 'Inter',
                  fontWeight: bold ? FontWeight.w700 : FontWeight.normal),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hint ?? 'Enter $label',
                  hintStyle: const TextStyle(color: AppColor.iconInactive),
                  contentPadding: EdgeInsets.zero),
            ),
          ),
        ),
      ],
    );
  }

  static Column passwordField(
      {required String? label,
      String? hint,
      required bool showText,
      bool? validate,
      required TextEditingController controller,
      required Function()? onHide,
      Function()? customValidation,
      required Function() onChangeValue}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Text(label!).label(),
        ),
        Card(
          margin: EdgeInsets.zero,
          elevation: 0,
          shape: RoundedRectangleBorder(
              side: const BorderSide(width: .5),
              borderRadius: BorderRadius.circular(4)),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    validator: (text) {
                      if (validate == false || validate == null) return null;
                      if (customValidation != null) return customValidation();
                      final check = HC.validatePasswordStrength(text!);
                      if (check['status']) {
                        return check['message'].toString();
                      }

                      return null;
                    },
                    onChanged: (text) => onChangeValue(),
                    controller: controller,
                    obscureText: !showText,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hint ?? 'Enter $label',
                        hintStyle:
                            const TextStyle(color: AppColor.iconInactive)),
                  ),
                ),
              ),
              InkWell(
                onTap: onHide,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    showText
                        ? Icons.remove_red_eye_rounded
                        : Icons.remove_red_eye_outlined,
                    color: AppColor.iconInactive,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Padding column({double size = 15, required List<Widget> children}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  static SafeArea baseWidget(
      {double side = 15,
      required List<Widget> children,
      bool isLoading = false}) {
    return SafeArea(
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: side),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            ),
          ),
          Visibility(
            visible: isLoading,
            child: Container(
              height: Get.height,
              color: AppColor.grey.withOpacity(.4),
            ),
          ),
          Visibility(visible: isLoading, child: const LinearProgressIndicator())
        ],
      ),
    );
  }

  static Stack baseStackWidget({
    double side = 0,
    required List<Widget> children,
    MainAxisAlignment mainAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAlignment = CrossAxisAlignment.start,
    AppBar? appBar,
    Key? key,
    Widget? drawer,
    Widget? floatingActionButton,
    BottomNavigationBar? bottomNavigationBar,
    bool isLoading = false,
    bool extendBodyBehindAppBar = false,
  }) {
    return Stack(
      children: [
        Scaffold(
          drawer: drawer,
          key: key,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          appBar: appBar,
          floatingActionButton: floatingActionButton,
          bottomNavigationBar: bottomNavigationBar,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: side),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: mainAlignment,
                crossAxisAlignment: crossAlignment,
                children: children,
              ),
            ),
          ),
        ),
        Visibility(
          visible: isLoading,
          child: Container(
            color: AppColor.black.withOpacity(.4),
          ),
        ),
        Visibility(
          visible: isLoading,
          child: const SafeArea(
            child: SizedBox(
              height: 5,
              child: LinearProgressIndicator(),
            ),
          ),
        ),
      ],
    );
  }

  static Padding form(
      {double size = 15,
      required List<Widget> children,
      Function()? onFormChange,
      required Key formKey,
      AutovalidateMode? validateMode,
      Future<bool> Function()? onRemoveForm}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: formKey,
          autovalidateMode: validateMode ?? AutovalidateMode.onUserInteraction,
          onWillPop: onRemoveForm,
          onChanged: onFormChange,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    );
  }

  static GestureDetector backButton({
    Function()? onTap,
    Color innerBgColor = AppColor.white,
    Color outerBgColor = AppColor.black,
    Color? iconColor,
    double bgVisible = .2,
  }) {
    return GestureDetector(
      onTap: onTap ?? Get.back,
      child: CircleAvatar(
        // radius: 25,
        backgroundColor: outerBgColor,
        child: Padding(
          padding: EdgeInsets.all(bgVisible),
          child: CircleAvatar(
            // radius: 24.8,
            backgroundColor: innerBgColor,
            child: SvgPicture.asset(
              Assets.assetsSvgBackArrow,
              // ignore: deprecated_member_use
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }

  static CircleAvatar circleWithBorder(
      {required Widget child, Color? color, Color? baseColor}) {
    return CircleAvatar(
      radius: 12,
      backgroundColor: baseColor,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: CircleAvatar(
          backgroundColor: color,
          child: child,
        ),
      ),
    );
  }

  static Widget listUserOrProductWidget(
      {required String name,
      required String state,
      required String lga,
      required dynamic status}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Assets.assetsImagesImage.roundImageCorner(useAssets: true),
        CW.AppSpacer(w: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name).title(fontSize: 14, color: AppColor.black),
                Text('$state, $lga').subTitle(fontSize: 11),
              ],
            ),
            CW.AppSpacer(h: 3),
            Text(status.runtimeType == (List<String>)
                    ? status.join(", ").toString()
                    : status.runtimeType == bool
                        ? !status
                            ? "Unavailable"
                            : "Available"
                        : status.toString())
                .subTitle(
                    fontSize: 10,
                    color: status.runtimeType == bool
                        ? status
                            ? AppColor.primary
                            : AppColor.red
                        : AppColor.primary)
                .roundCorner(
                    height: 20,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    showBorder: false,
                    bgColor: AppColor.white.withOpacity(.8)),
            CW.AppSpacer(h: 1),
          ],
        )
      ],
    )
        .roundCorner(height: 60, showBorder: false, blurRadius: 1)
        .marginSymmetric(vertical: 10);
  }

  static Widget listUserOrProductWidgetShimmer({bool animate = true}) {
    return GFShimmer(
            showShimmerEffect: animate,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Assets.assetsImagesImage.roundImageCorner(useAssets: true),
                CW.AppSpacer(w: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CW.AppSpacer(h: 3),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("name")
                            .title(fontSize: 14, color: AppColor.black)
                            .roundCorner(height: 10),
                        const Text('state, lga')
                            .subTitle(fontSize: 11)
                            .roundCorner(height: 10),
                      ],
                    ),
                    CW.AppSpacer(h: 3),
                    const Text("status.toString()")
                        .subTitle(fontSize: 10, color: AppColor.primary)
                        .roundCorner(
                            height: 20,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            showBorder: false,
                            bgColor: AppColor.white.withOpacity(.8)),
                    CW.AppSpacer(h: 1),
                  ],
                )
              ],
            ))
        .roundCorner(height: 60, showBorder: false, blurRadius: 1)
        .marginSymmetric(vertical: 10);
  }
}
