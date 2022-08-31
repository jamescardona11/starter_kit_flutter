```
floatingActionButton: MultiFab(
  children: [
    ElevenFabItem.multi(
      onPressed: () {},
      icon: Icon(Icons.home, color: Colors.white),
    ),
    ElevenFabItem.multi(
      onPressed: () {},
      icon: Icon(Icons.favorite, color: Colors.white),
    ),
    ElevenFabItem.multi(
      onPressed: () {},
      icon: Icon(Icons.person, color: Colors.white),
    ),
  ],
)
```

```
floatingActionButton: FloatingActionRow(
  items: [
    ElevenFabItem.row(
      onPressed: () {},
      icon: const Icon(
        Icons.home,
        color: Colors.white,
      ),
    ),
    ElevenFabItem.row(
      onPressed: () {},
      icon: const Icon(
        Icons.favorite,
        color: Colors.white,
      ),
    ),
    ElevenFabItem.row(
      onPressed: () {},
      icon: const Icon(
        Icons.person,
        color: Colors.white,
      ),
    ),
  ],
  color: Colors.blueAccent,
  elevation: 4,
  // heroTag: 'aswdw',
),
```