//
//  RecommendGameView.swift
//  ZJPDouYuZB
//
//  Created by 张俊平 on 2021/5/21.
//

import UIKit

private let kGameCellId = "kGameCellId"
private let kMargin:CGFloat = 15
class RecommendGameView: UIView {

	@IBOutlet weak var collectionView: UICollectionView!

	var groups:[AnchorGroupModel]?{
		didSet {
			groups?.remove(at: 0)
			groups?.remove(at: 0)
			var more = AnchorGroupModel()
			more.tag_name = "更多"
			groups?.append(more)

			collectionView.reloadData()
		}
	}
	override func layoutSubviews() {

		let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
		layout.itemSize = CGSize(width: 80, height: 90)
		layout.minimumLineSpacing = 0
		layout.minimumInteritemSpacing = 0
		layout.scrollDirection = .horizontal
		collectionView.isPagingEnabled = true
		collectionView.showsHorizontalScrollIndicator = false
	}

	override func awakeFromNib() {
		autoresizingMask = [.flexibleLeftMargin]
		collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellId)
		collectionView.contentInset = UIEdgeInsets(top: 0, left: kMargin , bottom: 0, right: kMargin)
	}

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension RecommendGameView {
	//提供类方法快速创建
	class func creat()->RecommendGameView {

		return Bundle.main.loadNibNamed("RecommendGameView", owner: self, options: nil)?.first as! RecommendGameView
	}
}

//MARK:UICollectionViewDataSource
extension RecommendGameView: UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

		return groups?.count ?? 0
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellId, for: indexPath) as! CollectionGameCell
		cell.group = groups![indexPath.item]

		return cell
	}


}

//MARK:UICollectionViewDelegate
extension RecommendGameView: UICollectionViewDelegate {

	func scrollViewDidScroll(_ scrollView: UIScrollView) {

	}

	//用户拖拽移除定时器
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
	}

	//拖拽停止添加定时器
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
	}
}
