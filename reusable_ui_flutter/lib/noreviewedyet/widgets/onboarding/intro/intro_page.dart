/// [flutter]
import 'package:flutter/material.dart';
import 'package:reusable_ui_flutter/noreviewedyet/widgets/onboarding/intro/views/steps_view.dart';

import 'views/initial_step_view.dart';

class IntroPage extends StatelessWidget {
  IntroPage({Key? key}) : super(key: key);

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        controller: _controller,
        children: [
          InitialStepView(
            onStartPressed: () {
              _controller.animateToPage(
                1,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeInOut,
              );
            },
          ),
          StepsView(
            onReturnToInitial: () {
              _controller.animateToPage(
                0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
          ),
        ],
      ),
    );
  }
}
