//
//  Common.swift
//  ZJPDouYuZB
//
//  Created by 张俊平 on 2021/5/11.
//

import UIKit

let isiPhoneXMore = UIApplication.shared.windows[0].safeAreaInsets.bottom > 0
let TOP_HEIGHT:CGFloat = isiPhoneXMore ? 88 : 64
let BOTTOM_HEIGH:CGFloat = isiPhoneXMore ? (49+34) : 49

let kStatusBarH:CGFloat = isiPhoneXMore ? 44 : 20
let kNavigationBarH:CGFloat = isiPhoneXMore ? 88 : 64;
let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height

//let StatusBarHeight             = UIApplication.shared.statusBarFrame.size.height >= 44 ? UIApplication.shared.statusBarFrame.size.height : 20


