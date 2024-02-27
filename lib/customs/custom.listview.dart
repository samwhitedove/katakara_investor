import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/load.more.button.dart';
import 'package:katakara_investor/models/receipt/model.fetch.reponse.dart';
import 'package:katakara_investor/view/admin/users/admin.user.controller.dart';

// ignore: must_be_immutable
class CustomListViewWithFetchMore extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  int count;
  UserViewType? type;
  Function child;
  Pagination? pagination;
  RxBool fetchingMore;
  Function()? getMoreReceipt;
  // for receipt view
  List<dynamic> fetchedata;
  Function(String)? handleStatusView;
  Function(UserViewType)? getMoreUser;
  Function(int)? previewData;

  // int index, List<FetchedReceipt> fetchedReceipt,
  //   Function(String) handleStatusView, Function(int) viewReceipt

  CustomListViewWithFetchMore({
    super.key,
    required this.child,
    required this.pagination,
    required this.count,
    this.getMoreReceipt,
    this.getMoreUser,
    required this.fetchingMore,
    required this.fetchedata,
    this.handleStatusView,
    this.previewData,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      controller: _scrollController,
      itemCount: count,
      itemBuilder: (context, index) => Column(
        children: [
          child(index, fetchedata, handleStatusView ?? (_) {},
              previewData ?? (_) {}),
          LoadMore(
              onTap: () => getMoreReceipt?.call() ?? getMoreUser?.call(type!),
              hasNextPage: pagination?.nextPage != null,
              isLoading: fetchingMore,
              showAtBottom: count - 1 == index)
        ],
      ),
    );
  }
}
