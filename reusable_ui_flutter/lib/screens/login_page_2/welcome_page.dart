import 'package:flutter/material.dart';
import 'package:reusable_ui_flutter/widgets/widgets.dart' show EleventhButton;

import 'const.dart';
import 'login_page.dart';

class WelcomePageLogin2 extends StatelessWidget {
  const WelcomePageLogin2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(background),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'SPACE LESSONS\n',
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'MASTER THE ART OF SPACE',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  FittedBox(
                    child: EleventhButton(
                      label: 'START LEARNING',
                      primaryColor: kPrimaryColor,
                      icon: Icons.arrow_forward,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const LoginPageV2();
                          },
                        ));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
