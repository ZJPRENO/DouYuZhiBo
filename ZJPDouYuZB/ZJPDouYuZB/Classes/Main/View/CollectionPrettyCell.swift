//
//  CollectionPrettyCell.swift
//  ZJPDouYuZB
//
//  Created by 张俊平 on 2021/5/14.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: UICollectionViewCell {
	///主播昵称
	@IBOutlet weak var nickNameLb: UILabel!
	///背景图
	@IBOutlet weak var iconImg: UIImageView!
	///主播所在城市
	@IBOutlet weak var cityBtn: UIButton!
	///当前在线人数
	@IBOutlet weak var onlineBtn: UIButton!
	
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
			cityBtn.setTitle(anchor.anchor_city, for: .normal)
			guard	let iconUrl = NSURL(string: anchor.vertical_src) else{return}

//			KF.url(iconUrl as URL).set(to: iconImg)
			KF.url(iconUrl as URL).transition(.fade(0.4)).set(to: iconImg)

//			iconImg.kf.setImage(with: iconUrl, placeholder: nil, options: [.transition(.fade(0.4))], progressBlock: nil, completionHandler: nil)

//			let provider = AVAssetImageDataProvider(
//				 assetURL: URL(string: "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_1280_10MG.mp4")!,
//				 seconds: 15.0
//			)
//			KF.dataProvider(provider).set(to: iconImg)


		}
	}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
