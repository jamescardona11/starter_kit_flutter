import 'package:base_ddd/app/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/round_text_form.dart';

class LoginBlocPage extends StatelessWidget {
  /// default constructor
  const LoginBlocPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build');
    final viewModel = LoginViewModel(context);

    // final state = context.watch<LoginBloc>();

    return Scaffold(
      appBar: AppBar(),
      body: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            RoundedTextForm(
              hintText: 'Your email',
              icon: Icons.email,
              onChanged: viewModel.onChangeEmail,
              validator: '',
            ),
            RoundedTextForm(
              hintText: 'Your password',
              icon: Icons.lock,
              suffixIcon: Icons.visibility,
              onChanged: viewModel.onChangePassword,
              validator: '',
            ),
            BlocSelector<LoginBloc, LoginState, bool>(
              selector: (state) {
                print('Select: $state');
                return state is LoginState1;
              },
              builder: (context, state) {
                print('state $state');
                return const Text('state');
              },
            ),
            Builder(builder: (context) {
              print('entro a');
              final a = context
                  .select((LoginBloc b) => (b.state is LoginState2).toString());
              return Text(a);
            })
          ],
        ),
      ),
    );
  }
}

class LoginViewModel {
  LoginViewModel(this.context);

  final BuildContext context;

  void onChangeEmail(String value) {
    context.read<LoginBloc>().add(LoginEmailOnChange());
  }

  void onChangePassword(String value) {
    context.read<LoginBloc>().add(LoginPasswordOnChange());
  }
}
