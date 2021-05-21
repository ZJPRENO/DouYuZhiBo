//
//  CollectionGameCell.swift
//  ZJPDouYuZB
//
//  Created by 张俊平 on 2021/5/21.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {

	@IBOutlet weak var titleLb: UILabel!
	@IBOutlet weak var imageView: UIImageView!
	
	var group:AnchorGroupModel?{
		didSet {
			titleLb.text = group?.tag_name
			KF.url(URL(string: group!.icon_url)).placeholder(UIImage(named: "home_more_btn")).fade(duration: 0.25).set(to: imageView)

		}
	}
    override func awakeFromNib() {
        super.awakeFromNib()
		
		imageView.layer.cornerRadius = 24.5;
		imageView.layer.masksToBounds = true
		autoresizingMask = .flexibleLeftMargin
        // Initialization code
    }

}
