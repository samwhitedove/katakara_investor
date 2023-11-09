import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.product.type.dart';
import 'package:katakara_investor/customs/custom.product.type.loading.dart';
import 'package:katakara_investor/models/product/models.fetch.portfolio.response.dart';
import 'package:katakara_investor/values/values.dart';

class ShowProducts extends StatelessWidget {
  final Function() refresh;
  final bool isLoading;
  final bool isError;
  final List<Datum> product;
  final String errorMessage;
  final double? height;
  const ShowProducts(
      {super.key,
      required this.refresh,
      required this.isLoading,
      required this.isError,
      required this.product,
      required this.errorMessage,
      this.height});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await refresh.call();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          // color: AppColor.black,
          height: Get.height * (height ?? .63),
          width: double.infinity,
          child: isLoading
              ? const ProductTypeCategoryLoadingState()
              : isError
                  ? ErrorFetchingScreen(
                      error: errorMessage,
                      onRefresh: refresh,
                    )
                  : ProductTypeCategory(
                      product: product,
                      onRefresh: refresh,
                    ),
        ),
      ),
    );
  }
}
