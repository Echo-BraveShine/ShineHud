# ShineHud


### 安装ShineHud
通过cocoapods安装
```ruby
pod 'ShineHud', '~> 1.0.0'
```


### 使用
```swift
/// 核心创建方法
///
/// - Parameters:
///   - style: HUD样式
///   - maskStyle: 背景样式
///   - afterDelay: 显示时长 不写即永久
///   - radius: 圆角
///   - ofsetX: 水平偏移量
///   - ofsetY: 垂直偏移量
///   - diyView: 自定义的view
///   - title: 标题
///   - detailTitle: 副标题
///   - margin: 内边距
///   - effectStyle: 毛玻璃样式
public func show(style : ShineStyle? = nil,maskStyle : ShineMaskStyle? = nil,afterDelay : TimeInterval? = nil,radius : CGFloat? = nil,ofsetX : CGFloat? = nil,ofsetY : CGFloat? = nil,diyView : UIView? = nil,title : String? = nil,detailTitle : String? = nil,margin : CGFloat? = nil,effectStyle : UIBlurEffectStyle? = nil)
```

通过view.shine.show()方法传参数调用
```swift
view.shine?.show(style: <#T##ShineView.ShineStyle?#>, maskStyle: <#T##ShineView.ShineMaskStyle?#>, afterDelay: <#T##TimeInterval?#>, radius: <#T##CGFloat?#>, ofsetX: <#T##CGFloat?#>, ofsetY: <#T##CGFloat?#>, diyView: <#T##UIView?#>, title: <#T##String?#>, detailTitle: <#T##String?#>, margin: <#T##CGFloat?#>, effectStyle: <#T##UIBlurEffectStyle?#>)
```

或者通过初始化调用
```swift
let shine = view.shine
shine?.style = .activity
shine?.afterDelay = 3
shine?.title = "这是一个菊花"
shine?.detailTitle = "菊花3秒后消失"
shine?.show()
```




