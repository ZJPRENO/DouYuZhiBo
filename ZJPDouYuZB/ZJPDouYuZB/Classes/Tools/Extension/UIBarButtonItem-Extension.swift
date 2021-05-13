//
//  UIBarButtonItem-Extension.swift
//  ZJPDouYuZB
//
//  Created by 张俊平 on 2021/5/11.
//

import UIKit

extension UIBarButtonItem {

//	类方法
	/*
	class func creatItem(imageName:String,highImageName:String,size:CGSize) -> UIBarButtonItem {

		let btn = UIButton()
		btn.setImage(UIImage(named: imageName), for: .normal)
		btn.setImage(UIImage(named: highImageName), for: .highlighted)
		btn.frame = CGRect(origin: CGPoint.zero, size: size)
		return UIBarButtonItem(customView: btn)

	}*/

//	构造方法
//	便利构造函数
	/*
	1.convenience开头
	2.在构造函数中必须明确一个设计的构造函数，使用self
	*/
	convenience  init(imageName:String,highImageName:String = "" ,size:CGSize = CGSize.zero) {

		let btn = UIButton()
		btn.setImage(UIImage(named: imageName), for: .normal)
		if highImageName != "" {
			btn.setImage(UIImage(named: highImageName), for: .highlighted)
		}

		if size == CGSize.zero {
			btn.sizeToFit()
		} else {
			btn.frame = CGRect(origin: CGPoint.zero, size: size)
		}
		
		self.init(customView:btn)
	}

}
