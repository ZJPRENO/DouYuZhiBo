//
//  CollectionBaseCell.swift
//  ZJPDouYuZB
//
//  Created by 张俊平 on 2021/5/19.
//

import UIKit
import Kingfisher

class CollectionBaseCell: UICollectionViewCell {

	///主播昵称
	@IBOutlet weak var nickNameLb: UILabel!
	///主播在线人数
	@IBOutlet weak var onlineBtn: UIButton!
	///背景图片
	@IBOutlet weak var imageV: UIImageView!

	var anchor:RoomListModel? {
		didSet {
			guard let anchor = anchor else {
				return
			}
			var onlineStr:String = ""
			if anchor.online! >= 10000 {
				onlineStr = "\(Int(anchor.online!) / 10000)万在线"
			}else{
				onlineStr = "\(anchor.online!)在线"
			}
			nickNameLb.text = anchor.nickname
			onlineBtn.setTitle(onlineStr, for: .normal)
			guard	let iconUrl = NSURL(string: anchor.vertical_src) else{return}

			//			KF.url(iconUrl as URL).set(to: iconImg)

			KF.url(iconUrl as URL).transition(.fade(0.4)).placeholder(UIImage(named: "live_cell_default_phone")).set(to: imageV)
		}
	}
}
