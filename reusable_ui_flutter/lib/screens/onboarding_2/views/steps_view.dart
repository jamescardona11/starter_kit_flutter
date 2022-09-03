import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusable_ui_flutter/widgets/widgets.dart'
    show SkipTopBar, NextTransformationButton, SliderDots;

import '../const.dart';

class StepsView extends StatefulWidget {
  const StepsView({
    Key? key,
    required this.onReturnToInitial,
  }) : super(key: key);

  final VoidCallback onReturnToInitial;

  @override
  State<StepsView> createState() => _StepsViewState();
}

class _StepsViewState extends State<StepsView> {
  final pageController = PageController();
  final pagesAmount = 4;

  final currentPage = ValueNotifier<double>(0.0);
  final showSkip = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();

    pageController.addListener(() {
      final page = pageController.page ?? 0;

      if (page > delta) {
        showSkip.value = false;
      } else if (page <= delta) {
        showSkip.value = true;
      }

      currentPage.value = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: pageController,
          physics: const BouncingScrollPhysics(),
          children: const [
            _CustomStepView(
              title: 'Aprender',
              label:
                  'Usa nuestra herramienta para aprender y adquirir conocimientos del mundo cripto.',
              imagePath: learningImg,
              leftToRight: false,
            ),
            _CustomStepView(
              title: 'Invertir',
              label:
                  'Aprende a invertir o usa nuestras herramientas para que accedas al mundo de las finanzas decentralizadas.',
              imagePath: investImg,
            ),
            _CustomStepView(
              title: 'Relájate',
              label:
                  'Sigue todos los movimientos de tu cartera, recibe alertas y notificaciones.\nHacemos el trabajo duro por ti.',
              imagePath: meditateImg,
            ),
            _CustomStepView(
              title: 'Bienvenido!',
              label:
                  'Empezar este viaje con nosotros es un honor. Vamos a dar lo mejor para cumplir tus expectativas.',
              imagePath: welcomeImg,
              positionWidgets: [2, 0, 1],
              intervals: [1, 2, 0],
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ValueListenableBuilder<double>(
            valueListenable: currentPage,
            builder: (_, page, __) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 110),
                child: NextTransformationButton(
                  background: kPrimaryColor,
                  accentColor: Colors.white,
                  onNextPressed: () {
                    if (page != pagesAmount - 1) {
                      pageController.animateToPage(
                        page.floor() + 1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  onTransformPressed: () {
                    // GO TO HOME
                  },
                  forwardTransformation: page > delta,
                  reverseTransformation: page <= delta,
                  topWidget: Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: SliderDots(
                      totalSlides: pagesAmount,
                      controller: pageController,
                      accentColor: Colors.grey,
                      dotsSize: 12,
                      dotsSpace: 5,
                      secondaryDotsSize: 15,
                      primaryColor: kPrimaryColor,
                    ),
                  ),
                  bottomWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '¿Ya tienes cuenta? ',
                        style: GoogleFonts.monda(
                          fontSize: 14,
                          color: kBlackColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // LOGIN
                        },
                        child: Text(
                          'Login',
                          style: GoogleFonts.monda(
                            fontSize: 14,
                            color: kBlackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: showSkip,
          builder: (_, value, __) => SkipTopBar(
            showSkip: value,
            onBackClick: () {
              final page = (pageController.page ?? 0) - 1;
              if (page < 0) {
                widget.onReturnToInitial.call();
              } else {
                pageController.animateToPage(
                  page.toInt(),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              }
            },
            onSkipClick: () {
              pageController.animateToPage(
                pagesAmount - 1,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
          ),
        )
      ],
    );
  }

  double get delta => pagesAmount - 1.5;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

class _CustomStepView extends StatefulWidget {
  const _CustomStepView({
    Key? key,
    required this.title,
    required this.label,
    required this.imagePath,
    this.leftToRight = true,
    this.positionWidgets = const [0, 1, 2],
    this.intervals = const [0, 1, 2],
  }) : super(key: key);

  final String title;
  final String label;
  final String imagePath;
  final bool leftToRight;
  final List<int> positionWidgets; // [0] = title, [1] = label, [2] = [image]
  final List<int> intervals; // [0] = Fast, [1] = Medium, [2] = Slow

  @override
  State<_CustomStepView> createState() => _CustomStepViewState();
}

class _CustomStepViewState extends State<_CustomStepView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> titleAnimation;
  late Animation<Offset> labelAnimation;
  late Animation<Offset> imageAnimation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    initAnimations();

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final widgets = [
      SlideTransition(
        position: titleAnimation,
        child: Text(
          widget.title,
          style: GoogleFonts.notoSans(
            fontSize: 26,
            color: kBlackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SlideTransition(
        position: labelAnimation,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 64,
            right: 64,
            top: 16,
            bottom: 32,
          ),
          child: Text(
            widget.label,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      SlideTransition(
        position: imageAnimation,
        child: SizedBox(
          width: 350,
          height: 250,
          child: Image.asset(
            widget.imagePath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: kSpaceMax),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widgets[widget.positionWidgets[0]],
          widgets[widget.positionWidgets[1]],
          widgets[widget.positionWidgets[2]],
        ],
      ),
    );
  }

  void initAnimations() {
    final Offset begin =
        widget.leftToRight ? const Offset(2, 0) : const Offset(0, 2);
    const Offset end = Offset(0, 0);

    final intervals = [
      const Interval(0.2, 0.6, curve: Curves.fastOutSlowIn),
      const Interval(0.3, 0.7, curve: Curves.fastOutSlowIn),
      const Interval(0.3, 1.0, curve: Curves.fastOutSlowIn),
    ];

    titleAnimation = Tween<Offset>(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: animationController,
        curve: intervals[widget.intervals[0]],
      ),
    );

    labelAnimation = Tween<Offset>(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: animationController,
        curve: intervals[widget.intervals[1]],
      ),
    );
    imageAnimation = Tween<Offset>(
            begin:
                widget.leftToRight ? const Offset(2, 0) : const Offset(-2, 0),
            end: end)
        .animate(
      CurvedAnimation(
        parent: animationController,
        curve: intervals[widget.intervals[2]],
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
