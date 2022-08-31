
```
SkipTopBar(
  center: Text('Center widget'),
  onBackClick: () {},
)
```

```
AppBar(
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
)
```