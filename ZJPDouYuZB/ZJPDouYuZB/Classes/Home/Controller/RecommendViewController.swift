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
		collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellId)
		collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellId)

		//注册组头
		collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil),forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: kHeaderViewId)

		collectionView.dataSource = self
		collectionView.delegate = self
		return collectionView
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
	}
}

//MARK:网络请求
extension RecommendViewController {
	private func loadData() {
		recommendVM.requestData()
	}
}

//MARK:UICollectionViewDataSource
extension RecommendViewController:UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		var cell:UICollectionViewCell
		if indexPath.section == 1 {
			cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellId, for: indexPath)
		}else {
			cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellId, for: indexPath)
		}
//		cell.backgroundColor = .red
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if section == 0 {
			 return 8
		} else {
			 return 4
		}
	}

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		 return 12
	}

	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewId, for: indexPath)
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
