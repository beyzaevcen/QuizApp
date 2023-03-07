import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:quiz_app/controllers/home_controller.dart';
import 'package:quiz_app/utils/theme.dart';

class DifficultyWidget extends GetView<HomeController> {
  final String text;
  final Function() onTap;

  const DifficultyWidget({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: onTap,
          child: Ink(
            height: 100,
            width: 400,
            decoration: BoxDecoration(
              color: CColors.pink,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
