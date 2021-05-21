//
//  CollectionViewCell.swift
//  ZJPDouYuZB
//
//  Created by 张俊平 on 2021/5/14.
//

import UIKit
//import Kingfisher

class CollectionViewCell: CollectionBaseCell {

	///主播房间名称
	@IBOutlet weak var roomNameLb: UILabel!
	///主播昵称
//	@IBOutlet weak var nickNameLb: UILabel!
	///主播在线人数
//	@IBOutlet weak var onlineBtn: UIButton!
	///背景图片
//	@IBOutlet weak var imageV: UIImageView!

	override var anchor:RoomListModel?{
		didSet {
			super.anchor = anchor
//			guard let anchor = anchor else {
//				return
//			}
//			var onlineStr:String = ""
//			if anchor.online! >= 10000 {
//				onlineStr = "\(Int(anchor.online!) / 10000)万在线"
//			}else{
//				onlineStr = "\(anchor.online!)在线"
//			}
//			nickNameLb.text = anchor.nickname
			roomNameLb.text = anchor?.room_name
//			onlineBtn.setTitle(onlineStr, for: .normal)
//			guard	let iconUrl = NSURL(string: anchor.vertical_src) else{return}

			//			KF.url(iconUrl as URL).set(to: iconImg)

//			KF.url(iconUrl as URL).transition(.fade(0.4)).set(to: imageV)
		}
	}
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}

}
