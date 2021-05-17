//
//  NSDate-Extension.swift
//  ZJPDouYuZB
//
//  Created by 张俊平 on 2021/5/17.
//

import Foundation

extension NSDate {
	class func getCurrentTime()-> String {
		let nowDate = NSDate()
		let interval = Int(nowDate.timeIntervalSince1970)
		return "\(interval)"
	}
}
