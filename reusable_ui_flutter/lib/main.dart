import 'package:flutter/material.dart';
import 'package:reusable_ui_flutter/widgets/widgets.dart';

import 'screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: IndexPage(),
    );
  }
}

class IndexPage extends StatelessWidget {
  /// default constructor
  const IndexPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reusable UI'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 100,
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ScreenPage()));
                  },
                  child: const Card(
                    child: Center(
                        child: Text(
                      'Screens',
                      style: TextStyle(fontSize: 25),
                    )),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 120,
                height: 100,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WidgetsPage(),
                      ),
                    );
                  },
                  child: const Card(
                    child: Center(
                        child: Text(
                      'Widgets',
                      style: TextStyle(fontSize: 25),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScreenPage extends StatelessWidget {
  /// default constructor
  ScreenPage({
    super.key,
  });

  final Map<String, Widget> screens = {
    'Onboarding V1 (only UI)': const OnboardingPage(),
    'Onboarding V2 (only UI)': IntroPage(),
    'Basic Login V1 (only UI)': const LoginPageV1(),
    'Basic Login V2 (only UI)': const WelcomePageLogin2(),
    'AuthPage (only UI)': const AuthPage(),
    'Home Basic V1 (only UI)': const HomeBasicPage(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reusable Screen'),
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

class WidgetsPage extends StatefulWidget {
  /// default constructor
  const WidgetsPage({
    super.key,
  });

  @override
  State<WidgetsPage> createState() => _WidgetsPageState();
}

class _WidgetsPageState extends State<WidgetsPage>
    with TickerProviderStateMixin {
  Map<String, Widget> screens = {};
  Widget activeWidget = const Center(child: Text('Nothing'));

  late final AnimationController flipCardController;
  late final PageController pageController;
  final transform = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    flipCardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    pageController = PageController()
      ..addListener(() {
        // if (pageController.page! != currentPage.value) {
        //   currentPage.value = pageController.page!;
        // }
      });
  }

  void initScreens() {
    screens = {
      'Bee BottomBar': beeBottomBar(),
      'Arc BottomBar': arcBottomBar(),
      'Floating BottomBar': floatingBottomBar(),
      'CircularIconButton': circularIconButton(),
      'EleventhButton': eleventhButton(),
      'NextTransformation': nextTransformation(),
      'FlipCard': flipCard(),
      'RightClipper': rightClipper(),
      'MultiFab': multiFab(),
      'RowFab': rowFab(),
      'InputText': inputText(),
      'OutLineInputText': outLineInputText(),
      'PointsLoader': pointsLoader(),
      'BlurredContainer': blurredContainer(),
      'BouncedWrapper': bouncedWrapper(),
      'BuyBar': buyBar(),
      'LikeBar': likeBar(),
      'SliderDots': sliderDots(),
      'AppBarOption': appBarOption(),
      'SkipTopBar': skipTopBar(),
    };
  }

  @override
  Widget build(BuildContext context) {
    initScreens();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reusable Widgets'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: screens.length,
              itemBuilder: (_, index) {
                final key = screens.keys.elementAt(index);

                return Card(
                  child: ListTile(
                    onTap: () {
                      activeWidget = screens[key]!;
                      setState(() {});
                    },
                    title: Text(key),
                  ),
                );
              },
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          const Text('TEST AREA:'),
          Expanded(
            child: activeWidget,
          ),
        ],
      ),
    );
  }

  Widget beeBottomBar() => Scaffold(
        body: const Center(child: Text('BEE BOTTOM BAR')),
        bottomNavigationBar: BeeBottomBar(items: itemsBottomBar),
      );

  Widget arcBottomBar() => Scaffold(
        body: const Center(child: Text('ARC BOTTOM BAR')),
        bottomNavigationBar: ArcBottomBar(
          type: ArcBottomBarType.changeToText,
          items: itemsBottomBar,
        ),
      );

  Widget floatingBottomBar() => Scaffold(
        body: const Center(child: Text('FLOATING BOTTOM BAR')),
        bottomNavigationBar: FloatingBottomBar(items: itemsBottomBar),
      );

  Widget circularIconButton() => Scaffold(
        body: CircularIconButton(
          icon: Icons.near_me,
          onPressed: () {},
        ),
      );
  Widget eleventhButton() => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              EleventhButton(
                label: 'Button',
                primaryColor: Colors.black,
                accentColor: Colors.white,
                onPressed: () {},
              ),
              const SizedBox(height: 10),
              EleventhButton(
                label: 'Button',
                fill: false,
                primaryColor: Colors.black,
                accentColor: Colors.white,
                onPressed: () {},
              ),
              const SizedBox(height: 10),
              EleventhButton(
                label: 'START LEARNING',
                icon: Icons.arrow_forward,
                onPressed: () {},
              )
            ],
          ),
        ),
      );
  Widget nextTransformation() => Scaffold(
        body: SafeArea(
          child: Center(
            child: ValueListenableBuilder<bool>(
              valueListenable: transform,
              builder: (context, value, child) => NextTransformationButton(
                onNextPressed: () {
                  transform.value = !transform.value;
                },
                onTransformPressed: () {},
                topWidget: const Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: Text('Transform Widget'),
                ),
                forwardTransformation: value,
              ),
            ),
          ),
        ),
      );
  Widget flipCard() => Scaffold(
        body: Center(
          child: Column(
            children: [
              FlipCardWidget(
                height: 100,
                width: 200,
                controllerFlipCard: flipCardController,
                background: BackgroundConfig(
                  image: const AssetImage('assets/logo.png'),
                  borderRadius: BorderRadius.circular(25),
                ),
                frontFaceWidget: const Center(
                  child:
                      Text('FRONT FACE', style: TextStyle(color: Colors.white)),
                ),
                backFaceWidget: const Center(
                  child:
                      Text('BACK FACE', style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    heroTag: GlobalKey(),
                    onPressed: () {
                      flipCardController.reverse();
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 10),
                  FloatingActionButton(
                    heroTag: GlobalKey(),
                    onPressed: () {
                      flipCardController.forward();
                    },
                    child: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  Widget rightClipper() => const Scaffold(
        body: RightTriangleClipper(),
      );
  Widget multiFab() => Scaffold(
        body: const Center(child: Text('HOT RESTART BEFORE TESTING')),
        floatingActionButton: MultiFab(
          items: itemsFab,
        ),
      );
  Widget rowFab() => Scaffold(
        body: const Center(child: Text('RowFab')),
        floatingActionButton: RowFab(
          items: itemsFab,
        ),
      );

  Widget inputText() => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InputTextWidget(
            hint: 'Enter your email',
            leadingIcon: Icons.email,
            onChanged: (value) {},
          ),
        ),
      );
  Widget outLineInputText() => const Scaffold(
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: OutlineTextInput(
            label: 'Username',
            leadingIcon: Icons.person_outline,
            iconColor: Colors.black,
            cursorColor: Colors.black38,
          ),
        ),
      );
  Widget pointsLoader() => Scaffold(
        body: PointsLoader.triangle(),
      );
  Widget blurredContainer() => Scaffold(
        body: Column(
          children: [
            Center(
              child: BlurredContainer(
                width: 100,
                height: 100,
                opacity: 0.1,
                blur: 8,
                accentColor: Colors.pinkAccent,
                boxDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const FlutterLogo(size: 100),
              ),
            ),
          ],
        ),
      );
  Widget bouncedWrapper() => Scaffold(
        body: BounceWrapper(
          child: Container(
            width: 100,
            height: 40,
            color: Colors.amber,
            child: const Center(
              child: Text('Widget'),
            ),
          ),
        ),
      );
  Widget buyBar() => const Scaffold(
        body: CTABar(
          label: 'Buy item',
        ),
      );
  Widget likeBar() => const Scaffold(
        body: LikeBar(),
      );
  Widget sliderDots() => Scaffold(
        body: SliderDots(
          totalSlides: 3,
          controller: pageController,
          accentColor: Colors.grey,
          dotsSize: 12,
          dotsSpace: 5,
          primaryColor: Colors.pinkAccent,
          secondaryDotsSize: 15,
        ),
      );
  Widget appBarOption() => Scaffold(
        appBar: AppBar(
          actions: [
            FloatingOptions(
              elements: [
                const DrawerTile(
                  leading: Icon(Icons.cloud),
                  trailing: Icon(
                    Icons.brightness_1,
                    color: Colors.green,
                    size: 10,
                  ),
                  child: Text("Status: Online"),
                ),
                DrawerTile(
                  child: const Text("Games"),
                  leading: const Icon(Icons.gamepad),
                  trailing: const Icon(Icons.chevron_right),
                  children: List.generate(
                      2, (i) => DrawerTile(child: Text("${i + 1}"))),
                ),
                DrawerTile(
                  child: const Text("Friends"),
                  leading: const Icon(Icons.people),
                  trailing: const Icon(Icons.chevron_right),
                  children: List.generate(
                      5, (i) => DrawerTile(child: Text("${i + 1}"))),
                ),
                const DrawerTile(
                  leading: Icon(Icons.exit_to_app),
                  child: Text("Exit"),
                ),
              ],
            )
          ],
        ),
        body: const Center(child: Text('Appbar OPTIONS')),
      );
  Widget skipTopBar() => Scaffold(
        body: SkipTopBar(
          center: const Text('Center widget'),
          onBackClick: () {},
        ),
      );

  List<BottomElevenItem> get itemsBottomBar => [
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
      ];

  List<FabElevenItem> get itemsFab => [
        FabElevenItem.multi(
          onPressed: () {},
          icon: const Icon(Icons.home, color: Colors.white),
        ),
        FabElevenItem.multi(
          onPressed: () {},
          icon: const Icon(Icons.favorite, color: Colors.white),
        ),
        FabElevenItem.multi(
          onPressed: () {},
          icon: const Icon(Icons.person, color: Colors.white),
        ),
      ];
}
