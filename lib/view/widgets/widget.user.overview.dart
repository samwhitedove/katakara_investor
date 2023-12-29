import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:katakara_investor/extensions/extends.text.dart';
import 'package:katakara_investor/values/values.dart';

import '../../helper/helper.function.dart';

class UserOverviewListTile extends StatelessWidget {
  const UserOverviewListTile(
      {super.key,
      this.image,
      this.onTap,
      required this.fullName,
      required this.phone,
      required this.lga,
      required this.state});

  final String? image;
  final Function? onTap;
  final String fullName;
  final String phone;
  final String lga;
  final String state;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap?.call(),
      leading: SizedBox(
        height: HC.spaceVertical(50),
        width: HC.spaceVertical(50),
        child: image != null && image!.startsWith('http')
            ? CachedNetworkImage(imageUrl: image!)
            : Image.asset(Assets.assetsImagesImage, scale: 3),
      ),
      title: Text(fullName).title(fontSize: 14),
      subtitle: Text("$phone * $lga * $state").subTitle(fontSize: 10),
    );
  }
}
