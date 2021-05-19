//
//  CollectionHeaderView.swift
//  ZJPDouYuZB
//
//  Created by 张俊平 on 2021/5/14.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

	@IBOutlet weak var iconIView: UIImageView!
	@IBOutlet weak var titleLb:UILabel!
	var group:AnchorGroupModel? {
		didSet {
			titleLb.text = group?.tag_name
			iconIView.image = UIImage(named: group?.icon ?? "home_header_phone")
		}
	}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
