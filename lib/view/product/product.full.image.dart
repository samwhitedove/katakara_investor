import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/values/values.dart';

class FullImageView extends StatelessWidget {
  FullImageView({super.key});
  final Map<String, dynamic> data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: Stack(
        children: [
          Center(
            child: Hero(
              tag: data['tag'],
              child: CachedNetworkImage(
                imageUrl: data['image'],
                fit: BoxFit.contain,
              ),
            ),
          ),
          Column(
            children: [
              CW.AppSpacer(h: 40),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
                child: Row(
                  children: [CW.backButton(iconColor: AppColor.black)],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
