import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:html_character_entities/html_character_entities.dart';
import 'package:quiz_app/models/category.dart';
import 'package:quiz_app/models/questions.dart';
import 'package:quiz_app/models/scoreModel.dart';
import 'package:quiz_app/screens/score_page.dart';
import 'package:quiz_app/services/api.dart';
import 'package:quiz_app/utils/theme.dart';

class Answer {
  final String text;
  final bool isCorrect;
  Answer({
    required this.text,
    required this.isCorrect,
  });
}

class HomeController extends GetxController {
  final categoryList = <Category>[].obs;
  final selectedCategories = <int>[].obs;
  final questionList = <Questions>[].obs;
  final colorlist = <Color>[
    CColors.mainColor,
    const Color.fromARGB(255, 42, 38, 85),
    CColors.green,
    const Color.fromARGB(255, 78, 42, 72),
    const Color.fromARGB(255, 94, 106, 215),
    const Color.fromARGB(255, 44, 9, 48),
    const Color.fromARGB(255, 124, 14, 54),
    const Color.fromARGB(255, 130, 58, 95),
    const Color.fromARGB(255, 67, 81, 53),
    CColors.mainColor,
    const Color.fromARGB(255, 42, 38, 85),
    CColors.green,
    const Color.fromARGB(255, 78, 42, 72),
    const Color.fromARGB(255, 94, 106, 215),
    const Color.fromARGB(255, 44, 9, 48),
    const Color.fromARGB(255, 124, 14, 54),
    const Color.fromARGB(255, 130, 58, 95),
    const Color.fromARGB(255, 67, 81, 53),
    CColors.mainColor,
    const Color.fromARGB(255, 42, 38, 85),
    CColors.green,
    const Color.fromARGB(255, 78, 42, 72),
    const Color.fromARGB(255, 94, 106, 215),
    const Color.fromARGB(255, 44, 9, 48),
    const Color.fromARGB(255, 124, 14, 54),
    const Color.fromARGB(255, 130, 58, 95),
    const Color.fromARGB(255, 67, 81, 53),
    CColors.mainColor,
    const Color.fromARGB(255, 42, 38, 85),
    CColors.green,
  ].obs;
  final scores = <ScoreModel>[].obs;

  final selectedDifficulty = "".obs;

  final answerList = <Answer>[].obs;
  final jokerList = <Answer>[].obs;

  final jokerCheckFirst = false.obs;
  final jokerCheckSecond = false.obs;
  final jokerCheckLast = false.obs;
  final jokerIsUsed = false.obs;

  final pageChanged = 0.obs;

  final correctAnswerCount = 0.obs;
  final falseAnswerCount = 0.obs;

  final selectedAnswers = <String>[].obs;

  final name = TextEditingController();
  final nameList = <String>[].obs;

  PageController pageController = PageController(initialPage: 0);

  String get selectedAnswer => selectedAnswers[pageChanged.value];

  double animOffset = 0.0;

  @override
  void onClose() {
    questionList.clear();
    pageController.dispose();
    pageChanged.value = 0;
    super.onClose();
  }

  @override
  void onInit() async {
    // final box = Hive.box("scoreBox");
    // for (var a in box.keys) {
    //   box.delete(a);
    // }

    final result = await Api.getCategories();
    if (result != null) {
      result.map((e) {
        categoryList.add(e);
      }).toList();
    }

    ever(pageChanged, (currentPage) {
      getAnswers(questionList[currentPage]);
    });
    getScores();
    super.onInit();
  }

  Future<void> getQuestions() async {
    EasyLoading.show(maskType: EasyLoadingMaskType.clear, status: "Preapering questions");
    jokerCheckFirst.value = false;
    jokerCheckSecond.value = false;
    jokerCheckLast.value = false;

    animOffset = 0;
    correctAnswerCount.value = 0;
    falseAnswerCount.value = 0;
    questionList.clear();

    final results = await Future.wait(List.generate(
        selectedCategories.length - 1,
        (i) => Api.getQuestions(
              selectedCategories[i],
              25 ~/ selectedCategories.length,
            )));

    for (final questions in results) {
      if (questions != null) {
        questionList.addAll(
            questions.map((e) => e.copyWith(question: HtmlCharacterEntities.decode(e.question))));
      }
    }
    final lastt = await Api.getQuestions(
      selectedCategories.last,
      25 - questionList.length,
    );
    if (lastt != null) {
      questionList
          .addAll(lastt.map((e) => e.copyWith(question: HtmlCharacterEntities.decode(e.question))));
    }

    selectedAnswers.value = List.generate(questionList.length, (index) => "");
    getAnswers(questionList[0]);
    EasyLoading.dismiss();
  }

  void getAnswers(Questions question) {
    answerList.clear();
    for (var element in question.incorrectAnswers) {
      answerList.add(Answer(text: HtmlCharacterEntities.decode(element), isCorrect: false));
    }
    answerList.add(Answer(text: question.correctAnswer, isCorrect: true));
    answerList.shuffle();
  }

  void selectAnswer(Answer a) {
    selectedAnswers[pageChanged.value] = a.text;
    if (a.isCorrect) {
      correctAnswerCount.value += 1;
    } else {
      falseAnswerCount.value += 1;
    }
  }

  void jokerButton(Questions a) {
    jokerList.clear();
    for (var element in answerList) {
      if (element.isCorrect == false) {
        jokerList.add(element);
        if (jokerList.length == 2) {
          return;
        }
      }
    }
  }

  Future<void> timeEnd() async {
    Get.off(const ScorePage());
    //animation.isCompleted ? Get.to(const ScorePage()) : const SizedBox();
  }

  void getScores() {
    final tempScores = <ScoreModel>[];
    final box = Hive.box("scoreBox");

    for (final date in box.keys) {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(date));
      final person = jsonDecode(box.get(date)) as Map<String, dynamic>;
      final score = ScoreModel(name: person["name"], date: dateTime, score: person["score"]);
      tempScores.add(score);
    }
    tempScores.sort((a, b) => b.date.millisecondsSinceEpoch - a.date.millisecondsSinceEpoch);

    scores.addAll(tempScores);
  }

  void putBox() async {
    final box = Hive.box("scoreBox");
    final now = DateTime.now();
    final score = (4 * correctAnswerCount.value);

    await box.put(
        now.millisecondsSinceEpoch.toString(),
        jsonEncode(<String, dynamic>{
          "name": name.text,
          "score": score,
        }));
    final scoreModel = ScoreModel(name: name.text, date: now, score: score);
    scores.insert(0, scoreModel);
    name.clear();
  }
}
