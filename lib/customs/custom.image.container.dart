import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:katakara_investor/helper/helper.dart';

import '../values/svg.dart';

// ignore: must_be_immutable
class ImageContainer extends StatelessWidget {
  String? imageUrl;
  double? width;
  double? height;
  double? opacity;
  bool isLocal;
  ImageContainer({
    super.key,
    this.imageUrl,
    this.isLocal = false,
    this.width,
    this.height,
    this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    log(isLocal.toString());
    return Container(
      width: HC.spaceHorizontal(width ?? 70),
      height: HC.spaceHorizontal(height ?? 70),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          fit: BoxFit.cover,
          opacity: opacity ?? .4,
          scale: 5,
          image: imageUrl != null
              ? isLocal || imageUrl!.contains('cache')
                  ? FileImage(File(imageUrl!))
                  : imageUrl!.startsWith("http")
                      ? CachedNetworkImageProvider(imageUrl!) as ImageProvider
                      : AssetImage(imageUrl!)
              : AssetImage(
                  imageUrl ?? Assets.assetsImagesImage,
                ),
        ),
      ),
    );
  }
}
