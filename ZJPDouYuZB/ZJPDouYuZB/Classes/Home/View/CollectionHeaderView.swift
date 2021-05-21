//
//  CollectionHeaderView.swift
//  ZJPDouYuZB
//
//  Created by 张俊平 on 2021/5/14.
//

import UIKit
import Kingfisher

class CollectionHeaderView: UICollectionReusableView {

	@IBOutlet weak var iconIView: UIImageView!
	@IBOutlet weak var titleLb:UILabel!

	var group:AnchorGroupModel? {

		didSet {

			titleLb.text = group?.tag_name
			guard	let iconUrl = group?.small_icon_url else {
				iconIView.image = UIImage(named: group?.icon ?? "home_header_phone")
				return
			}
			if iconUrl.contains("home") {
				iconIView.image = UIImage(named:iconUrl)
			}else{

				KF.url(URL(string:iconUrl )).placeholder(UIImage(named: "home_header_phone")).resizing(referenceSize: CGSize(width: 22, height: 22)).set(to: iconIView)
			}

		}
	}

	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}

}
