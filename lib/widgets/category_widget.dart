import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:quiz_app/controllers/home_controller.dart';
import 'package:quiz_app/models/category.dart';
import 'package:quiz_app/utils/theme.dart';

class CategoryWidget extends GetView<HomeController> {
  const CategoryWidget(
      {Key? key, required this.category, required this.onTap, required this.selected})
      : super(key: key);
  final Category category;
  final Function() onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: onTap,
          child: Ink(
              height: 70,
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: selected ? CColors.pink : CColors.mainColor,
              ),
              child: Center(
                child: Text(
                  category.name,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              )),
        ));
  }
}
