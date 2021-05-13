//
//  HomeViewController.swift
//  ZJPDouYuZB
//
//  Created by 张俊平 on 2021/5/11.
//

import UIKit

private let kTitleViewH:CGFloat = 40

class HomeViewController: UIViewController {

	//	MARK:懒加载
	private lazy var pageTitleView:PageTitleView = { [weak self] in
		let titlesFrame = CGRect(x: 0, y: TOP_HEIGHT, width: kScreenW, height: kTitleViewH)
		let titles = ["推荐","游戏","娱乐","趣玩"]
		let titleView = PageTitleView(frame: titlesFrame, titles: titles)
		titleView.delegate = self
		//		titleView.backgroundColor = .red
		return titleView
	}()
	private lazy var pageContentView:PageContentView = {[weak self] in
		let contentH:CGFloat = kScreenH - TOP_HEIGHT - BOTTOM_HEIGH - kTitleViewH
		let contentFrame = CGRect(x: 0, y: TOP_HEIGHT + kTitleViewH, width: kScreenW, height: contentH)

		var childVcs = [UIViewController]()
		for _ in 0..<4 {
			let vc = UIViewController()
			vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
			childVcs.append(vc)

		}
		let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentController: self)
		return contentView
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		setupUI()
	}


}

//MARK:设置UI界面
extension HomeViewController {

	private func setupUI() {
		if #available(iOS 11.0, *){
			pageTitleView.scrollView.contentInsetAdjustmentBehavior = .never
		}else{
			automaticallyAdjustsScrollViewInsets = false
		}

		setupNavigationBar()//MARK:设置导航栏
		view.addSubview(pageTitleView)//MARK:设置titleView
		view.addSubview(pageContentView)
		pageContentView.backgroundColor = .purple

	}

	private func setupNavigationBar() {

		let btn = UIButton()
		btn.setImage(UIImage(named: "logo"), for:.normal)
		btn.sizeToFit()
		navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)

		let size = CGSize(width: 30, height: 30)
		//		let historyBtn = UIButton()
		//		historyBtn.setImage(UIImage(named: "Image_my_history"), for: .normal)
		//		historyBtn.setImage(UIImage(named: "Image_my_history_click"), for: .highlighted)
		//		historyBtn.frame = CGRect(origin:CGPoint.zero , size: size)
		//		historyBtn.sizeToFit()
		//		let historyItem = UIBarButtonItem(customView: historyBtn)
		//		let historyItem = UIBarButtonItem.creatItem(imageName: "Image_my_history", highImageName: "Image_my_history_click", size: size)  //类方法
		let historyItem = UIBarButtonItem(imageName: "Image_my_history", highImageName: "Image_my_history_click", size: size)//构造方法

		//		let searchBtn = UIButton()
		//		searchBtn.setImage(UIImage(named: "btn_search"), for: .normal)
		//		searchBtn.setImage(UIImage(named: "btn_search_clicked"), for: .highlighted)
		//		searchBtn.frame = CGRect(origin:CGPoint.zero , size: size)
		//		searchBtn.sizeToFit()
		//		let searchItem = UIBarButtonItem(customView: searchBtn)
		//		let searchItem = UIBarButtonItem.creatItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
		let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)

		//		let qrcodeBtn = UIButton()
		//		qrcodeBtn.setImage(UIImage(named: "Image_scan"), for: .normal)
		//		qrcodeBtn.setImage(UIImage(named: "Image_scan_click"), for: .highlighted)
		//		qrcodeBtn.frame = CGRect(origin:CGPoint.zero , size: size)
		//		qrcodeBtn.sizeToFit()
		//		let qrcodeItem = UIBarButtonItem(customView: qrcodeBtn)
		//		let qrcodeItem = UIBarButtonItem.creatItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
		let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)

		navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem];

	}
}

//MARK:代理方法
extension HomeViewController:PageTitleViewDelegate {
	func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
		print("\(index)")
		pageContentView.setCurrentIndex(currentIndex: index)

	}
}
