//
//  RecommendCycleView.swift
//  ZJPDouYuZB
//
//  Created by 张俊平 on 2021/5/19.
//

import UIKit

private let cycleCellId = "cycleCellId"

class RecommendCycleView: UIView {

	//MARK:控件
	@IBOutlet weak var pageControl: UIPageControl!
	@IBOutlet weak var collectionView: UICollectionView!
	var cycleTimer:Timer?
	var cycleModels:[CycleModel]? {

		didSet {
			collectionView.reloadData()//刷新轮播图
			pageControl.numberOfPages = cycleModels?.count ?? 0
			//默认让轮播图 滚到某个中间值 这样要是用户往前滚动 就可以滚动了
			let indexPath = NSIndexPath(item: (cycleModels?.count ?? 0)*100, section: 0)
			collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)

			//添加定时器
			removeCyclyTimer()//先移除再添加
			addCyclyTimer()
		}
	}


	override func awakeFromNib() {
		super.awakeFromNib()

		collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: cycleCellId)
	}

	override func layoutSubviews() {

		let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
		layout.itemSize = CGSize(width: kScreenW, height: (kScreenW * 3 / 8))
		layout.minimumLineSpacing = 0
		layout.minimumInteritemSpacing = 0
		layout.scrollDirection = .horizontal
		collectionView.isPagingEnabled = true
		collectionView.showsHorizontalScrollIndicator = false
	}
}

extension RecommendCycleView {

	class func recommendCycleView()->RecommendCycleView {

		return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
	}
}

//MARK:UICollectionViewDataSource
extension RecommendCycleView: UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

		return (cycleModels?.count ?? 0)*10000//实现无线轮播
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cycleCellId, for: indexPath) as! CollectionCycleCell
		cell.cycleModels = cycleModels![indexPath.item % (cycleModels?.count ?? 1)]
		return cell
	}


}

//MARK:UICollectionViewDelegate
extension RecommendCycleView: UICollectionViewDelegate {

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let offset = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
		pageControl.currentPage = Int(offset / scrollView.bounds.width) % (cycleModels?.count ?? 1)
	}

	//用户拖拽移除定时器
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		 removeCyclyTimer()
	}

	//拖拽停止添加定时器
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		 addCyclyTimer()
	}
}

//MARK:定时器
extension RecommendCycleView {

	private func addCyclyTimer() {
		cycleTimer = Timer(timeInterval: 2.5, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
		RunLoop.main.add(cycleTimer!, forMode: .common)
	}

	private func removeCyclyTimer() {
		cycleTimer?.invalidate()//定时器从运行循环中移除
		cycleTimer = nil
	}
	@objc private func scrollToNext() {
		//获取滚动的偏移量
		let currentOfsetX = collectionView.contentOffset.x
		let offsetX = currentOfsetX + collectionView.bounds.width
		//滚动到改位置上
		collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)


	}
}
