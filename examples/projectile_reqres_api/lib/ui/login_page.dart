import 'package:flutter/material.dart';

import 'const.dart';
import 'widgets/eleventh_button_widget.dart';
import 'widgets/input_text_widget.dart';

class LoginPage extends StatelessWidget {
  /// default constructor
  const LoginPage({
    super.key,
  });

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
                child: Center(
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset(logoImg),
                  ),
                ),
              ),
              InputTextWidget(
                hint: 'Enter your email',
                leadingIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {},
              ),
              const SizedBox(height: 15),
              InputTextWidget.password(
                hint: 'Enter your password',
                leadingIcon: Icons.lock,
                obscureText: true,
                onChanged: (value) {},
              ),
              const SizedBox(height: 35),
              EleventhButton(
                width: size.width,
                label: 'Login',
                primaryColor: kPrimaryColor,
                splashColor: kBlueColor,
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
