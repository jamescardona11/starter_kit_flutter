/// [flutter]
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:reusable_ui_flutter/config/config.dart';

import '../../widgets/buttons/eleventh_button_widget.dart';
import '../../widgets/input/input_text_widget.dart';

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
            onOpenRegisterCard: onOpenRegisterCard,
            loginSizeHeight: loginSizeHeight,
            loginSizeWidth: loginSizeWidth,
            opacity: opacity,
          ),
          _AuthRegisterCardView(
            isRegisterCardOpen: isRegisterCardOpen,
            onCloseRegisterCard: onOpenRegisterCard,
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
                    text: 'Únete gratis.\n',
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: kWhiteColor, fontSize: 28),
                    children: [
                      TextSpan(
                          text: 'Sumergete en el espacio cripto, DEFI y NFTs',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: kWhiteColor))
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
    required this.onOpenRegisterCard,
    required this.loginSizeWidth,
    required this.loginSizeHeight,
    required this.opacity,
  }) : super(key: key);

  final VoidCallback onOpenRegisterCard;

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
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: kBlueColor,
                  ),
            ),
            kSpaceMediumVertical,
            kSpaceLittleVertical,
            const InputTextWidget(
              hint: 'Input your email',
              leadingIcon: Icons.email,
            ),
            kSpaceMediumVertical,
            const InputTextWidget(
              hint: 'Input your password',
              leadingIcon: Icons.lock,
              obscureText: true,
            ),
            const Spacer(),
            EleventhButton(
              onPressed: () {},
              label: 'Login',
            ),
            kSpaceMediumVertical,
            EleventhButton(
              onPressed: onOpenRegisterCard,
              label: 'Create a new account',
              fill: false,
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
    required this.onCloseRegisterCard,
  }) : super(key: key);

  final bool isRegisterCardOpen;
  final VoidCallback onCloseRegisterCard;

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
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: kBlueColor,
                  ),
            ),
            kSpaceMediumVertical,
            kSpaceLittleVertical,
            const InputTextWidget(
              hint: 'Input your email',
              leadingIcon: Icons.email,
            ),
            kSpaceMediumVertical,
            const InputTextWidget(
              hint: 'Input your password',
              leadingIcon: Icons.lock,
              obscureText: true,
            ),
            const Spacer(),
            EleventhButton(
              onPressed: () {},
              label: 'Create a new account',
            ),
            kSpaceMediumVertical,
            EleventhButton(
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                onCloseRegisterCard();
              },
              label: 'Return to Login',
              fill: false,
            ),
          ],
        ),
      ),
    );
  }
}
