import 'package:flutter/material.dart';
import 'package:reusable_ui_flutter/widgets/widgets.dart'
    show SliderDots, EleventhButton;

import 'const.dart';
import 'widgets/steps_view.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final PageController pageController;
  final currentPage = ValueNotifier<double>(0);

  final totalSliders = 3;

  @override
  void initState() {
    pageController = PageController()
      ..addListener(() {
        if (pageController.page! != currentPage.value) {
          currentPage.value = pageController.page!;
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            physics: const BouncingScrollPhysics(),
            children: const [
              StepsView(
                title: 'Management',
                description:
                    'simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
                imageAssets: imgManagement,
                iconData: Icons.manage_accounts,
              ),
              StepsView(
                title: 'Save time',
                description:
                    'simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
                imageAssets: imgSavetime,
                iconData: Icons.access_time_filled_rounded,
              ),
              StepsView(
                title: 'Statistics',
                description:
                    'simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
                imageAssets: imgStatistics,
                iconData: Icons.star_outlined,
              ),
            ],
          ),
          ValueListenableBuilder<double>(
            valueListenable: currentPage,
            builder: (_, page, child) => Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Visibility(
                      visible: page < dotsVisibility,
                      child: SliderDots(
                        totalSlides: totalSliders,
                        controller: pageController,
                        accentColor: Colors.grey,
                        dotsSize: 12,
                        dotsSpace: 5,
                        primaryColor: kBlueColor,
                        secondaryDotsSize: 15,
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: page > startOpacity ? page / 2 : 0,
                      duration: const Duration(milliseconds: 250),
                      child: EleventhButton(
                        label: 'Continue',
                        primaryColor: Colors.white,
                        accentColor: kBlackColor,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double get dotsVisibility => totalSliders - 1 - 0.3;

  double get startOpacity => totalSliders - 1 - 0.2;
}
