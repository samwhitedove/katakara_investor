import 'dart:developer';

import 'package:flutter/material.dart';

extension Stringer on String {
  Container roundImageCorner(
      {required bool useAssets,
      double height = 60,
      double width = 60,
      double radius = 8}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: useAssets ? AssetImage(this) : this as ImageProvider),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  get formatMoney => _formatCurrency();

  String _formatCurrency() {
    String naira = this;
    String? kobo;
    if (naira.contains(".")) {
      kobo = naira.split(".")[1].trim();
      naira = naira.split(".")[0].trim();
    }

    int remainder = (naira.length % 3);
    int count = naira.length ~/ 3;
    log(count.toString());
    if (remainder == 0 && count == 1) {
      return "$naira${kobo != null ? '.$kobo' : ''}";
    }
    if (count == 1) {
      return "${remainder == 0 ? '' : '${naira.substring(0, remainder)},'}${naira.substring(remainder)}${kobo != null ? '.$kobo' : ''}";
    }
    String mainSplit = naira.substring(remainder);
    String money = "";
    for (int i = 0; i < mainSplit.length; i++) {
      if (i != 0 && i % 3 == 0) money += ',';
      money += mainSplit[i];
    }
    return "${remainder == 0 ? '' : '${naira.substring(0, remainder)},'}$money${kobo != null ? '.$kobo' : ''}";
  }
}
