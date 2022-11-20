import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//
//```
// appBar: AppBar(
//   actions: [
//     FloatingOptions(
//       elements: [
//         const DrawerTile(
//           leading: Icon(Icons.cloud),
//           trailing: Icon(
//             Icons.brightness_1,
//             color: Colors.green,
//             size: 10,
//           ),
//           child: Text("Status: Online"),
//         ),
//         DrawerTile(
//           child: const Text("Games"),
//           leading: const Icon(Icons.gamepad),
//           trailing: const Icon(Icons.chevron_right),
//           children: List.generate(
//               2, (i) => DrawerTile(child: Text("${i + 1}"))),
//         ),
//         DrawerTile(
//           child: const Text("Friends"),
//           leading: const Icon(Icons.people),
//           trailing: const Icon(Icons.chevron_right),
//           children: List.generate(
//               5, (i) => DrawerTile(child: Text("${i + 1}"))),
//         ),
//         const DrawerTile(
//           leading: Icon(Icons.exit_to_app),
//           child: Text("Exit"),
//         ),
//       ],
//     )
//   ],
// )
// ```

class FloatingOptions extends StatelessWidget {
  const FloatingOptions({
    Key? key,
    required this.elements,
  }) : super(key: key);

  final List<DrawerTile> elements;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: Colors.transparent,
      elevation: 0,
      itemBuilder: (context) => [
        PopupMenuItem(
          child: SizedBox(
            width: 300,
            child: FloatingDrawer(
              separator: Container(
                width: double.infinity,
                height: 1,
                color: Colors.black12,
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              tiles: elements,
            ),
          ),
        )
      ],
    );
  }
}

class FloatingDrawer extends StatefulWidget {
  const FloatingDrawer({
    super.key,
    required this.tiles,
    this.color = Colors.white,
    this.separator = const Divider(height: 0),
    this.backTile = const DrawerTile(
      leading: Icon(Icons.chevron_left),
      child: Text("Back"),
    ),
    this.borderRadius,
  });

  final List<DrawerTile> tiles;
  final Color color;
  final Widget separator;
  final BorderRadiusGeometry? borderRadius;
  final DrawerTile backTile;

  @override
  State<FloatingDrawer> createState() => _FloatingDrawerState();
}

class _FloatingDrawerState extends State<FloatingDrawer>
    with SingleTickerProviderStateMixin {
  List<DrawerTile> list = [];

  late List<DrawerTile> tiles;
  late List<DrawerTile> safeTiles;
  late List<DrawerTile> rootTiles;

  late AnimationController _controller;
  late Animation<Offset> _transition;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _transition = Tween(
      begin: const Offset(0.5, 0.0),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    tiles = safeTiles = rootTiles = widget.tiles;

    createNavigation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isRoot = listEquals(tiles, rootTiles);

    _controller.reset();
    _controller.forward();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: widget.borderRadius,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 2),
            blurRadius: 3,
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: isRoot ? tiles.length : tiles.length + 1,
        separatorBuilder: (_, __) => widget.separator,
        itemBuilder: (_, index) {
          return FadeTransition(
            opacity: _controller,
            child: SlideTransition(
              position: _transition,
              child: isRoot
                  ? safeTiles[index]
                  : index == 0
                      ? GestureDetector(
                          child: widget.backTile,
                          onTap: () {
                            tiles = safeTiles;
                            setState(() {});
                          },
                        )
                      : tiles[index - 1],
            ),
          );
        },
      ),
    );
  }

  void createNavigation() {
    widget.tiles.asMap().forEach((i, tile) {
      if (tile.children.isEmpty) return;

      tiles.replaceRange(i, i + 1, [prepareTile(tile)]);
    });
  }

  DrawerTile prepareTile(DrawerTile tile) {
    List<DrawerTile> newChildren = [];
    if (tile.children.isNotEmpty) {
      tile.children.asMap().forEach(
            (i, item) => item.children.isEmpty
                ? newChildren.add(item)
                : newChildren.add(prepareTile(item)),
          );
    }

    DrawerTile newTile = DrawerTile(
      key: tile.key,
      child: tile.child,
      children: newChildren,
      leading: tile.leading,
      trailing: tile.trailing,
      onTap: () {
        tile.onTap?.call();
        tiles = newChildren;
        setState(() {});
      },
    );

    return newTile;
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    Key? key,
    required this.child,
    this.leading,
    this.trailing,
    this.onTap,
    this.children = const [],
  }) : super(key: key);

  final Widget child;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final List<DrawerTile> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: GlobalKey(),
      child: ListTile(
        leading: leading,
        trailing: trailing,
        onTap: onTap,
        title: child,
      ),
    );
  }
}
