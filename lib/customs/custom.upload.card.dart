import 'package:flutter/material.dart';
import 'package:katakara_investor/customs/custom.image.container.dart';
import 'package:katakara_investor/extensions/extends.widget.dart';
import 'package:katakara_investor/values/values.dart';

// ignore: must_be_immutable
class CustomUploadCard extends StatelessWidget {
  CustomUploadCard({
    super.key,
    this.onDelete,
    required this.isLoading,
    required this.imageUrl,
    required this.isUploaded,
  });

  bool isLoading;
  bool isUploaded;
  String? imageUrl;
  Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onDelete?.call,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            ImageContainer(
              imageUrl: imageUrl,
              opacity: !isUploaded ? .4 : 1,
            ),
            isLoading
                ? Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset(Assets.assetsImagesLoading),
                    )
                        .simpleRoundCorner(
                          bgColor: AppColor.black.withAlpha(150),
                          height: 50,
                        )
                        .align(Al.center),
                  )
                : const SizedBox(),
            isUploaded
                ? Positioned(
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 4),
                      child: GestureDetector(
                        onTap: onDelete?.call,
                        child: const CircleAvatar(
                          radius: 8,
                          backgroundColor: AppColor.white,
                          child: Icon(
                            Icons.cancel,
                            color: AppColor.red,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
