/// [flutter]
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:reusable_ui_flutter/colors.dart';
import 'package:reusable_ui_flutter/dimens.dart';
import 'package:reusable_ui_flutter/responsive_extension.dart';
import 'package:provider/provider.dart';

import '../widgets/buttons/yuno_button_widget.dart';

/// [local]
import '../widgets/input_text_field_widget.dart';
import 'auth_ui_provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: const [
          _AuthBackgroundView(),
          _AuthLoginCardView(),
          _AuthRegisterCardView(),
        ],
      ),
    );
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authUIProvider = context.watch<AuthUIProvider>();
    final width = authUIProvider.loginSize.width * context.widthPx;
    final height = authUIProvider.loginSize.height * context.heightPct(70);

    return KeyboardVisibilityBuilder(
      builder: (_, isKeyboardVisible) => AnimatedContainer(
        width: width,
        height: !isKeyboardVisible ? height : context.heightPx,
        duration: const Duration(milliseconds: 800),
        padding: const EdgeInsets.all(30.0),
        curve: Curves.fastLinearToSlowEaseIn,
        decoration: BoxDecoration(
          color: kCreamColor.withOpacity(authUIProvider.opacity),
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
              'Login para continuar',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: kBlueColor,
                  ),
            ),
            kSpaceMediumVertical,
            kSpaceLittleVertical,
            const InputTextWidget(
              hint: 'Ingresa tu email',
              icon: Icons.email,
            ),
            kSpaceMediumVertical,
            const InputTextWidget(
              hint: 'Ingresa tu contraseña',
              icon: Icons.lock,
              obscureText: true,
            ),
            const Spacer(),
            YunoButton(
              onPressed: () {},
              label: 'Login',
            ),
            kSpaceMediumVertical,
            YunoButton(
              onPressed: () {
                context.read<AuthUIProvider>().onOpenRegisterCard();
              },
              label: 'Crear nueva cuenta',
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isRegisterCardOpen =
        context.watch<AuthUIProvider>().isRegisterCardOpen;

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
              'Crear nueva cuenta',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: kBlueColor,
                  ),
            ),
            kSpaceMediumVertical,
            kSpaceLittleVertical,
            const InputTextWidget(
              hint: 'Ingresa tu email',
              icon: Icons.email,
            ),
            kSpaceMediumVertical,
            const InputTextWidget(
              hint: 'Ingresa tu contraseña',
              icon: Icons.lock,
              obscureText: true,
            ),
            const Spacer(),
            YunoButton(
              onPressed: () {},
              label: 'Crear nueva cuenta',
            ),
            kSpaceMediumVertical,
            YunoButton(
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                context.read<AuthUIProvider>().onCloseRegisterCard();
              },
              label: 'Volver al Login',
              fill: false,
            ),
          ],
        ),
      ),
    );
  }
}
