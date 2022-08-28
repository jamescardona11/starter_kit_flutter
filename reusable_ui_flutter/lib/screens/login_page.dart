import 'package:flutter/material.dart';

import '../config/config.dart';
import '../widgets/buttons/eleventh_button_widget.dart';
import '../widgets/input/input_text_widget.dart';

class LoginPage extends StatelessWidget {
  /// default constructor
  const LoginPage({
    super.key,
  });

  final String logoImg = AssetsManager.imgLogo;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 80.0,
                  horizontal: 60,
                ),
                child: Image.asset(logoImg),
              ),
              InputTextWidget(
                hint: 'Enter your email',
                leadingIcon: Icons.email,
                onChanged: (value) {},
              ),
              const SizedBox(height: 15),
              InputTextWidget.password(
                hint: 'Enter your password',
                leadingIcon: Icons.lock,
                obscureText: true,
                onChanged: (value) {},
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  primary: kGrayLightColor,
                ),
                child: const Text('¿Forgot password?'),
              ),
              const Spacer(),
              EleventhButton(
                width: size.width,
                label: 'Login',
                primaryColor: kPrimaryColor,
                splashColor: kBlueLightColor,
                accentColor: kWhiteColor,
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
