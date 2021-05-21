//
//  RecommendViewModel.swift
//  ZJPDouYuZB
//
//  Created by 张俊平 on 2021/5/17.
//

import UIKit
import HandyJSON
class RecommendViewModel {
	//MARK:懒加载
	lazy var anchorGroups:[AnchorGroupModel] = [AnchorGroupModel]()
	private lazy var bigDataGroup:AnchorGroupModel = AnchorGroupModel()
	private lazy var prettyGroup:AnchorGroupModel = AnchorGroupModel()
	lazy var cycleModels:[CycleModel] = [CycleModel]()

}

//MARK:网络请求
extension RecommendViewModel {

	func requestData(finishCallback:@escaping ()->()) {

		//MARK:
		let dispatchG = DispatchGroup()

		let parameters:[String:String] = ["limit":"4","offset":"2","time":NSDate.getCurrentTime()]
		let hotUrl = "http://capi.douyucdn.cn/api/v1/getbigDataRoom"
		 //1.推荐数据
		dispatchG.enter()
		NetWork.requestData(type: .get, URLString: hotUrl, parameters: parameters) { [self]  result in
//						print("数据打印：\(result)")

			guard let str = result as? String,
					let jsonData = str.data(using: .utf8),
					let resp = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [String : Any] else {
				 return
			}

			guard let dictArr = resp["data"] as? [[String : Any]],
					let anchor = [RoomListModel].deserialize(from: dictArr) as? [RoomListModel] else {
				 print("解析失败")
				 return
			}
			bigDataGroup.tag_name = "热门"
			bigDataGroup.icon = "home_header_hot"
			bigDataGroup.room_list = anchor
//			print(bigDataGroup)
			print("请求成功")
			dispatchG.leave()

		} failure: { error in
		}
		//2.颜值
		let url = "http://capi.douyucdn.cn/api/v1/getVerticalRoom"
		dispatchG.enter()
		NetWork.requestData(type: .get, URLString: url, parameters: parameters) { [self]  result in
//						print("数据打印：\(result)")

			guard let str = result as? String,
					let jsonData = str.data(using: .utf8),
					let resp = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [String : Any] else {
				 return
			}

			guard let dictArr = resp["data"] as? [[String : Any]],
					let anchor = [RoomListModel].deserialize(from: dictArr) as? [RoomListModel] else {
				 print("解析失败")
				 return
			}
			prettyGroup.tag_name = "颜值"
			prettyGroup.icon = "home_header_phone"
			prettyGroup.room_list = anchor
//			print(prettyGroup)
			print("请求成功")
			dispatchG.leave()

		} failure: { error in
		}
		//3.其他
		let urlStr = "http://capi.douyucdn.cn/api/v1/getHotCate"

		dispatchG.enter()
		NetWork.requestData(type: .get, URLString: urlStr, parameters: parameters) { [self] result in

			guard let str = result as? String,
					let jsonData = str.data(using: .utf8),
					let resp = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [String : Any] else {
				 return
			}

			guard let dictArr = resp["data"] as? [[String : Any]],
					let anchor = [AnchorGroupModel].deserialize(from: dictArr) as? [AnchorGroupModel] else {
				 print("解析失败")
				 return
			}
			self.anchorGroups = anchor
//			print(anchorGroups)
			print("请求成功")
			dispatchG.leave()


		} failure: { error in
		}

		//
		dispatchG.notify(queue: DispatchQueue.main) { [self] in
			//数据排序
			anchorGroups.insert(prettyGroup, at: 0)
			anchorGroups.insert(bigDataGroup, at: 0)
			finishCallback()
			print("end")
		}


	}

	func requestCycleData(finishCallback:@escaping ()->()) {
		let cycleUrl = "http://www.douyutv.com/api/v1/slide/6"
		let cycleParameters:[String:String] = ["version":"2.300"]


		NetWork.requestData(type: .get, URLString: cycleUrl, parameters: cycleParameters) { [self] result in
//			print("cycleUrl:\(result)")
			guard let str = result as? String,
					let jsonData = str.data(using: .utf8),
					let resp = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [String : Any] else {
				 return
			}

			guard let dictArr = resp["data"] as? [[String : Any]],
					let models = [CycleModel].deserialize(from: dictArr) as? [CycleModel] else {
				 print("解析失败")
				 return
			}
			cycleModels = models
//			print("cycleUrl:\(result)")
			finishCallback()
			
		} failure: { error in

		}

	}
}
