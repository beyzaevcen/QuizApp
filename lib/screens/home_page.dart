import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/home_controller.dart';
import 'package:quiz_app/screens/quiz_page.dart';
import 'package:quiz_app/utils/theme.dart';
import 'package:quiz_app/widgets/category_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Choose Category",
            style: TextStyle(color: CColors.mainColor, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () async {
                  if (controller.selectedCategories.isNotEmpty) {
                    await controller.getQuestions();
                    Get.off(const QuizPage());
                  }
                  EasyLoading.showError("Choose at least one category");
                },
                icon: const Icon(
                  FontAwesomeIcons.chevronRight,
                  color: CColors.mainColor,
                ))
          ],
        ),
        body: Obx(
          () => ListView(
            children: controller.categoryList
                .map((e) => CategoryWidget(
                      category: e,
                      selected: controller.selectedCategories.contains(e.id),
                      onTap: () {
                        controller.selectedCategories.contains(e.id)
                            ? controller.selectedCategories.remove(e.id)
                            : controller.selectedCategories.add(e.id);
                      },
                    ))
                .toList(),
          ),
        ));
  }
}
