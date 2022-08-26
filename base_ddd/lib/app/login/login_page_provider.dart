import 'package:flutter/material.dart';

import 'widgets/round_text_form.dart';

class LoginPage extends StatelessWidget {
  /// default constructor
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            RoundedTextForm(
              hintText: 'Your email',
              icon: Icons.email,
              onChanged: (value) {},
              validator: '',
            ),
            RoundedTextForm(
              hintText: 'Your password',
              icon: Icons.lock,
              suffixIcon: Icons.visibility,
              onChanged: (value) {},
              validator: '',
            ),
          ],
        ),
      ),
    );
  }
}

class LoginViewModel {
  LoginViewModel(this.context);

  final BuildContext context;

  void onChangeEmail(String value) {}

  void onChangePassword(String value) {}
}
