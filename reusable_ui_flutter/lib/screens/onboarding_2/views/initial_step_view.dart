import 'package:flutter/material.dart';
import 'package:reusable_ui_flutter/widgets/buttons/eleventh_button_widget.dart';

import '../const.dart';

class InitialStepView extends StatelessWidget {
  const InitialStepView({
    Key? key,
    required this.onStartPressed,
  }) : super(key: key);

  final VoidCallback onStartPressed;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              bgInitialStepImg,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text(
              'Yuno',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 33,
                  ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 64, right: 64),
            child: Text(
              'El lugar que necesitas para sumergirte en un universo de cripto.\n Descubre el potencial.',
              textAlign: TextAlign.center,
            ),
          ),
          kSpaceBigVertical,
          EleventhButton(
            onPressed: onStartPressed,
            label: 'Empecemos',
          ),
        ],
      ),
    );
  }
}
