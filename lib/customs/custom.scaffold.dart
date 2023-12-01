import 'package:flutter/material.dart';

import '../helper/helper.dart';

class CustomScaffold {
  // ignore: non_constant_identifier_names
  static Padding BaseWidget({required List<Widget> children}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: HC.spaceHorizontal(24),
      ),
      child: Column(
        children: children,
      ),
    );
  }
}
