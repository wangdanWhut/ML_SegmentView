//
//  ViewController.swift
//  ML_SegmentView
//
//  Created by 王丹 on 06/26/2018.
//  Copyright (c) 2018 王丹. All rights reserved.
//

import UIKit
import ML_SegmentView

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpUI()
        
    }
    func setUpUI() {
        self.view.backgroundColor = .white
        var style = ML_SegmentStyle()
        style.scrollTitle = false
        // 滚动条
        style.showLine = true
        // 颜色渐变
        style.gradualChangeTitleColor = true
        // 滚动条颜色
        style.scrollLineColor = UIColor.lightGray
        
        let titles:[String] = ["Active","Group play","Winning","History"]
        
        let scroll =  ML_ScrollPageView(frame: CGRect(x: 0, y: 64, width: view.bounds.size.width, height: view.bounds.size.height), segmentStyle: style, titles: titles, childVcs: setChildVcs(titles: titles), parentViewController: self)
        view.addSubview(scroll)
    }
    
    func setChildVcs(titles: [String]) -> [UIViewController] {
        
        var vcArrayM = [UIViewController]()
        
        for item in titles {
            let vc = UIViewController()
            vc.title = item
            vcArrayM.append(vc)
        }
        return vcArrayM
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
