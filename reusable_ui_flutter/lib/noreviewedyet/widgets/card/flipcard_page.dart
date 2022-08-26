import 'package:flutter/material.dart';

import 'widget/flipcard_widget.dart';

class FlipCardPage extends StatefulWidget {
  static const String pageRoute = 'flipcard_page_route_id';

  @override
  _FlipCardPageState createState() => _FlipCardPageState();
}

class _FlipCardPageState extends State<FlipCardPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: SizedBox(
            width: 500,
            height: 270,
            child: FlipCardWidget(
              controllerFlipCard: animationController,
              background: BackgroundConfig(
                image: const AssetImage('assets/bg4.jpeg'),
                borderRadius: BorderRadius.circular(25),
              ),
              frontFaceWidget: const Center(
                child:
                    Text('FRONT FACE', style: TextStyle(color: Colors.white)),
              ),
              backFaceWidget: const Center(
                child: Text('BACK FACE', style: TextStyle(color: Colors.white)),
              ),
              height: 200,
              width: 400,
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: GlobalKey(),
            onPressed: () {
              animationController.reverse();
            },
            child: const Icon(Icons.arrow_back),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            heroTag: GlobalKey(),
            onPressed: () {
              animationController.forward();
            },
            child: const Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }
}
