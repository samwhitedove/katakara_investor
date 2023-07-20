import 'package:flutter/material.dart';
import 'package:katakara_investor/customs/customs.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/view/home/home.dart';

class InboxPageScreen extends StatelessWidget {
  final HomeScreenController ctr;
  const InboxPageScreen({super.key, required this.ctr});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CW.column(
        children: [
          CW.AppSpacer(h: 20),
          Container(),
          const Text("Inbox").title(fontSize: 15),
          CW.listUserOrProductWidget(
            name: "Online Admin",
            state: "Adwad",
            lga: "Online",
            status: true,
          ),
          CW.listUserOrProductWidget(
            name: "Online Admin",
            state: "Romesime",
            lga: "Online",
            status: true,
          ),
        ],
      ),
    );
  }
}
