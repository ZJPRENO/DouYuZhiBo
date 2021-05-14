//
//  PageContentView.swift
//  ZJPDouYuZB
//
//  Created by 张俊平 on 2021/5/13.
//

import UIKit

protocol PageContentViewDelegate:AnyObject {
	func pageContentView(contentView:PageContentView,progress:CGFloat,sourceIndex:Int,targetIndex:Int)
}
private let ContenCellId = "ContenCellId"

class PageContentView: UIView {

	private var childVcs:[UIViewController]
	private var statrOffset:CGFloat = 0
	weak var delegate:PageContentViewDelegate?
	private weak var parentViewController:UIViewController?
	private var isForbidScrollDelegate: Bool = false//点击的时候不滚动
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

	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		statrOffset = scrollView.contentOffset.x
		isForbidScrollDelegate = false
	}
	func scrollViewDidScroll(_ scrollView: UIScrollView) {

		//如果是点击标题就不滚动
		if isForbidScrollDelegate {return}
		//
		var progress:CGFloat = 0
		var sourceIndex:Int = 0
		var targetIndex:Int = 0


		let currentOffsetX = scrollView.contentOffset.x
		let scrollViewW = scrollView.bounds.width
		if currentOffsetX > statrOffset {//左滑
			progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
			sourceIndex = Int(currentOffsetX / scrollViewW)
			targetIndex = sourceIndex + 1
			if targetIndex >= childVcs.count {
				targetIndex = childVcs.count - 1
			}
			//如果完全滑过
			if currentOffsetX - statrOffset == scrollViewW {
				progress = 1
				targetIndex = sourceIndex
			}
		} else {//右划
			progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
			targetIndex = Int(currentOffsetX / scrollViewW)
			sourceIndex = targetIndex + 1
			if sourceIndex >= childVcs.count {
				sourceIndex = childVcs.count - 1
			}
		}
		delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
		print("progress:\(progress),sourceIndex:\(sourceIndex),targetIndex:\(targetIndex)")




	}
}
//MARK:对外暴露的方法
extension PageContentView {
	func setCurrentIndex(currentIndex:Int) {
		isForbidScrollDelegate = true//记录禁止执行代理方法
		let offsetX = CGFloat(currentIndex) * collectionView.frame.width
		collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
	}
}
