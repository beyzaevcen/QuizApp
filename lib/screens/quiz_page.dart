import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/home_controller.dart';
import 'package:quiz_app/screens/score_page.dart';
import 'package:quiz_app/utils/theme.dart';
import 'package:quiz_app/widgets/question_widget.dart';

class QuizPage extends GetView<HomeController> {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        actions: [
          Obx(() => controller.pageChanged.value > 0
              ? IconButton(
                  onPressed: () {
                    controller.jokerIsUsed.value = false;
                    controller.pageChanged.value -= 1;
                    controller.pageController.animateToPage(controller.pageChanged.value,
                        duration: const Duration(microseconds: 250), curve: Curves.bounceInOut);
                  },
                  icon: const Icon(Icons.chevron_left_sharp),
                  color: CColors.mainColor,
                )
              : const SizedBox()),
          IconButton(
            onPressed: () {
              controller.jokerIsUsed.value = false;
              if (controller.pageChanged.value >= controller.questionList.length - 1) {
                controller.pageChanged.value = 0;
                Get.off(const ScorePage());
              } else {
                controller.pageChanged.value += 1;
                controller.pageController.animateToPage(controller.pageChanged.value,
                    duration: const Duration(microseconds: 250), curve: Curves.bounceInOut);
              }
            },
            icon: const Icon(Icons.chevron_right_sharp),
            color: CColors.mainColor,
          ),
        ],
        backgroundColor: CColors.white,
        title: const Text(
          "Questions",
          style: TextStyle(color: CColors.textTitle),
        ),
      ),
      body: Obx(
        () => PageView(
          controller: controller.pageController,
          onPageChanged: (index) {
            controller.pageChanged.value = index;
          },
          children: controller.questionList
              .map((e) => QuestionWidget(
                    question: e,
                    color: controller.colorlist[controller.pageChanged.value],
                  ))
              .toList(),
        ),
      ),
    );
  }
}
