# TopTabBarView-Framework

<a href="https://docs.swift.org/swift-book/" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/swift-5.0-brightgreen">
</a>
<a href="https://developer.apple.com/ios/" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-iOS-red">
</a>
<a href="https://www.codacy.com?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=nikunjprajapati95/Reading-Animation&amp;utm_campaign=Badge_Grade"><img src="https://app.codacy.com/project/badge/Grade/44b16d6ddb96446b875d38bf2ec89b11"/></a>
<a href="https://github.com/parthgohel2810/TopTabBarView-Framework/blob/main/LICENSE" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/licence-MIT-orange">
</a>
<p></p> 

![](/Example/Example/Media/demo.mov)

## Requirements
- iOS 13.0+
- Xcode 13.0+

## Installation
To install it, simply add the following line to your Podfile:

```ruby
pod 'TopTabBarView', git: 'https://github.com/parthgohel2810/TopTabBarView-Framework.git', branch: 'main'
```
Then run `pod install` from the Example directory.

## Usage

1. Change the class of a view from UIView to TopTabbarView
```swift
@IBOutlet private weak var topTabBarView: TopTabbarView!
```
2. Programmatically:

```swift
let topTabBarView = TopTabbarView(frame: myFrame)

```

## Customization 

```swift
    private func configureTabBarItem() {
        
        topTabBarView.dataSource = ["M", "I", "N", "D", "I", "N", "V", "E", "N", "T", "O", "R", "Y"]
        topTabBarView.dotColor = .white
        topTabBarView.waveHeight = 16
        topTabBarView.leftPadding = 10
        topTabBarView.rightPadding = 10
        topTabBarView.tabBarColor = .red
        topTabBarView.onItemSelected = { (index) in
                debugPrint("tabIndex: \(index)")
        }
        topTabBarView.isScaleItem = true
        topTabBarView.tabBarItemStyle = .setStyle(font: UIFont.boldSystemFont(ofSize: 18),
                                                  foregroundColor: .white)
    }
```

#### dataSource
The dataSource property accepts string array which is used to display title of tab and creates number of tab that you want to create.

#### dotColor
The dotColor property change the color of dot which is place at center of wave.

#### waveHeight
The waveHeight property change height of wave.

#### leftPadding, rightPadding
The left and right padding property will change the tabBar left and right padding to the view.

#### tabBarColor
The tabBarColor property used to change background color of tabbar color.

#### isScaleItem
The isScaleItem property enables you to off/on scaling of tab titles.

#### tabBarItemStyle
The tabBarItemStyle used to tabBarItem font and textColor.

#### selectedTab
The selectedTab used to set selected tab initially.

#### setSelectedTab(with index: Int)
This function used to set selected tab programmatically.

#### onItemSelected
You will receive selected tab index in onItemSelected clouser.
```swift
  topTabBarView.onItemSelected = { (index) in
                debugPrint("tabIndex: \(index)")
  }
```














