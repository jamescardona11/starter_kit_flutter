import 'package:flutter/material.dart';

import 'widgets/steps_view.dart';

const kBlackColor = Color(0xff2E2C3C);
const imgManagement = 'assets/management.png';
const imgSavetime = 'assets/save_time.png';
const imgStatistics = 'assets/statistics.png';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
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

    return Scaffold(
      backgroundColor: kBlackColor,
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            // physics: const BouncingScrollPhysics(),
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
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Padding(
          //     padding: const EdgeInsets.only(bottom: 50),
          //     child: Stack(
          //       alignment: Alignment.center,
          //       children: [
          //         // Visibility(
          //         //   visible: currentPage.value < 1.7,
          //         //   child: SmoothPageIndicator(
          //         //     controller: pageController,
          //         //     count: 3,
          //         //     effect: WormEffect(
          //         //       dotColor: kGrayLightColor,
          //         //       activeDotColor: kWhiteColor,
          //         //       dotWidth: 14,
          //         //       dotHeight: 14,
          //         //     ),
          //         //   ),
          //         // ),
          //         AnimatedOpacity(
          //           opacity:
          //               currentPage.value > 1.8 ? currentPage.value / 2 : 0,
          //           duration: const Duration(milliseconds: 250),
          //           child: SizedBox(
          //             width: 140,
          //             child: ElevatedButton.icon(
          //               style: ButtonStyle(
          //                 backgroundColor:
          //                     MaterialStateProperty.all<Color>(kWhiteColor),
          //               ),
          //               icon: const Icon(Icons.done),
          //               label: const Text(
          //                 'Continue',
          //               ),
          //               onPressed: () {},
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
