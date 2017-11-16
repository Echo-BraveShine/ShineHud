<img width="80" height="80" border-radius = "40" src="https://avatars0.githubusercontent.com/u/26161584?s=400&u=16aa790577ba20eedb394841b66d1fcfc300c3c1&v=4"/>

# ShineHud   基于Swift4.0 轻量级HUD框架

<img width="500" height="500" src="http://g.recordit.co/jR339GbkaM.gif"/>

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

其中HUD类型有
```swift
/// HUD的类型
///
/// - normal: 默认只有文字
/// - activity: 菊花转圈
/// - cycleLoop: 圆形跑圈
/// - success: 成功图标
/// - error: 失败图标
/// - progress: 直线型进度条
/// - roundProgress: 圆形进度条
/// - custom: 自定义view
public enum ShineStyle {
case normal,activity,cycleLoop,success,error,progress,roundProgress,custom
}
```
HUD圆角大小
```swift
/// 内容区域圆角
public var radius : CGFloat = 5.0
```

HUD内边距
```swift
public var margin : CGFloat?
```

显示时长
```swift
/// 消失时长 默认hiden 立即消失
public var afterDelay : TimeInterval = 0.2
```

progress进度
```swift
/// 进度
public var progress : CGFloat
```

自定义的view
```swift
/// 自定义的view
public var diyView : UIView?
```


