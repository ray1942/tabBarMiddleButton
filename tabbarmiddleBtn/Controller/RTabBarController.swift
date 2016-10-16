//
//  RTabBarController.swift
//  tabbarmiddleBtn
//
//  Created by ray on 2016/10/15.
//  Copyright © 2016年 Ray. All rights reserved.
//

import UIKit

class RTabBarController: UITabBarController {
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpAllChildVC()
        
//        创建自己的tabbar 用kvc将自己的tabbar和系统的tabbar替换下
        let tabbar = RTabBar()
        self.setValue(tabbar, forKeyPath: "tabBar")
        
//        点击事件
        tabbar.plusBtnActionClosure = {
            [weak self] in
            self!.tabBarPlusBtnAction()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    初始化tabbar出中间外的所有按钮
    func setUpAllChildVC(){
        let homeVC = ViewController()
        self.setUpOneChildVC(withVC: homeVC, image: "home_normal", selectedImage: "home_highlight", title: "首页")
        let fishVC = ViewController()
        self.setUpOneChildVC(withVC: fishVC, image: "fish_normal", selectedImage: "fish_highlight", title: "鱼塘")
        let msgVC = ViewController()
        self.setUpOneChildVC(withVC: msgVC, image: "message_normal", selectedImage: "message_highlight", title: "消息")
        let myVC = ViewController()
        self.setUpOneChildVC(withVC: myVC, image: "account_normal", selectedImage: "account_highlight", title: "我的")
    }
    
//    初始化设置tabbar上面单个按钮
    func setUpOneChildVC(withVC vc: ViewController,image: String,selectedImage: String,title: String) {
        let nav = UINavigationController.init(rootViewController: vc)
        vc.view.backgroundColor = UIColor.whiteColor()
        let tmpImage = UIImage(named: image)?.imageWithRenderingMode(.AlwaysOriginal)
        vc.tabBarItem.image = tmpImage
        let tmpSelectedImage = UIImage(named: selectedImage)?.imageWithRenderingMode(.AlwaysOriginal)
        vc.tabBarItem.selectedImage = tmpSelectedImage
        vc.tabBarItem.title = title
        vc.navigationItem.title = title
        self.addChildViewController(nav)
        
    }

    func tabBarPlusBtnAction() {
        let vc = ViewController()
        let nav = UINavigationController(rootViewController: vc)
        self.presentViewController(nav, animated: true, completion: nil)
    }
}