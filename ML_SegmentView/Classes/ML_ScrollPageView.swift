//
//  ML_ScrollPageView.swift
//  segmentViewDemo
//
//  Created by 王丹 on 2018/6/26.
//  Copyright © 2018年 王丹. All rights reserved.
//

import UIKit

open class ML_ScrollPageView: UIView {
    
    static let cellId = "cellId"
    fileprivate var segmentStyle = ML_SegmentStyle()
    
    /// 附加按钮点击响应
    open var extraBtnOnClick: ((_ extraBtn: UIButton) -> Void)? {
        didSet {
            segView.extraBtnOnClick = extraBtnOnClick
        }
    }
    
    fileprivate(set) var segView: ML_ScrollSegmentView!
    fileprivate(set) var contentView: ML_ContentView!
    fileprivate var titlesArray: [String] = []
    /// 所有的子控制器
    fileprivate var childVcs: [UIViewController] = []
    // 这里使用weak避免循环引用
    fileprivate weak var parentViewController: UIViewController?
    
    public init(frame:CGRect, segmentStyle: ML_SegmentStyle, titles: [String], childVcs:[UIViewController], parentViewController: UIViewController) {
        self.parentViewController = parentViewController
        self.childVcs = childVcs
        self.titlesArray = titles
        self.segmentStyle = segmentStyle
        assert(childVcs.count == titles.count, "标题的个数必须和子控制器的个数相同")
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func commonInit() {
        backgroundColor = UIColor.white
        segView = ML_ScrollSegmentView(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: 44), segmentStyle: segmentStyle, titles: titlesArray)
        
        guard let parentVc = parentViewController else { return }
        
        contentView = ML_ContentView(frame: CGRect(x: 0, y: segView.frame.maxY, width: bounds.size.width, height: bounds.size.height - 44), childVcs: childVcs, parentViewController: parentVc)
        contentView.delegate = self
        
        addSubview(segView)
        addSubview(contentView)
        // 避免循环引用
        segView.titleBtnOnClick = {[unowned self] (label: UILabel, index: Int) in
            // 切换内容显示(update content)
            self.contentView.setContentOffSet(CGPoint(x: self.contentView.bounds.size.width * CGFloat(index), y: 0), animated: self.segmentStyle.changeContentAnimated)
        }
        
        
    }
    
    deinit {
        parentViewController = nil
        print("\(self.debugDescription) --- 销毁")
    }
    
    
}

//MARK: - public helper
extension ML_ScrollPageView {
    
    /// 给外界设置选中的下标的方法(public method to set currentIndex)
    public func selectedIndex(_ selectedIndex: Int, animated: Bool) {
        // 移动滑块的位置
        segView.selectedIndex(selectedIndex, animated: animated)
        
    }
    
    ///   给外界重新设置视图内容的标题的方法,添加新的childViewControllers
    /// (public method to reset childVcs)
    ///  - parameter titles:      newTitles
    ///  - parameter newChildVcs: newChildVcs
    public func reloadChildVcsWithNewTitles(_ titles: [String], andNewChildVcs newChildVcs: [UIViewController]) {
        self.childVcs = newChildVcs
        self.titlesArray = titles
        
        segView.reloadTitlesWithNewTitles(titlesArray)
        contentView.reloadAllViewsWithNewChildVcs(childVcs)
    }
}

extension ML_ScrollPageView: ContentViewDelegate {
    
    public var segmentView: ML_ScrollSegmentView {
        return segView
    }
    
}

