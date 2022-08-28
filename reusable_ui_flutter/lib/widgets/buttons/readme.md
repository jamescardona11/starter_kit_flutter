
```
CircularIconButtonWidget(
  icon: Icons.near_me,
  onPressed: () {},
)
```


```
NextTransformationButton(
  controller: controller,
  onNextPressed: () {
    controller.run();
  },
  onTransformPressed: () {},
  baseWidget: const Padding(
    padding: EdgeInsets.only(
      top: kSpaceMax,
      bottom: kSpaceSmall,
    ),
    child: Text('Transform Widget'),
  ),
)
```