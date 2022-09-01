```
bottomNavigationBar: KikBottomBar(
  items: [
    KikItem(
      textColor: Colors.orange,
      title: 'Home',
      icon: Icon(Icons.home),
    ),
    KikItem(
      textColor: Colors.red,
      title: 'Trending',
      icon: Icon(Icons.trending_up),
    ),
    KikItem(
      textColor: Colors.green,
      title: 'Search',
      icon: Icon(Icons.search),
    ),
    KikItem(
      textColor: Colors.brown,
      title: 'Settings',
      icon: Icon(Icons.settings),
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