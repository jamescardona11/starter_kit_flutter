// import 'package:flutter/material.dart';
// import 'package:animations/animations.dart';
// import 'package:reusable_ui_flutter/colors.dart';
// import 'package:reusable_ui_flutter/dimens.dart';

// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class NextTransformationButtonWidget extends StatefulWidget {
//   const NextTransformationButtonWidget({
//     Key? key,
//     required this.pageController,
//     required this.pagesAmount,
//   }) : super(key: key);

//   final PageController pageController;
//   final int pagesAmount;

//   @override
//   State<NextTransformationButtonWidget> createState() =>
//       _NextTransformationButtonWidgetState();
// }

// class _NextTransformationButtonWidgetState
//     extends State<NextTransformationButtonWidget>
//     with SingleTickerProviderStateMixin {
//   late AnimationController animationController;
//   late Animation<double> _signUpMoveAnimation;
//   late Animation<Offset> _loginTextMoveAnimation;

//   @override
//   void initState() {
//     super.initState();

//     animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 480),
//     );

//     initAnimations();

//     final delta = widget.pagesAmount - 1.5;

//     widget.pageController.addListener(() {
//       final page = widget.pageController.page ?? 0;

//       if (page > delta) {
//         animationController.forward();
//       } else if (page <= delta) {
//         animationController.reverse();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(top: kSpaceMax, bottom: kSpaceSmall),
//           child: SmoothPageIndicator(
//             controller: widget.pageController,
//             count: widget.pagesAmount,
//             effect: WormEffect(
//               dotColor: kGrayLightColor,
//               activeDotColor: kBlueColor,
//               dotWidth: 12,
//               dotHeight: 12,
//             ),
//           ),
//         ),
//         AnimatedBuilder(
//           animation: animationController,
//           builder: (context, child) => PageTransitionSwitcher(
//             duration: const Duration(milliseconds: 480),
//             reverse: _signUpMoveAnimation.value < 0.7,
//             transitionBuilder: (
//               Widget child,
//               Animation<double> animation,
//               Animation<double> secondaryAnimation,
//             ) {
//               return SharedAxisTransition(
//                 fillColor: Colors.transparent,
//                 animation: animation,
//                 secondaryAnimation: secondaryAnimation,
//                 transitionType: SharedAxisTransitionType.vertical,
//                 child: child,
//               );
//             },
//             child: SizedBox(
//               width: 58 + (200 * _signUpMoveAnimation.value),
//               height: 58,
//               child: OutlinedButton(
//                 key: const ValueKey('next_button'),
//                 onPressed: () {
//                   final page = widget.pageController.page!;
//                   if (page == widget.pagesAmount - 1) {
//                     // context.go(Routes.home);
//                   } else {
//                     widget.pageController.animateToPage(
//                       page.toInt() + 1,
//                       duration: const Duration(milliseconds: 500),
//                       curve: Curves.easeInOut,
//                     );
//                   }
//                 },
//                 style: getButtonStyle(_signUpMoveAnimation.value < 0.7),
//                 child: _signUpMoveAnimation.value < 0.7
//                     ? onlyIcon()
//                     : iconAndText(),
//               ),
//             ),
//           ),
//         ),
//         Builder(
//           builder: (context) {
//             final textStyle = Theme.of(context).textTheme.bodyText2!;
//             return Padding(
//               padding: const EdgeInsets.only(top: 8),
//               child: SlideTransition(
//                 position: _loginTextMoveAnimation,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       '¿Ya tienes cuenta? ',
//                       style: textStyle.copyWith(color: kGrayColor),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         // context.push(Routes.auth);
//                       },
//                       child: Text(
//                         'Login',
//                         style: textStyle.copyWith(
//                           color: kPrimaryColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }

//   ButtonStyle getButtonStyle(bool showCircle) => OutlinedButton.styleFrom(
//         shape: showCircle
//             ? const CircleBorder()
//             : RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//         primary: kWhiteColor,
//         backgroundColor: kPrimaryColor,
//       );

//   Widget onlyIcon() => const Icon(
//         Icons.arrow_forward_ios_rounded,
//         color: kCreamColor,
//       );

//   Widget iconAndText() => Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             'Continuar',
//             style: Theme.of(context).textTheme.headline3!.copyWith(
//                   fontSize: 20,
//                   color: kCreamColor,
//                 ),
//           ),
//           const Icon(
//             Icons.arrow_forward_rounded,
//             color: kCreamColor,
//           ),
//         ],
//       );

//   @override
//   void dispose() {
//     animationController.dispose();
//     super.dispose();
//   }

//   void initAnimations() {
//     _signUpMoveAnimation =
//         Tween<double>(begin: 0, end: 1.0).animate(CurvedAnimation(
//       parent: animationController,
//       curve: const Interval(
//         0.0,
//         0.7,
//         curve: Curves.fastOutSlowIn,
//       ),
//     ));

//     _loginTextMoveAnimation =
//         Tween<Offset>(begin: const Offset(0, 8), end: const Offset(0, 0))
//             .animate(CurvedAnimation(
//       parent: animationController,
//       curve: const Interval(
//         0.3,
//         0.6,
//         curve: Curves.fastOutSlowIn,
//       ),
//     ));
//   }
// }
