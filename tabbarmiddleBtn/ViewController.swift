//
//  ViewController.swift
//  tabbarmiddleBtn
//
//  Created by ray on 2016/10/15.
//  Copyright © 2016年 Ray. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()

//        如果不是第一个页面则添加 返回按钮
        if self.presentingViewController != nil {
            addBackBtn()
        }
        
    }
    
    func addBackBtn() {
        let backBtn = UIButton(type: .System)
        backBtn.frame = CGRectMake(0, 0, 30, 30)
        backBtn.setTitle("返回", forState: .Normal)
        backBtn.addTarget(self, action: #selector(backAction), forControlEvents: .TouchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
    }
    
    func backAction() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

