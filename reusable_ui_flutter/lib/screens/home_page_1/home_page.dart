import 'package:flutter/material.dart';
import 'package:reusable_ui_flutter/widgets/widgets.dart'
    show InputTextWidget, EleventhButton;

class HomeBasicPage extends StatelessWidget {
  /// default constructor
  const HomeBasicPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          _HeaderWidget(),
          Expanded(child: Center(child: Text('CONTENT'))),
          _BottomBar()
        ],
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 15,
            color: Colors.grey.shade400,
          ),
        ],
      ),
      child: SizedBox(
        width: size.width,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 50,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Icon(
                  Icons.book,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: EleventhButton(
                  label: 'Select',
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  radius: 40,
                  primaryColor: Colors.amber,
                  accentColor: Colors.white,
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 250,
          color: Colors.amber,
        ),
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: _TopBar(),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Courses',
                  style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 15.0),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Pick your learning path',
                  style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              _SearchBox(),
            ],
          ),
        ),
      ],
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: Alignment.topLeft,
          height: 45.0,
          width: 45.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(
                color: Colors.white, style: BorderStyle.solid, width: 2.0),
            image: const DecorationImage(
              image: AssetImage('assets/logo.png'),
            ),
          ),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.favorite),
          onPressed: () {},
          color: Colors.white,
          iconSize: 30.0,
        ),
      ],
    );
  }
}

class _SearchBox extends StatelessWidget {
  const _SearchBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 20,
      ),
      child: InputTextWidget(
        hint: 'Search for anything',
        leadingIcon: Icons.search,
        borderColor: Colors.white,
        background: const Color(0xFFF5F5F7),
        rounded: 40,
        boxShadow: BoxShadow(
          color: Colors.grey.shade500,
          blurRadius: 15,
        ),
        onChanged: (value) {},
      ),
    );
  }
}
