import 'package:flutter/material.dart';
import 'package:reusable_ui_flutter/widgets/widgets.dart'
    show EleventhButton, InputTextWidget, LeadingIconConfig;

import 'const.dart';

class LoginPageV1 extends StatelessWidget {
  // default constructor
  const LoginPageV1({
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
                leading: const LeadingIconConfig(Icons.email),
                onChanged: (value) {},
              ),
              const SizedBox(height: 15),
              InputTextWidget(
                hint: 'Enter your password',
                leading: const LeadingIconConfig(Icons.lock),
                trailing: InputTextWidget.passwordIcon(color: kGrayLightColor2),
                obscureText: true,
                onChanged: (value) {},
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  primary: kPrimaryColor,
                ),
                child: const Text('¿Forgot password?'),
              ),
              const Spacer(),
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
