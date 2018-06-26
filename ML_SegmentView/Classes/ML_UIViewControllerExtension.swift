//
//  ML_UIViewControllerExtension.swift
//  segmentViewDemo
//
//  Created by 王丹 on 2018/6/26.
//  Copyright © 2018年 王丹. All rights reserved.
//

import UIKit
extension UIViewController {
    /// parentViewController
    public weak var scrollPageController: UIViewController? {
        get {
            var superVc = self.parent
            while superVc != nil {
                if superVc! is ContentViewDelegate  {
                    break
                }
                superVc = superVc!.parent
            }
            return superVc
        }
        
    }
    }

