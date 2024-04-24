//
//  UIConfigure.swift
//  HSongHtmlLabel
//
//  Created by Wanglei on 2024/4/24.
//

import UIKit

final public class UIConfigure: NSObject {
    public static var SizeScale : CGFloat {
        get{
            return UIScreen.main.bounds.size.width / 375
        }
    }
    /// TabBar 大小
    public static var KTabBarHeight : CGFloat {
        get{
            return UIApplication.shared.statusBarFrame.size.height > 20 ? 83 : 49
        }
    }
    /// 状态栏和导航栏高度
    public static var navigationBarHeight : CGFloat {
        get {
            return 44 + UIApplication.shared.statusBarFrame.size.height
        }
    }
    
    /// 状态栏的高度
    public static var KStatusBarHeight: CGFloat {
        get{
            return UIApplication.shared.statusBarFrame.size.height
        }
    }
    
    /// 屏宽
    public static var Width : CGFloat {
        get{
            return UIScreen.main.bounds.size.width
        }
    }
    /// 屏高
    public static var Height : CGFloat {
        get{
            
            return UIScreen.main.bounds.size.height
        }
    }
    
    //主题色
    @objc public static var ThemeColor = UIColor(red: 69 / 255.0, green: 163 / 255.0, blue: 109 / 255.0, alpha: 1)
    //灰色背景
    public static var GroupTableViewBackground = UIColor(red: 242.0 / 255.0, green: 242.0 / 255.0, blue: 242.0 / 255.0, alpha: 1)
    /// 线灰色
    public static var LineGrayColor = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
    /// 红色
    public static var RedColor = UIColor(red: 220.0/255.0, green: 61.0 / 255.0, blue: 39.0 / 255.0, alpha: 1)
    
    public static var OwnerServiceColor = UIColor(white: 0x2F86D7, alpha: 1)
    
}
