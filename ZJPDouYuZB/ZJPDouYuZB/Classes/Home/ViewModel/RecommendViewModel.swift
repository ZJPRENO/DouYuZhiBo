//
//  RecommendViewModel.swift
//  ZJPDouYuZB
//
//  Created by 张俊平 on 2021/5/17.
//

import UIKit

class RecommendViewModel {

}

//MARK:网络请求
extension RecommendViewModel {
	func requestData() {
		 //1.推荐数据
		//2.颜值
		//3.其他
		let parameters:[String:String] = ["limit":"4","offset":"2","time":NSDate.getCurrentTime()]

		NetWork.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate",parameters: parameters) { result in
			print(result)

		}
	}
}
