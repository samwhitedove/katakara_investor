// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:katakara_investor/customs/custom.widget.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CW.baseStackWidget(
          side: 15, children: [CW.AppSpacer(h: 50), Text("Hello")]),
    );
  }
}
