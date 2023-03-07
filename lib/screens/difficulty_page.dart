import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:quiz_app/const.dart';
import 'package:quiz_app/controllers/home_controller.dart';
import 'package:quiz_app/screens/quiz_page.dart';
import 'package:quiz_app/utils/theme.dart';
import 'package:quiz_app/widgets/difficulty_widget.dart';

class DifficultyPage extends GetView<HomeController> {
  const DifficultyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(FontAwesomeIcons.chevronLeft, color: CColors.pink),
            onPressed: () {
              Get.back();
            },
          ),
          title: const Text(
            "Choose Difficulty",
            style: TextStyle(color: CColors.pink, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 150),
          child: Column(
            children: Const.difficultyList
                .map(
                  (e) => DifficultyWidget(
                    text: e.toUpperCase(),
                    onTap: () async {
                      controller.selectedDifficulty.value = e;
                      await controller.getQuestions();
                      Get.off(const QuizPage());
                    },
                  ),
                )
                .toList(),
          ),
        ));
  }
}
