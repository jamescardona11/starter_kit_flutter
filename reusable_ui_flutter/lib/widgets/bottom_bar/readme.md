```
bottomNavigationBar: ArcBottomBar(
  items: [
    ElevenBottomItem(
      activeColor: Colors.orange,
      label: 'Home',
      icon: Icons.home,
    ),
    ElevenBottomItem(
      activeColor: Colors.red,
      label: 'Trending',
      icon: Icons.trending_up,
    ),
    ElevenBottomItem(
      activeColor: Colors.green,
      label: 'Search',
      icon: Icons.search,
    ),
    ElevenBottomItem(
      activeColor: Colors.brown,
      label: 'Settings',
      icon: Icons.settings,
    ),
  ],
  onItemSelected: (index) {
    print(index);
  },
)
```


```
bottomNavigationBar: FloatingBottomBar(
  items: [
    ElevenBottomItem(
      icon: Icons.home_rounded,
    ),
    ElevenBottomItem(
      icon: Icons.favorite_rounded,
    ),
    ElevenBottomItem(
      icon: Icons.settings_rounded,
    ),
    ElevenBottomItem(
      icon: Icons.person_rounded,
    ),
  ],
)
```