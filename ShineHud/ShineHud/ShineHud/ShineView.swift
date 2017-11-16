//
//  ShineView.swift
//  Shine
//
//  Created by BraveShine on 2017/11/14.
//  Copyright © 2017年 BraveShine. All rights reserved.
//

import UIKit


private let kDefaultViewHeight : CGFloat = 40
private func currenBundle() -> Bundle {
    
    var bundle: Bundle = Bundle.main
    let framework = Bundle(for: ShineView.classForCoder())
    if let resource = framework.path(forResource: "ShineView", ofType: "bundle") {
        bundle = Bundle(path: resource) ?? Bundle.main
    }
    return bundle
}

class ShineView: UIView {

    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var effectView: UIVisualEffectView!
    
    @IBOutlet weak var customView: UIView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var customViewH: NSLayoutConstraint!
    
    @IBOutlet weak var customViewW: NSLayoutConstraint!
    
    @IBOutlet weak var positionX: NSLayoutConstraint!
    
    @IBOutlet weak var positionY: NSLayoutConstraint!

    @IBOutlet weak var customTopSpace: NSLayoutConstraint!
    
    @IBOutlet weak var customLeftSpace: NSLayoutConstraint!
    
    @IBOutlet weak var customBottomSpace: NSLayoutConstraint!
    
    @IBOutlet weak var contentViewWidth: NSLayoutConstraint!
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
    enum ShineStyle {
        case normal,activity,cycleLoop,success,error,progress,roundProgress,custom
    }
    
    enum ShineMaskStyle {
        case normal,lightGrary
    }
    
    
    
    /// 菊花转圈
    private lazy var activity : UIActivityIndicatorView = {
        
        let a = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        
        a.startAnimating()
        
        return a
    }()
    
    lazy var cycleLoop : CycleLoopView = {
       
        let c = CycleLoopView()
        
        c.frame = CGRect.init(x: 0, y: 0, width: kDefaultViewHeight, height: kDefaultViewHeight)
        return c
    }()
    
   
    /// 失败成功显示的imageview
    private lazy var imageView : UIImageView = {
       
        let i  = UIImageView()
        i.frame = CGRect.init(x: 0, y: 0, width: kDefaultViewHeight, height: kDefaultViewHeight)
        i.contentMode = .scaleAspectFill
        i.clipsToBounds = true
        return i
    }()
    
    /// 圆形进度条
    lazy var roundProgressView : RoundProgressView = {
        
        let r = RoundProgressView()
        r.frame = CGRect.init(x: 0, y: 0, width: kDefaultViewHeight, height: kDefaultViewHeight)
        
        return r
    }()
    
    
    /// 直线型进度条
    private lazy var progressView : ProgressView = {
       
        let p = ProgressView()
        
        return p
    }()
    
    
    /// 承载的父视图
    weak var parent : UIView?
    
    /// 类型
    var style : ShineStyle = .normal{
        didSet{
            for v in customView.subviews {
                
                if v != diyView{
                    v.removeFromSuperview()

                }
            }
        }
    }
    
    var maskStyle : ShineMaskStyle = .normal
    
    /// 标题
    var title : String = ""{
        didSet{
            label.text = title
        }
    }
    
    /// 副标题
    var detailTitle : String = ""{
        didSet{
            detailLabel.text = detailTitle
        }
    }
    
    /// 从屏幕中间向右偏移量
    var ofsetX : CGFloat = 0{
        didSet{
            positionX.constant = ofsetX
        }
    }
    /// 从屏幕中间向下偏移量
    var ofsetY : CGFloat = 0{
        didSet{
            positionY.constant = ofsetY
        }
    }
    
    var contentWidth : CGFloat = 80{
        didSet{
            contentViewWidth.constant = contentWidth
        }
    }
    
    /// 内容区域圆角
    var radius : CGFloat = 5.0
    
   
    /// 内边距
    var margin : CGFloat?{
        didSet{
            customTopSpace.constant = margin!
            customLeftSpace.constant = margin!
            customBottomSpace.constant = margin!
        }
    }
    
    /// 消失时长 默认hiden 立即消失
    var afterDelay : TimeInterval = 0.2
    
    var effectStyle : UIBlurEffectStyle = .light{
        didSet{
            effectView.effect = UIBlurEffect.init(style: effectStyle)
        }
    }
    
    /// 进度
    var progress : CGFloat{
        set{
            if style == .roundProgress
            {
                roundProgressView.progress = newValue
            }else if style == .progress
            {
                progressView.progress = newValue
            }
        }
        
        get{
            if style == .roundProgress
            {
                return roundProgressView.progress
                
            }else if style == .progress {
                
                return CGFloat(progressView.progress)
            }
            return 0.0
        }
    }
    
    
    /// 自定义的view
    fileprivate var diyView : UIView?{
        
        didSet{
            
            for v in customView.subviews {
                v.removeFromSuperview()
            }
            
            if diyView?.frame.size.width == 0 {

                let rect = customView.bounds
                
                diyView?.frame = CGRect.init(x: 0, y: 0, width: rect.size.width, height: rect.size.height)
            }
            
//            if style == .normal {
//                style = .custom
//            }
            
            customView.addSubview(diyView!)
        }
    }
    
   
    
   
    @objc func updateUI() {
        
        
        label.text = title
        
        detailLabel.text = detailTitle
    
        customView.backgroundColor = .clear
        
        contentView.layer.cornerRadius = radius
        
        contentView.layer.masksToBounds = true
        
        if margin == nil {//margin 默认为5
            margin = 5
        }
        
        
        if title.count == 0 && detailTitle.count == 0 && style == .normal {
            label.text = "这是标题"
            
            detailLabel.text = "这是内容"
        }
        
        
        switch maskStyle {
        case .lightGrary:
            self.backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            break
        default:
            self.backgroundView.backgroundColor = .clear
            break
            
        }
        
        switch style {
            
        case .normal:
            
            break
        case .activity:
            diyView = activity
            break
        case .success:
            let image = UIImage.init(named: "shine_success", in: currenBundle(), compatibleWith: nil)
            imageView.image = image
            imageView.frame = CGRect.init(origin: CGPoint(), size: (image?.size)!)
            diyView = imageView
            break
        case .error:
            let image = UIImage.init(named: "shine_error", in: currenBundle(), compatibleWith: nil)

            imageView.image = image
            imageView.frame = CGRect.init(origin: CGPoint(), size: (image?.size)!)
            diyView = imageView
            break
        case .custom:
            
            if diyView == nil {
                print("diyView is nil when style is custom")
            }
            
            break
        case .roundProgress:
            
            self.diyView = roundProgressView
            break
        case .progress:
            self.diyView = progressView
            break
        case .cycleLoop:
            
            self.diyView = cycleLoop
            break
        }
        
        
        if style == .normal || diyView == nil
        {
            customViewH.constant = 0
            
        }else{
                        
            customViewH.constant = (diyView?.frame.size.height)!
            customViewW.constant = (diyView?.frame.size.width)!
           
            layoutIfNeeded()
            
            let rect1 = customView.bounds
            
            let rect2 = diyView?.bounds           
            
            diyView?.frame = CGRect.init(x: (rect1.size.width - (rect2?.size.width)!)/2 , y: (rect1.size.height - (rect2?.size.height)!)/2, width: (rect2?.size.width)!, height: (rect2?.size.height)!)
            
        
        }
        
        diyView?.layoutSubviews()
        
    }
    
    

    
   
    
    
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
    func show(style : ShineStyle? = nil,maskStyle : ShineMaskStyle? = nil,afterDelay : TimeInterval? = nil,radius : CGFloat? = nil,ofsetX : CGFloat? = nil,ofsetY : CGFloat? = nil,diyView : UIView? = nil,title : String? = nil,detailTitle : String? = nil,margin : CGFloat? = nil,effectStyle : UIBlurEffectStyle? = nil) {
        
        if style != nil {
            self.style = style!
        }
        if maskStyle != nil {
            self.maskStyle = maskStyle!
        }
        
        if afterDelay != nil {
            self.afterDelay = afterDelay!
            hiden()
        }
        
        if radius != nil {
            self.radius = radius!
        }
        
        if ofsetX != nil {
            self.ofsetX = ofsetX!
        }
        if ofsetY != nil {
            self.ofsetY = ofsetY!
        }
        
        if diyView != nil {
            self.style = .custom

            self.diyView = diyView
        }
        
        if title != nil {
            self.title = title!
        }
        
        if detailTitle != nil {
            self.detailTitle = detailTitle!
        }
        
        if margin != nil {
            self.margin = margin!
        }
        
        if effectStyle != nil{
            self.effectStyle = effectStyle!
        }

        parent?.addSubview(self)
        
    }
    
    func hiden(afterDelay : TimeInterval? = nil)  {
        
        if afterDelay != nil {
            self.afterDelay = afterDelay!
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + self.afterDelay, execute: {
    
            self.layer.removeAllAnimations()

            self.removeFromSuperview()
    
            
            
            self.parent?.shine = nil
            
        })
        
    }
    
    
    
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        
        if newSuperview == nil {
            return
        }
        
        self.frame = (newSuperview?.bounds)!
        
        NotificationCenter.default.removeObserver(self)

        
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        updateUI()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
}

class CycleLoopView : UIView{
    
    var progressWidth : CGFloat = 2.0
    
    var progressColor : UIColor = UIColor.white
    
    var bgColor : UIColor =  UIColor.white.withAlphaComponent(0.1)
    
    var anmlayer : CALayer?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = .clear
    }
    
    
    override func draw(_ rect: CGRect) {
        
        layer.removeAllAnimations()
        
        if anmlayer != nil {
            anmlayer?.removeFromSuperlayer()
            anmlayer = nil
        }
        
        let radius = (bounds.size.height - progressWidth)/2
        
        
        let arcCenter = CGPoint.init(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
        
        let bezierPath = UIBezierPath.init(arcCenter: arcCenter, radius: radius, startAngle: CGFloat(Double.pi*3/2), endAngle: CGFloat(Double.pi/2+Double.pi*5), clockwise: true)
        
        let animationlayer = CAShapeLayer()
        
        animationlayer.contentsScale = UIScreen.main.scale
        
        animationlayer.frame = bounds
        
        animationlayer.fillColor = UIColor.clear.cgColor
        
        animationlayer.strokeColor = progressColor.cgColor
        
        animationlayer.lineWidth = progressWidth
        
        animationlayer.lineCap = kCALineCapRound
        
        animationlayer.lineJoin = kCALineJoinBevel
        
        animationlayer.path = bezierPath.cgPath
        
        
        let maskLayer = CALayer()
        
        let maskImage = UIImage.init(named: "cycle_loop_mask", in: currenBundle(), compatibleWith: nil)
        
        maskLayer.contents = maskImage?.cgImage
        
        maskLayer.frame = animationlayer.frame
        
        animationlayer.mask = maskLayer
        
        
        let animationDuration = 1
        
        let linearCurve : CAMediaTimingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)
        
        let animation : CABasicAnimation = CABasicAnimation.init(keyPath: "transform.rotation")
        
        animation.fromValue = 0
        
        animation.toValue = Double.pi * 2
        
        animation.duration = CFTimeInterval(animationDuration)
        
        animation.timingFunction = linearCurve
        
        animation.isRemovedOnCompletion = false
        
        animation.repeatCount = Float.infinity
        
        animation.fillMode = kCAFillModeForwards
        
        animation.autoreverses = false
        
        animationlayer.mask?.add(animation, forKey: "rotate")
        
        anmlayer = animationlayer
        
        self.layer.addSublayer(animationlayer)
    }
    
    
    
}

class ProgressView: UIView {
    
    var progress : CGFloat = 0.0{
        didSet{
            
            progressView.progress = Float(progress)
            
            progressLabel.text = text != nil ? text : String(describing: Int((progress > 1.0 ? 1.0 : progress) * 100)) + "%"
            
        }
        
    }
    
    lazy var progressLabel : UILabel = {
        
        let l = UILabel()
        
        l.textAlignment = .center
        
        l.font = UIFont.systemFont(ofSize: 14)
        
        l.textColor = self.progressColor
        
        self.addSubview(l)
        
        
        return l
    }()
    
    lazy var progressView : UIProgressView  = {
       
        let p = UIProgressView()
       
        
        self.addSubview(p)
        
        
        return p
    }()
    
    
    var text : String?
    
    var progressWidth : CGFloat = 3.0
    
    var progressColor : UIColor = UIColor.white{
        didSet{
            self.progressView.progressTintColor = progressColor
        }
    }
    
    var bgColor : UIColor =  UIColor.white.withAlphaComponent(0.1) {
        didSet{
            self.progressView.trackTintColor = bgColor
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        if superview == nil {
            return
        }
        
        let scale : CGFloat = 0.8
        
        let superRect = superview?.bounds
        
        
        let rect = CGRect.init(x: (superRect?.size.width)! * (1-scale)/2, y: (superRect?.origin.y)!, width: ((superRect?.size.width)! * scale), height: (superRect?.size.height)!)

        self.frame = rect
        
        progressView.frame = CGRect.init(x: 0, y: (rect.size.height)/4, width: self.bounds.size.width, height: (rect.size.height)/2)
        
        progressLabel.frame = CGRect.init(x: 0, y: (rect.size.height)/2, width: self.bounds.size.width, height: (rect.size.height)/2)
        
    }
    
    deinit {
        print("deint")
    }
}






/// 圆形进度条
class RoundProgressView: UIView {
    
    var progress : CGFloat = 0.0{
        didSet{
           
            setNeedsDisplay()
            
            progressLabel.text = text != nil ? text : String(describing: Int((progress > 1.0 ? 1.0 : progress) * 100)) + "%"
            
        }
        
    }
    
    lazy var progressLabel : UILabel = {
       
        let l = UILabel()
        
        l.textAlignment = .center
        
        l.font = UIFont.systemFont(ofSize: 14)
        
        l.textColor = self.progressColor

        self.addSubview(l)

        
        return l
    }()
    
    
    var text : String?
    
    var progressWidth : CGFloat = 2.0
    
    var progressColor : UIColor = UIColor.white

    var bgColor : UIColor =  UIColor.white.withAlphaComponent(0.1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        
    }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        let size = rect.size
        
        let center = CGPoint.init(x: size.width/2, y: size.height/2)
        
        let radius = (size.height - progressWidth)/2
        
        let beginAngle = -CGFloat.pi/2
        
        
        //MARK : 背景淡色的圆
        
        let roundPath = UIBezierPath()
        
        roundPath.lineWidth = progressWidth
        
        roundPath.lineCapStyle = .round
        
        roundPath.addArc(withCenter: center, radius: radius, startAngle: beginAngle, endAngle: beginAngle + CGFloat.pi * 2, clockwise: true)
        
        bgColor.set()
        
        roundPath.stroke()
        
     
        //MARK : 进度弧线
        
        let progressPath = UIBezierPath()
        
        progressPath.lineCapStyle = .round
        
        progressPath.lineWidth = progressWidth
        
        progressPath.addArc(withCenter: center, radius: radius, startAngle: beginAngle, endAngle: progress * 2 * CGFloat.pi + beginAngle, clockwise: true)
        
        progressColor.set()
        
        progressPath.stroke()

        progressLabel.frame = CGRect.init(x: center.x - radius + progressWidth/2, y: rect.origin.y + progressWidth, width: radius * 2 - progressWidth, height: radius * 2 - progressWidth)
    
    }
    
    
    
    
}

extension UIView {
    
    struct ShineRuntime {
        static let RuntimeKey = UnsafeRawPointer.init(bitPattern: "ShineRuntimeKey".hashValue)
    }
    
    var shine : ShineView?{
        set{
            
            objc_setAssociatedObject(self, UIView.ShineRuntime.RuntimeKey!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get{
            
            var s : ShineView? = objc_getAssociatedObject(self, UIView.ShineRuntime.RuntimeKey!) as? ShineView
            
            if s == nil {
                
                s  = (currenBundle().loadNibNamed("ShineView", owner: nil, options: nil)?.last as? ShineView)!
                
                self.shine = s!
                
                s?.parent = self
                
            }
            
            return s!
        }
    }
    
    
}
