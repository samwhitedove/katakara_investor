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
}
