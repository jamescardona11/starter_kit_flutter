import 'package:flutter/material.dart';
import 'package:reusable_ui_flutter/widgets/widgets.dart';

import 'const.dart';

class LoginPageV2 extends StatelessWidget {
  /// default constructor
  const LoginPageV2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(background),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter),
            ),
          ),
          Container(
            width: size.width,
            margin: const EdgeInsets.only(top: 270),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Container(
                      color: const Color(0xfff5f5f5),
                      child: TextFormField(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black26,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: const Icon(
                            Icons.person_outline,
                            color: kGrayColor,
                          ),
                          labelStyle: const TextStyle(
                            fontSize: 15,
                            color: kGrayColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: const Color(0xfff5f5f5),
                    child: TextFormField(
                      obscureText: true,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black26,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Password',
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: kGrayColor,
                        ),
                        labelStyle: const TextStyle(
                          fontSize: 15,
                          color: kGrayColor,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: EleventhButton(
                      label: 'SIGN IN',
                      primaryColor: kPrimaryColor,
                      accentColor: Colors.white,
                      onPressed: () {},
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Center(
                      child: Text(
                        'Forgot your password?',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Center(
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                                text: "Don't have an account?",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                )),
                            TextSpan(
                              text: " sign up",
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
