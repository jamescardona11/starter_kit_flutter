# Misc


### BounceWrapper
![](bounce_wrapper.gif)
```
BounceWrapper(
  child: Container(
    width: 100,
    height: 40,
    color: Colors.amber,
    child: const Center(
      child: Text('Widget'),
    ),
  ),
)
```


### BlurredContainer

![](blurred_container.png)
```
BlurredContainer(
  width: 200,
  height: 200,
  opacity: 0.1,
  blur: 8,
  accentColor: Colors.pinkAccent,
  boxDecoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
  ),
  child: const FlutterLogo(size: 100),
)
```


### CTA bar
```
CTABar(label: 'Buy Item')
```
![](cta_bar.png)


### LikeBar
```
LikeBar()
```
![](like_bar.png)