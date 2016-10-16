//
//  UIImage+RayExtension.swift
//  tabbarmiddleBtn
//
//  Created by ray on 2016/10/15.
//  Copyright © 2016年 Ray. All rights reserved.
//

import UIKit

extension UIImage{
    
//    将颜色转图片
    class func imageWithColor(color: UIColor)->UIImage{
        
//        绘制矩形
        let rect = CGRectMake(0, 0, 1, 1)
//        开启图形上下文
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
//        获得图形上下文
        let context:CGContextRef = UIGraphicsGetCurrentContext()!
//        使用color演示填充上下文
        CGContextSetFillColorWithColor(context, color.CGColor)
//        渲染上下文
        CGContextFillRect(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
//        关闭图形上下文
        UIGraphicsEndImageContext()
        
        return image
    }
}
