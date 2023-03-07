import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:quiz_app/controllers/home_controller.dart';
import 'package:quiz_app/utils/theme.dart';

class NameWidget extends GetView<HomeController> {
  const NameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
          side: BorderSide(color: CColors.mainColor, width: 5.0),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      contentPadding: EdgeInsets.zero,
      backgroundColor: CColors.white,
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            width: 500,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller.name,
                style: const TextStyle(color: CColors.black),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: CColors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: CColors.mainColor, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: "Enter your name",
                  hintStyle: const TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
                onPressed: Get.back,
                child: const Text(
                  "Cancel",
                  style: TextStyle(fontSize: 25, color: CColors.mainColor),
                )),
            const SizedBox(
              width: 150,
            ),
            TextButton(
              child: const Text(
                'Save',
                style: TextStyle(fontSize: 25, color: CColors.mainColor),
              ),
              onPressed: () {
                controller.putBox();
                Get.back();
              },
            ),
          ],
        ),
      ],
    );
  }
}
