//
//  CollectionCycleCell.swift
//  ZJPDouYuZB
//
//  Created by 张俊平 on 2021/5/20.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {

	@IBOutlet weak var imageView: UIImageView!

	@IBOutlet weak var titleLb: UILabel!

	@IBOutlet weak var titleView: UIView!
	var cycleModels:CycleModel? {
		
		didSet {
			guard let data = cycleModels else {return}
			titleLb.text = data.title
			KF.url(URL(string: data.pic_url)).fade(duration: 0.3).set(to: imageView)

			
		}
	}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//		autoresizingMask = .flexibleLeftMargin
    }

}
