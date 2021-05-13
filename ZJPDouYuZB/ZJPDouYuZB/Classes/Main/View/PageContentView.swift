//
//  PageContentView.swift
//  ZJPDouYuZB
//
//  Created by 张俊平 on 2021/5/13.
//

import UIKit

private let ContenCellId = "ContenCellId"

class PageContentView: UIView {



	private var childVcs:[UIViewController]
	private weak var parentViewController:UIViewController?
	private lazy var collectionView:UICollectionView = {[weak self] in

		let layout = UICollectionViewFlowLayout()
		layout.itemSize = (self?.bounds.size)!
		layout.minimumLineSpacing = 0
		layout.minimumInteritemSpacing = 0
		layout.scrollDirection = .horizontal

		let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.isPagingEnabled = true
		collectionView.bounces = false
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContenCellId)
		collectionView.backgroundColor = .red

		return collectionView

	}()

	init(frame:CGRect,childVcs:[UIViewController],parentController:UIViewController?) {
		self.childVcs = childVcs
		self.parentViewController = parentController
		super.init(frame: frame)

		setupUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}

//MARK:设置UI
extension PageContentView {
	private func setupUI() {
		//添加所有的子控制器
		for childVc in childVcs {
			parentViewController?.addChild(childVc)
		}
		//
		addSubview(collectionView)
		collectionView.frame = bounds

	}
}

//MARK:UICollectionViewDataSource
extension PageContentView:UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return childVcs.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContenCellId, for: indexPath)
		for view in cell.contentView.subviews {
			view.removeFromSuperview()
		}
		let childVc = childVcs[indexPath.item]
		childVc.view.frame = cell.contentView.bounds
		cell.contentView.addSubview(childVc.view)

		return cell

	}
}

//MARK:UICollectionViewDelegate
extension PageContentView:UICollectionViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {

	}
}
//MARK:对外暴露的方法
extension PageContentView {
	func setCurrentIndex(currentIndex:Int) {
		let offsetX = CGFloat(currentIndex) * collectionView.frame.width
		collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
	}
}
