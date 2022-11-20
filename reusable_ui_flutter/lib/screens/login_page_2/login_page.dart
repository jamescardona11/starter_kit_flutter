import 'package:flutter/material.dart';
import 'package:reusable_ui_flutter/widgets/widgets.dart'
    show EleventhButton, InputTextWidget, LeadingIconConfig;

import 'const.dart';

class LoginPageV2 extends StatelessWidget {
  // default constructor
  const LoginPageV2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(background),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter),
            ),
          ),
          Container(
            width: size.width,
            margin: const EdgeInsets.only(top: 270),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  InputTextWidget(
                    label: 'Username',
                    leading: const LeadingIconConfig(
                      Icons.person_outline,
                      defaultIconColor: kGrayColor,
                    ),
                    cursorColor: kGrayLightColor,
                  ),
                  const SizedBox(height: 20),
                  InputTextWidget(
                    label: 'Password',
                    leading: const LeadingIconConfig(
                      Icons.lock_outline,
                      defaultIconColor: kGrayColor,
                    ),
                    cursorColor: kGrayLightColor,
                  ),
                  SizedBox(
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: EleventhButton(
                        label: 'SIGN IN',
                        primaryColor: kPrimaryColor,
                        accentColor: Colors.white,
                        onPressed: () {},
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Center(
                      child: Text(
                        'Forgot your password?',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Center(
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                                text: "Don't have an account?",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                )),
                            TextSpan(
                              text: " sign up",
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
