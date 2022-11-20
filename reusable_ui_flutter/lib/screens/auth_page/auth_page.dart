// [flutter]
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusable_ui_flutter/config/responsive_extension.dart';
import 'package:reusable_ui_flutter/widgets/widgets.dart'
    show EleventhButton, InputTextWidget, LeadingIconConfig;

import 'const.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  double loginSizeWidth = 1;
  double loginSizeHeight = 1;
  double opacity = 1;
  bool isRegisterCardOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          const _AuthBackgroundView(),
          _AuthLoginCardView(
            onRegisterPressed: onOpenRegisterCard,
            loginSizeHeight: loginSizeHeight,
            loginSizeWidth: loginSizeWidth,
            opacity: opacity,
          ),
          _AuthRegisterCardView(
            isRegisterCardOpen: isRegisterCardOpen,
            onBackLogin: onCloseRegisterCard,
          ),
        ],
      ),
    );
  }

  void onOpenRegisterCard() {
    loginSizeWidth = 0.88;
    loginSizeHeight = 1.05;
    opacity = 0.7;
    isRegisterCardOpen = true;

    setState(() {});
  }

  void onCloseRegisterCard() {
    loginSizeWidth = 1;
    loginSizeHeight = 1;
    opacity = 1;

    isRegisterCardOpen = false;

    setState(() {});
  }
}

class _AuthBackgroundView extends StatelessWidget {
  const _AuthBackgroundView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.widthPx,
      height: context.heightPx,
      child: ColoredBox(
        color: kPrimaryColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: SizedBox(
                width: context.widthPx / 2,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Join us free.\n',
                    style: GoogleFonts.notoSans(
                      color: kWhiteColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: 'Dive into the crypto space, DEFI and NFTs',
                        style: GoogleFonts.notoSans(
                          fontSize: 20,
                          color: kWhiteColor,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthLoginCardView extends StatelessWidget {
  const _AuthLoginCardView({
    Key? key,
    required this.onRegisterPressed,
    required this.loginSizeWidth,
    required this.loginSizeHeight,
    required this.opacity,
  }) : super(key: key);

  final VoidCallback onRegisterPressed;

  final double loginSizeWidth;
  final double loginSizeHeight;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    final width = loginSizeWidth * context.widthPx;
    final height = loginSizeHeight * context.heightPct(70);

    return KeyboardVisibilityBuilder(
      builder: (_, isKeyboardVisible) => AnimatedContainer(
        width: width,
        height: !isKeyboardVisible ? height : context.heightPx,
        duration: const Duration(milliseconds: 800),
        padding: const EdgeInsets.all(30.0),
        curve: Curves.fastLinearToSlowEaseIn,
        decoration: BoxDecoration(
          color: kCreamColor.withOpacity(opacity),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isKeyboardVisible) kSpaceMediumVertical,
            Text(
              'Login to continue',
              textAlign: TextAlign.center,
              style: GoogleFonts.notoSans(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            kSpaceMediumVertical,
            kSpaceLittleVertical,
            const InputTextWidget(
              hint: 'Input your email',
              leading: LeadingIconConfig(Icons.email),
            ),
            kSpaceMediumVertical,
            const InputTextWidget(
              hint: 'Input your password',
              leading: LeadingIconConfig(Icons.lock),
              obscureText: true,
            ),
            const Spacer(),
            EleventhButton(
              label: 'Login',
              primaryColor: kPrimaryColor,
              accentColor: kCreamColor,
              onPressed: () {},
            ),
            kSpaceMediumVertical,
            EleventhButton(
              label: 'Create a new account',
              primaryColor: kPrimaryColor,
              accentColor: kCreamColor,
              onPressed: onRegisterPressed,
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthRegisterCardView extends StatelessWidget {
  const _AuthRegisterCardView({
    Key? key,
    required this.isRegisterCardOpen,
    required this.onBackLogin,
  }) : super(key: key);

  final bool isRegisterCardOpen;
  final VoidCallback onBackLogin;

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (_, isKeyboardVisible) => AnimatedContainer(
        width: context.widthPx,
        height: !isKeyboardVisible ? context.heightPct(70) : context.heightPx,
        padding: const EdgeInsets.all(30.0),
        decoration: const BoxDecoration(
          color: kCreamColor,
          borderRadius: BorderRadius.only(
            topLeft: radiusNormal,
            topRight: radiusNormal,
          ),
        ),
        duration: const Duration(milliseconds: 400),
        transform:
            Matrix4.translationValues(0, isRegisterCardOpen ? 0 : 700, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isKeyboardVisible) kSpaceMediumVertical,
            Text(
              'Create a new account',
              textAlign: TextAlign.center,
              style: GoogleFonts.notoSans(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            kSpaceMediumVertical,
            kSpaceLittleVertical,
            const InputTextWidget(
              hint: 'Input your email',
              leading: LeadingIconConfig(Icons.email),
            ),
            kSpaceMediumVertical,
            const InputTextWidget(
              hint: 'Input your password',
              leading: LeadingIconConfig(Icons.lock),
              obscureText: true,
            ),
            const Spacer(),
            EleventhButton(
              label: 'Create a new account',
              primaryColor: kPrimaryColor,
              accentColor: kCreamColor,
              onPressed: () {},
            ),
            kSpaceMediumVertical,
            EleventhButton(
              label: 'Return to Login',
              primaryColor: kPrimaryColor,
              accentColor: kCreamColor,
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                onBackLogin();
              },
            ),
          ],
        ),
      ),
    );
  }
}
