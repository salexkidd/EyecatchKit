[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/salexkidd/EyecatchKit)

# You can add the simple notify flash  in your Mac App project. Already You know.

like this FadeIn/out images.

![fadewindow](https://i.stack.imgur.com/gNrNc.png)

# Requirements
- macOS 10.13.3+
- Xcode9+
- Swift4

# Installation

May be you already know carthage. insert below line to you project Cartfile .

```
github "salexkidd/EyecatchKit"
```

and
```
$ carthage update --platform MacOS
```

That's it.

# Usage
```
import EyecatchKit
```

and

```
  ECEyecatch.flash(
      sender: self,
      image: image!,
      fadeoutInterval: TimeInterval(3),
      fadeoutDulation: TimeInterval(0.2),
      imageAlphaValue: CGFloat(0.9),
      XAxisPercentage: 0.5,
      YAxisPercentage: 0.5
    ) {
      // call after fadeout animation.
      print("End Animation...")  
    }
```

# Example

See [EyecatchKitExample](https://github.com/salexkidd/EyecatchKitExample)

[![IMAGE ALT TEXT HERE](http://img.youtube.com/vi/_zt2uGXirJ0/0.jpg)](http://www.youtube.com/watch?v=_zt2uGXirJ0)


