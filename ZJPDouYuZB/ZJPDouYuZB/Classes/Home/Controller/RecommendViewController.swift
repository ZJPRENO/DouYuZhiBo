//
//  RecommendViewController.swift
//  ZJPDouYuZB
//
//  Created by 张俊平 on 2021/5/14.
//

import UIKit

//MARK:常量
private let kItemMargin:CGFloat = 10
private let kHeaderViewH:CGFloat = 50.0
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 5 / 4
private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH:CGFloat = 90.0

private let kNormalCellId = "kNormalCellId"
private let kPrettyCellId = "kPrettyCellId"

private let kHeaderViewId = "kHeaderViewId"


class RecommendViewController: UIViewController {

	//MARK:懒加载
	private lazy var recommendVM:RecommendViewModel = RecommendViewModel()
	private lazy var collectionView:UICollectionView = { [unowned self] in

		let layout = UICollectionViewFlowLayout()
		layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
		layout.minimumLineSpacing = 0
		layout.minimumInteritemSpacing = kItemMargin
		layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
		layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)

		let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
		collectionView.backgroundColor = .white
		collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]//随着父视图伸缩
		collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)//设置内边距
		collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellId)
		collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellId)

		//注册组头
		collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil),forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: kHeaderViewId)

		collectionView.dataSource = self
		collectionView.delegate = self
		return collectionView
	}()
	private lazy var cycleView:RecommendCycleView = {
		let cycleView = RecommendCycleView.recommendCycleView()
		cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
		return cycleView
	}()
	private lazy var gameView:RecommendGameView = {
		let gameView = RecommendGameView.creat()
		gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
		return gameView
	}()


    override func viewDidLoad() {
        super.viewDidLoad()

		setupUI()
		//网络请求
		loadData()

    }


}


//MARK:设置UI
extension RecommendViewController {
	private func setupUI() {
		view.addSubview(collectionView)
		collectionView.addSubview(cycleView)
		collectionView.addSubview(gameView)

	}
}

//MARK:网络请求
extension RecommendViewController {
	private func loadData() {

		//
		recommendVM.requestData { [self] in
			collectionView.reloadData()
			gameView.groups = recommendVM.anchorGroups
		}
		//
		recommendVM.requestCycleData { [self] in
			cycleView.cycleModels = recommendVM.cycleModels
			
		}
	}
}

//MARK:UICollectionViewDataSource
extension RecommendViewController:UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		let group = recommendVM.anchorGroups[indexPath.section]
		let anchor = group.room_list![indexPath.item]

		if indexPath.section == 1 {
			let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellId, for: indexPath) as! CollectionPrettyCell
			prettyCell.anchor = anchor
			return prettyCell
		}else {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellId, for: indexPath) as! CollectionViewCell
			cell.anchor = anchor
			return cell
		}
//		cell.backgroundColor = .red

	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		let group = recommendVM.anchorGroups[section]
		return group.room_list!.count

	}

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return recommendVM.anchorGroups.count
	}

	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewId, for: indexPath) as! CollectionHeaderView

		headerView.group = recommendVM.anchorGroups[indexPath.section]

		return headerView

	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

		if indexPath.section == 1 {
			 return CGSize(width: kItemW, height: kPrettyItemH)
		}else {
			return CGSize(width: kItemW, height: kNormalItemH)
		}
	}


}
