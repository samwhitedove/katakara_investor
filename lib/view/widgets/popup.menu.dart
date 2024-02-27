import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/values/colors.dart';

class CustomPopUpMenu extends StatelessWidget {
  List<String>? data;
  Function(String?) onChange;
  int selected;
  CustomPopUpMenu({
    super.key,
    required this.data,
    required this.onChange,
    required this.selected,
  });

  changeType(String text) {
    if (data![selected].toLowerCase() == text.toLowerCase()) return;
    onChange(text.toUpperCase());
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.menu),
      onSelected: changeType,
      constraints: BoxConstraints(maxHeight: Get.height * .3),
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<String>>[
          ...List.generate(
            data!.length,
            (index) => PopupMenuItem<String>(
              textStyle: const TextStyle(fontSize: 10, color: AppColor.text),
              value: data![index],
              child: Row(
                children: [
                  Text(data![index]).subTitle(fontSize: 12),
                  selected == index
                      ? const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: CircleAvatar(
                            radius: 3,
                            backgroundColor: AppColor.primary,
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ),
        ];
      },
    );
  }
}
