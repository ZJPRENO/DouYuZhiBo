//
//  AnchorGroup.swift
//  ZJPDouYuZB
//
//  Created by 张俊平 on 2021/5/17.
//

import Foundation
import HandyJSON

struct RoomListModel: HandyJSON {

	var room_name: String = ""//房间名称
	var room_id: Int?//房间id
	var nickname:String = ""//主播昵称
	var online:Int? = 0 //在线人数

	var vertical_src:String = ""//图片url
	var isVertical:Int?//0 直播 手机直播
	var anchor_city:String? ///所在城市


}

struct AnchorGroupModel : HandyJSON {

	var tag_name: String?
	var tag_id: String?
	var room_list: [RoomListModel]?
	var icon:String?


}

//class AnchorGroup : HandyJSON {
//	/// 房间信息
//	var room_list: [[String:NSObject]]?
//	var tag_name:String = ""
//	var icon_name: String = "home_header_normal"
//
//	required init() {}
//}
