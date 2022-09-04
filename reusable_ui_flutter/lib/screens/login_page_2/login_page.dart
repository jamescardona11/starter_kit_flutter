import 'package:flutter/material.dart';

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
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Container(
                      color: Color(0xfff5f5f5),
                      child: TextFormField(
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'SFUIDisplay'),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Username',
                            prefixIcon: Icon(Icons.person_outline),
                            labelStyle: TextStyle(fontSize: 15)),
                      ),
                    ),
                  ),
                  Container(
                    color: Color(0xfff5f5f5),
                    child: TextFormField(
                      obscureText: true,
                      style: TextStyle(
                          color: Colors.black, fontFamily: 'SFUIDisplay'),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock_outline),
                          labelStyle: TextStyle(fontSize: 15)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: MaterialButton(
                      onPressed: () {}, //since this is only a UI app
                      child: Text(
                        'SIGN IN',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'SFUIDisplay',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: Color(0xffff2d55),
                      elevation: 0,
                      minWidth: 400,
                      height: 50,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Center(
                      child: Text(
                        'Forgot your password?',
                        style: TextStyle(
                            fontFamily: 'SFUIDisplay',
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Center(
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Don't have an account?",
                              style: TextStyle(
                                fontFamily: 'SFUIDisplay',
                                color: Colors.black,
                                fontSize: 15,
                              )),
                          TextSpan(
                              text: "sign up",
                              style: TextStyle(
                                fontFamily: 'SFUIDisplay',
                                color: Color(0xffff2d55),
                                fontSize: 15,
                              ))
                        ]),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          // Expanded(
          //   flex: 3,
          //   child: Container(
          //     decoration: BoxDecoration(
          //       image: DecorationImage(
          //         image: AssetImage(background),
          //         fit: BoxFit.cover,
          //         alignment: Alignment.bottomCenter,
          //       ),
          //     ),
          //   ),
          // ),
          // Expanded(
          //   flex: 4,
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 16),
          //     child: Column(
          //       children: [
          //         // Row(
          //         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         //   children: [
          //         //     Text(
          //         //       "SIGN IN",
          //         //       style: Theme.of(context).textTheme.bodyText1,
          //         //     ),
          //         //     Text(
          //         //       "SIGN UP",
          //         //       style: Theme.of(context).textTheme.button,
          //         //     ),
          //         //   ],
          //         // ),
          //         Spacer(),
          //         Padding(
          //           padding: const EdgeInsets.only(bottom: 40),
          //           child: Row(
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: [
          //               Padding(
          //                 padding: const EdgeInsets.only(right: 16),
          //                 child: Icon(
          //                   Icons.alternate_email,
          //                   color: kPrimaryColor,
          //                 ),
          //               ),
          //               Expanded(
          //                 child: TextField(
          //                   decoration: InputDecoration(
          //                     hintText: 'Email Address',
          //                   ),
          //                 ),
          //               )
          //             ],
          //           ),
          //         ),
          //         Row(
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             Padding(
          //               padding: const EdgeInsets.only(right: 16),
          //               child: Icon(
          //                 Icons.lock,
          //                 color: kPrimaryColor,
          //               ),
          //             ),
          //             Expanded(
          //               child: TextField(
          //                 decoration: InputDecoration(
          //                   hintText: 'Password',
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //         Spacer(),
          //         Padding(
          //           padding: const EdgeInsets.only(bottom: 30),
          //           child: Row(
          //             children: [
          //               Container(
          //                 padding: EdgeInsets.all(16),
          //                 decoration: BoxDecoration(
          //                   shape: BoxShape.circle,
          //                   border: Border.all(
          //                     color: Colors.white.withOpacity(.5),
          //                   ),
          //                 ),
          //                 child: Icon(
          //                   Icons.facebook,
          //                   color: Colors.white.withOpacity(.5),
          //                 ),
          //               ),
          //               SizedBox(width: 20),
          //               Container(
          //                 padding: EdgeInsets.all(16),
          //                 decoration: BoxDecoration(
          //                   shape: BoxShape.circle,
          //                   border: Border.all(
          //                     color: Colors.white.withOpacity(.5),
          //                   ),
          //                 ),
          //                 child: Icon(
          //                   Icons.facebook,
          //                   color: Colors.white.withOpacity(.5),
          //                 ),
          //               ),
          //               Spacer(),
          //               Container(
          //                 padding: EdgeInsets.all(16),
          //                 decoration: BoxDecoration(
          //                   shape: BoxShape.circle,
          //                   color: kPrimaryColor,
          //                 ),
          //                 child: Icon(
          //                   Icons.arrow_forward,
          //                   color: Colors.black,
          //                 ),
          //               )
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
