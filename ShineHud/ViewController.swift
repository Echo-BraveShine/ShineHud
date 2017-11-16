//
//  ViewController.swift
//  Shine
//
//  Created by BraveShine on 2017/11/14.
//  Copyright © 2017年 BraveShine. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      

      
        
        
    }
    
    @IBAction func normalCliock(_ sender: UIButton) {
        
        view.shine?.show(style: .normal,afterDelay:3, title:"人和人的差距",detailTitle : "她摇头否认，跟我讲，办公室里的一位同事，能力很强，其实也没什么，说白了无非是阅读量大一些，肚子里墨水多一点儿，但就这一条，足以构成一种碾压级别的优势，人家说出的话，写出的东西，跟你一样，都是汉语，但愣是比你有水平。你想缩小差距吧，还心知这不是一天两天的功夫；有一种被欺负的感觉，却也心服口服，望洋兴叹，只能受着。")
    
    }
    
    @IBAction func activityClick(_ sender: Any) {
        
        view.shine?.show(style: .activity,afterDelay:3, title:"请求HUD",detailTitle : "正在请求服务器")
        
    }
    
    @IBAction func loopClick(_ sender: Any) {
        
        view.shine?.show(style: .cycleLoop,afterDelay:3, title:"请求HUD",detailTitle : "正在请求服务器")

    }
    
    @IBAction func successClick(_ sender: Any) {
        view.shine?.show(style: .success,afterDelay:3, title:"请求HUD",detailTitle : "正在请求服务器")

    }
    
    @IBAction func errorClick(_ sender: Any) {
        
        view.shine?.show(style: .error,afterDelay:3, title:"请求HUD",detailTitle : "正在请求服务器")

    }
    
    @IBAction func roundProgress(_ sender: Any) {
        view.shine?.show(style: .roundProgress,afterDelay:3, title:"请求HUD",detailTitle : "正在请求服务器")
        cutDown()

    }
    
    @IBAction func progressClick(_ sender: Any) {
        view.shine?.show(style: .progress,afterDelay:3, title:"请求HUD",detailTitle : "正在请求服务器")
        cutDown()

    }
    
    
    @IBAction func custom(_ sender: Any) {
        
        let b = UIButton()
        
        b.setTitle("点击", for: .normal)
        b.setTitleColor(.black, for: .normal)
        b.frame = CGRect.init(x: 0, y: 0, width: 200, height: 60 )
        b.backgroundColor = .red
        
        view.shine?.show(diyView:b,title:"自定义")
        b.addTarget(self, action: #selector(customClick), for: .touchUpInside)
    }
    
    
    @objc func customClick() {
        
        view.shine?.hiden(afterDelay: 0)
    }
    
    @objc func shineHiden()  {
        
        print("hiden")
        view.shine?.hiden()
        
        self.perform(#selector(shineShow), with: nil, afterDelay: 3)

    }
    @objc func shineShow()  {
        
        view.shine?.show()
    }
    
    
    @objc func cutDown()  {
        
        if (view.shine?.progress)! > CGFloat(1.0) {
            
            return
        }
        view.shine?.progress += 0.01
        
        self.perform(#selector(cutDown), with: nibName, afterDelay: 0.01)
        
        
    }
   
    deinit {
        print("deint")
    }

}



