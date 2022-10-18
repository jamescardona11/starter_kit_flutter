import 'package:flutter/material.dart';
import 'package:pocket_notes/cache_page.dart';
import 'package:pocket_notes/database_page.dart';

class HomePage extends StatefulWidget {
  /// default constructor
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pocket Notes'),
      ),
      body: IndexedStack(
        index: index,
        children: [
          DatabasePage(),
          CachePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        elevation: 2,
        onTap: (i) => setState(() {
          index = i;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.note,
            ),
            label: 'DB',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.cached,
            ),
            label: 'Cache',
          ),
        ],
      ),
    );
  }
}
