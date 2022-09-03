import 'package:flutter/material.dart';

import '../../../config/colors.dart';

class ItemCourseCount extends StatelessWidget {
  const ItemCourseCount({
    super.key,
    required this.index,
    required this.time,
    required this.name,
    required this.available,
  });

  final int index;
  final String time;
  final String name;
  final bool available;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        children: <Widget>[
          Text('0$index',
              style: TextStyle(
                  color: Colors.grey.withOpacity(0.15), fontSize: 32)),
          const SizedBox(width: 20),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$time mins\n',
                  style: TextStyle(
                      color: Colors.grey.withOpacity(0.5), fontSize: 18),
                ),
                TextSpan(
                  text: name,
                  style:
                      const TextStyle(fontWeight: FontWeight.w600, height: 1.5),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.only(
              left: 20,
            ),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kGrayColor.withOpacity(available ? 1 : 0.5),
            ),
            child: const Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
