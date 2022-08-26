import 'package:flutter/material.dart';
import 'package:reusable_ui_flutter/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'management_view.dart';
import 'savetime_view.dart';
import 'statistics_view.dart';

class StepsView extends StatefulWidget {
  @override
  State<StepsView> createState() => _StepsViewState();
}

class _StepsViewState extends State<StepsView> {
  final PageController pageController = PageController();
  final currentPage = ValueNotifier<double>(0);
  @override
  Widget build(BuildContext context) {
    // final currentPage = useState<double>(0);
    // final PageController pageController = usePageController();

    // useEffect(() {
    //   pageController.addListener(() {
    //     if (pageController.page! != currentPage.value) {
    //       currentPage.value = pageController.page!;
    //     }
    //   });
    // });

    return Stack(
      children: [
        PageView(
          controller: pageController,
          // physics: const BouncingScrollPhysics(),
          children: [
            ManagementView(),
            SaveTimeView(),
            StatisticsView(),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Visibility(
                  visible: currentPage.value < 1.7,
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    effect: WormEffect(
                      dotColor: kGrayLightColor,
                      activeDotColor: kWhiteColor,
                      dotWidth: 14,
                      dotHeight: 14,
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: currentPage.value > 1.8 ? currentPage.value / 2 : 0,
                  duration: const Duration(milliseconds: 250),
                  child: SizedBox(
                    width: 140,
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(kWhiteColor),
                      ),
                      icon: const Icon(Icons.done),
                      label: const Text(
                        'Continue',
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
