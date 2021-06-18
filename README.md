# Floating Bubbles

**FloatingBubbles** is a customizable views that float like zero gravity animation.

![License](https://img.shields.io/github/license/chandansharda/FloatingBubbles)
![Platform](https://img.shields.io/cocoapods/p/FloatingBubbles)
![Stars](https://img.shields.io/github/stars/chandansharda/FloatingBubbles)
![Issues](https://img.shields.io/github/issues/chandansharda/FloatingBubbles)


<p align="center">
  <img src="https://raw.githubusercontent.com/chandansharda/FloatingBubbles/main/FloatingBubbles/GIF/demo.gif" alt="FlowingMenu" width="300"/>
</p>


```
$ pod try FloatingBubbles
```

## Features

- [x] Create Multiple Views
- [x] Customization
- [x] Different size for every view.
- [x] ------- More Features Coming Soon -------------

## Requirements

- iOS 13.0+
- Xcode 11.0+
- Swift 5 (FloatingBubbles)

## Formulas

Circle, find intersection point of two moving circles :-
```
Distance between centres C1 and C2 is calculated as
 C1C2 = sqrt((x1 - x2)2 + (y1 - y2)2).
There are three condition arises.
1. If C1C2 == R1 + R2
     Circle A and B are touch to each other.
2. If C1C2 > R1 + R2
     Circle A and B are not touch to each other.
3. If C1C2 < R1 + R2
      Circle intersects each other.
```

## Usage

A `FloatingBubbles` object is an [UIView]

To display, you present it from an [UIView] object.

```swift
import FloatingBubbles

class ViewController: UIViewController {

    var floatingView = BouncyFloatingViews()
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(floatingView)
        view.bringSubviewToFront(floatingView)

        NSLayoutConstraint.activate([
            floatingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            floatingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            floatingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            floatingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        floatingView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        floatingView.startAnimation()
    }
}

//MARK:- Customizations
extension ViewController: BouncyFloatingPresenable {
    func viewForBubbleAt(withIndex index: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = .red
        return v
    }
    
    
    var floatingViews: Int {
        6
    }
    
    var fps: Double {
        60
    }
    
    var speed: CGFloat {
        12
    }
    
    var heightWidth: CGFloat {
        50
    }
}


```

#### Properties

```swift
floatingView.delegate: BouncyFloatingPresenable? // floating views delegate
var floatingViews: Int // returns number of views
var heightWidth: CGFloat // returns height and width of the view for making a square
var fps: CGFloat // returns frame per seconds
var speed: CGFloat // returns the speed of moving in pixels per inch
func heightForViewAt(atIndex index: Int) -> CGSize? //Return size for every view if its nil then default (heightWidth)size is used
```

### Delegation

The `BouncyFloatingPresenable` protocol provides a customizations to our views.

```swift
func viewForBubbleAt(withIndex index: Int) -> UIView? {
    let v = UIView()
    v.backgroundColor = .red
    return v
}


var floatingViews: Int {
    6
}

var speed: CGFloat {
    12
}


var fps: Double {
    60
}

var heightWidth: CGFloat {
    50
}

func heightForViewAt(atIndex index: Int) -> CGSize? {
    return CGSize(width: 80, height: 80)
}
```

### Customization

Return View for customization.

For example,

```swift
func viewForBubbleAt(withIndex index: Int) -> UIView? {

    // create your custom view and return it
    let v = UIView()
    v.backgroundColor = .red
    return v
}

func heightForViewAt(atIndex index: Int) -> CGSize? {
    return CGSize(width: 80, height: 80)
}

```

## Installation

### CocoaPods
To install with [CocoaPods](http://cocoapods.org/), simply add this in your `Podfile`:
```ruby
use_frameworks!
pod "FloatingBubbles"
```

## Manually
- Drop **FloatingBubbles Files** into your project.


## Communication

- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.

## Author

Chandan Sharda, chandan.sharda98@gmail.com

## License

FlotaingBubbles is available under the MIT license. See the LICENSE file for more info.
