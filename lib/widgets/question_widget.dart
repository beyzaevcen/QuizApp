import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:quiz_app/controllers/home_controller.dart';
import 'package:quiz_app/models/questions.dart';
import 'package:quiz_app/utils/theme.dart';
import 'package:quiz_app/widgets/progress_bar.dart';

class QuestionWidget extends GetView<HomeController> {
  final Questions question;
  final Color color;

  const QuestionWidget({required this.color, required this.question, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 10, bottom: 20),
      child: Column(children: [
        const ProgressBar(key: ValueKey("PROGRESS")),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: color,
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  "Page ${controller.pageChanged.value + 1}/${controller.questionList.length}",
                  style: const TextStyle(color: CColors.white, fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      question.question,
                      style: const TextStyle(fontSize: 23, color: CColors.white),
                    ),
                  ),
                ),
              ),
              ...controller.answerList
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Obx(() => Container(
                            margin: const EdgeInsets.only(top: 5),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: controller.selectedAnswer != ""
                                        ? e.isCorrect
                                            ? Colors.green
                                            : controller.selectedAnswer == e.text
                                                ? Colors.red
                                                : Colors.white
                                        : controller.jokerList.contains(e)
                                            ? CColors.black
                                            : CColors.white,
                                    width: 2),
                                borderRadius: BorderRadius.circular(15)),
                            child: ListTile(
                              onTap: () => controller.jokerList.contains(e)
                                  ? const SizedBox()
                                  : controller.selectAnswer(e),
                              title: Text(
                                e.text,
                                style: const TextStyle(color: CColors.white, fontSize: 20),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: const BorderSide(color: CColors.mainColor),
                              ),
                              trailing: controller.selectedAnswer == ""
                                  ? Icon(
                                      Icons.check_box_outline_blank,
                                      color: controller.jokerList.contains(e)
                                          ? Colors.black
                                          : Colors.white,
                                    )
                                  : Icon(
                                      e.isCorrect ? Icons.check_box_outlined : Icons.close,
                                      color: Colors.white,
                                    ),
                            ),
                          )),
                    ),
                  )
                  .toList(),
              const SizedBox(
                height: 10,
              ),
              Obx(() => Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                            onPressed: controller.jokerCheckFirst.value
                                ? null
                                : () {
                                    if (!controller.jokerIsUsed.value) {
                                      controller.jokerIsUsed.value = true;
                                      controller.jokerCheckFirst.value = true;
                                      controller.jokerButton(question);
                                    }
                                  },
                            icon: const Icon(
                              FontAwesomeIcons.faceGrinWink,
                              color: CColors.white,
                            ),
                            label: const Text("joker"),
                            style: ElevatedButton.styleFrom(backgroundColor: CColors.pink)),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton.icon(
                            onPressed: controller.jokerCheckSecond.value
                                ? null
                                : () {
                                    if (!controller.jokerIsUsed.value) {
                                      controller.jokerIsUsed.value = true;
                                      controller.jokerCheckSecond.value = true;
                                      controller.jokerButton(question);
                                    }
                                  },
                            icon: const Icon(
                              FontAwesomeIcons.faceGrinWink,
                              color: CColors.white,
                            ),
                            label: const Text("joker"),
                            style: ElevatedButton.styleFrom(backgroundColor: CColors.pink)),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton.icon(
                            onPressed: controller.jokerCheckLast.value
                                ? null
                                : () {
                                    if (!controller.jokerIsUsed.value) {
                                      controller.jokerIsUsed.value = true;
                                      controller.jokerCheckLast.value = true;
                                      controller.jokerButton(question);
                                    }
                                  },
                            icon: const Icon(
                              FontAwesomeIcons.faceGrinWink,
                              color: CColors.white,
                            ),
                            label: const Text("joker"),
                            style: ElevatedButton.styleFrom(backgroundColor: CColors.pink)),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ]),
    );
  }
}
