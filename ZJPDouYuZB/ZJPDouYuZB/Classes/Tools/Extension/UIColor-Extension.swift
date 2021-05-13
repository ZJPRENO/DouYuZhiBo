//
//  UIColor-Extension.swift
//  ZJPDouYuZB
//
//  Created by 张俊平 on 2021/5/13.
//

import UIKit

extension UIColor {
	convenience init(r:CGFloat,g:CGFloat,b:CGFloat) {
		self.init(red: r / 255.0,green: g / 255.0,blue: b / 255.0,alpha:1)
	}
}
