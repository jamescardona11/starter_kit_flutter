import 'package:flutter/material.dart';
import 'package:reusable_ui_flutter/widgets/widgets.dart'
    show InputTextWidget, ArcBottomBar, ArcBottomBarType, BottomElevenItem;

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
          Expanded(
            child: Center(
              child: Text('CONTENT'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ArcBottomBar(
        activeColor: Colors.amber,
        type: ArcBottomBarType.changeToText,
        items: [
          BottomElevenItem(
            label: 'Home',
            icon: Icons.home,
          ),
          BottomElevenItem(
            label: 'Search',
            icon: Icons.search,
          ),
          BottomElevenItem(
            label: 'Settings',
            icon: Icons.settings,
          ),
        ],
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
        borderRadius: 40,
        boxShadow: BoxShadow(
          color: Colors.grey.shade500,
          blurRadius: 15,
        ),
        onChanged: (value) {},
      ),
    );
  }
}
