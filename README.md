# Floating Bubbles

**FloatingBubbles** is a customizable views that float with zero gravity animation.

![Demo VIDEO](https://vimeo.com/556631322)

```
$ pod try FloatingBubbles
```

## Features

- [x] Create Multiple Nodes
- [x] Customization
- [x] ------- More Features Coming Soon -------------

## Requirements

- iOS 13.0+
- Xcode 11.0+
- Swift 5 (FloatingBubbles)

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

var fps: Double {
    60
}

var heightWidth: CGFloat {
    50
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

```

## Installation

### CocoaPods
To install with [CocoaPods](http://cocoapods.org/), simply add this in your `Podfile`:
```ruby
use_frameworks!
pod "FloatingBubbles"
```

## Communication

- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.

## Credits

https://github.com/chandansharda/

## License

Magnetic is available under the MIT license. See the LICENSE file for more info.
