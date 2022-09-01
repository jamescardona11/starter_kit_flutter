import 'package:flutter/material.dart';

class LikeBar extends StatelessWidget {
  const LikeBar({
    Key? key,
    this.background = Colors.grey,
    this.accentColor = Colors.white,
    this.favoriteColor = Colors.blue,
    this.icon = Icons.favorite,
    this.onPressedFavorite,
    this.onPressedLabel,
    this.label = 'Explore More',
  }) : super(key: key);

  final Color background;
  final IconData icon;
  final Color accentColor;
  final Color favoriteColor;
  final String label;
  final VoidCallback? onPressedFavorite;
  final VoidCallback? onPressedLabel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 80,
      color: Colors.grey,
      child: Row(
        children: [
          const Spacer(),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              color: accentColor,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onPressedFavorite,
            child: Container(
              width: 100,
              color: Colors.blue,
              child: Center(
                child: Icon(
                  icon,
                  color: accentColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
