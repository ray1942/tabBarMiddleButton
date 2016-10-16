//
//  RayTabBar.swift
//  tabbarmiddleBtn
//
//  Created by ray on 2016/10/15.
//  Copyright © 2016年 Ray. All rights reserved.
//

import UIKit


class RTabBar: UITabBar {
    
//    原作者使用代理实现点击事件 这里我使用了闭包
    var plusBtnActionClosure:((Void)->Void)?
    var plusBtn:UIButton?
    var title:UILabel?
//    按钮偏移底部位置
    var bottomOffSet:CGFloat = 10
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        self.shadowImage = UIImage.imageWithColor(UIColor.clearColor())
        plusBtn = UIButton.init(type: .Custom)
        plusBtn?.setBackgroundImage(UIImage(named: "post_normal"), forState: .Normal)
        plusBtn?.setBackgroundImage(UIImage(named: "post_normal"), forState: .Highlighted)
        plusBtn?.addTarget(self, action: #selector(self.plusBtnAction), forControlEvents: .TouchUpInside)
        self.addSubview(plusBtn!)
        
        title = UILabel()
        title?.text = "发布"
        title?.font = UIFont.systemFontOfSize(11)
        title?.sizeToFit()
        title?.textColor = UIColor.grayColor()
        self.addSubview(title!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        系统自带的按钮类型是UITabBarButton,找出这个类型的按钮 然后重新排布位置 ，空出中间位置
        let className:AnyClass = NSClassFromString("UITabBarButton")!
       
        self.plusBtn?.centerX = self.centerX 
        
//        原作者将偏移底部位置的值设为了常量 我这里方便以后修改位置设为了属性
        self.plusBtn?.centerY = self.height * 0.5 - 2 * bottomOffSet
//        由于在初始化时plusbtn 和image都是赋值过的 所以我直接使用了强制解包 如果是可空链的话很长
        self.plusBtn!.size = CGSizeMake(self.plusBtn!.currentBackgroundImage!.size.width, self.plusBtn!.currentBackgroundImage!.size.height)
        
        title?.centerX = self.plusBtn!.centerX
        title?.centerY = CGRectGetMaxY(self.plusBtn!.frame) + bottomOffSet
        
        var btnIndex:CGFloat = 0
//        遍历tabbar的子视图
        for btn in self.subviews {
//            如果是系统的UITabbarButton 那么调整子控件的位置 空出中间位置
            if btn.isKindOfClass(className) {
                btn.width = self.width / 5
                btn.x = btn.width * btnIndex
                btnIndex += 1
//                如果所以是2 直接让索引加1 目的是让下一个按钮向右移动 空出中间的位置
                if btnIndex == 2{
                    btnIndex += 1
                }
            }
        }
        self.bringSubviewToFront(self.plusBtn!)
    }
    
//    按钮点击事件
    func plusBtnAction(){
        if let action = plusBtnActionClosure {
            action()
        }
    }
    
//    重写hitTest方法 去监听发布按钮的点击 目的是为了让凸出部分点击有反应
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        /*
         如果不加这个判断点击自定义按钮的位置也会有反应
         self.hidden == false 说明当前页面是有tabbar的 那么肯定是在导航控制器的根控制器页面
         在导航控制器根控制器页面 那么我们就需要判断手指点的位置是否在发布按钮上
         是的话让发布按钮自己处理点击事件 不是的话让系统去处理 点击事件接可以
         但是经过实际测试貌似不用考虑 因为present到下个页面tabbar被遮盖 那么tabbar的点击事件也被遮盖 并不会在下个页面响应tabbar的事件
        */
        
//        if self.hidden == false {
//            将当前tabbar的触摸点转换为坐标系 转换到自定义按钮上
            let newPoint = self.convertPoint(point, toView: self.plusBtn)
//            判断如果这个新的点是在发布按钮上 那么处理点击事件
            if let plusBtn = self.plusBtn{
                if plusBtn.pointInside(newPoint, withEvent: event) {
                    return self.plusBtn
                }
            }
//        }
//        tabbar 隐藏的话 说明不在当前页面 这时让系统处理点击
        return super.hitTest(point, withEvent: event)
    }
}
