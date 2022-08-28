```
floatingActionButton: MultiFab(
  children: [
    ...List.generate(
        3,
        (i) => MultiFabItem(
              onPressed: () {},
              child: Text("$i"),
            ))
  ],
)
```