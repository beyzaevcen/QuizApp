import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/home_controller.dart';
import 'package:quiz_app/screens/score_page.dart';
import 'package:quiz_app/utils/theme.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({super.key});

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(duration: const Duration(seconds: 900), vsync: this);
    animationController.forward(from: Get.find<HomeController>().animOffset);
    animationController.addListener(updating);
    animationController.addStatusListener(finished);
    super.initState();
  }

  void updating() {
    Get.find<HomeController>().animOffset = animationController.value;
  }

  void finished(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      Get.off(const ScorePage());
    }
  }

  @override
  void dispose() {
    animationController.removeListener(updating);
    animationController.removeStatusListener(finished);
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 35,
        decoration: BoxDecoration(
            border: Border.all(color: CColors.mainColor, width: 2),
            borderRadius: BorderRadius.circular(50)),
        child: Stack(children: [
          LayoutBuilder(
              builder: (context, constraints) => AnimatedBuilder(
                  animation: animationController,
                  builder: (context, child) {
                    return Container(
                      width: constraints.maxWidth * animationController.value,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            stops: [
                              0.1,
                              0.4,
                              0.6,
                              0.9,
                            ],
                            colors: [
                              Colors.greenAccent,
                              Colors.pink,
                              Colors.blue,
                              Colors.purple,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(50)),
                    );
                  })),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [Icon(FontAwesomeIcons.clock)],
              ),
            ),
          ),
        ]));
  }
}
