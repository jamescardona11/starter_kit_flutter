import 'package:flutter/material.dart';
import 'package:reusable_ui_flutter/config/config.dart';

import 'steps/management_view.dart';
import 'steps/savetime_view.dart';
import 'steps/statistics_view.dart';

const kBlackColor = Color(0xff2E2C3C);

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
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
                imageAssets: AssetsManager.imgManagement,
                iconData: Icons.manage_accounts,
              ),
              SaveTimeView(),
              StatisticsView(),
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
