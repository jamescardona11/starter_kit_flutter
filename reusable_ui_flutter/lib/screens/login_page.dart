import 'package:flutter/material.dart';

import '../config/config.dart';
import '../widgets/custom_button_widget.dart';
import '../widgets/input_text_widget.dart';

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
                hint: 'Ingresa tu email',
                leadingIcon: Icons.email,
                onChanged: (value) {},
              ),
              const SizedBox(height: 15),
              InputTextWidget.password(
                hint: 'Ingresa tu contraseña',
                leadingIcon: Icons.lock,
                obscureText: true,
                onChanged: (value) {},
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  primary: kGrayLightColor,
                ),
                child: const Text('¿Olvido la contraseña?'),
              ),
              const Spacer(),
              CustomButton(
                width: size.width,
                label: 'Iniciar',
                primaryColor: kPrimaryColor,
                splashColor: kBlueLightColor,
                textColor: kWhiteColor,
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
