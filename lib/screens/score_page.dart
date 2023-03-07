import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:quiz_app/controllers/home_controller.dart';
import 'package:quiz_app/screens/home_page.dart';
import 'package:quiz_app/utils/theme.dart';
import 'package:quiz_app/widgets/name_widget.dart';

class ScorePage extends GetView<HomeController> {
  const ScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.close,
                color: CColors.pink,
                size: 40,
              ),
              onPressed: () {
                controller.selectedCategories.clear();
                Get.off(const HomePage());
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(40),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Column(
                  children: [
                    const Text(
                      "THE END",
                      style: TextStyle(
                          color: CColors.pink, fontSize: 30.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "TOTAL:${controller.questionList.length} Question",
                      style: const TextStyle(
                          color: CColors.mainColor, fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Score:${4 * controller.correctAnswerCount.value}",
                      style: const TextStyle(
                          color: CColors.pink, fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Table(border: TableBorder.all(), children: [
                      TableRow(children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Correct Anwer:',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            controller.correctAnswerCount.toString(),
                            style: const TextStyle(color: Colors.green),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Incorrect Answer:',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            controller.falseAnswerCount.toString(),
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Empty Answer:'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text((25 -
                                  (controller.correctAnswerCount.value +
                                      controller.falseAnswerCount.value))
                              .toString()),
                        ),
                      ]),
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: Get.width / 2.5,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: CColors.mainColor),
                          onPressed: () {
                            Get.dialog(const NameWidget());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.save_alt, color: Colors.white),
                              Text(
                                "  Save your score",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: CColors.mainColor,
                      height: 1,
                      width: Get.width,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const Text("Scores",
                          style: TextStyle(
                              color: CColors.mainColor, fontSize: 20, fontWeight: FontWeight.w500)),
                      Obx(
                        () => Wrap(
                          children: [
                            ...controller.scores.map((e) => ListTile(
                                  title: Text(e.score.toString()),
                                  subtitle: Text(
                                    e.name,
                                    style: const TextStyle(color: CColors.pink),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
