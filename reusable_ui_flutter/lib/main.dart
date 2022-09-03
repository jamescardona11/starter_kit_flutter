import 'package:flutter/material.dart';

import 'screens/login_page/login_page.dart';
import 'screens/onboarding_1/onboarding_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: IndexPage(),
    );
  }
}

class IndexPage extends StatelessWidget {
  /// default constructor
  IndexPage({
    super.key,
  });

  final Map<String, Widget> screens = {
    'Onboarding #1 (only UI)': const OnboardingPage(),
    'Basic Login (only UI)': const LoginPage(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reusable Widgets'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 10,
        ),
        child: ListView.builder(
          itemCount: screens.length,
          itemBuilder: (_, index) {
            final key = screens.keys.elementAt(index);

            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => screens[key]!));
                },
                title: Text(key),
              ),
            );
          },
        ),
      ),
    );
  }
}
