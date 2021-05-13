//
//  PageTitleView.swift
//  ZJPDouYuZB
//
//  Created by 张俊平 on 2021/5/11.
//

import UIKit

protocol PageTitleViewDelegate: AnyObject {//只能被类遵守
	func pageTitleView(titleView:PageTitleView,selectedIndex index:Int)
}
private let kScrollLineH:CGFloat = 2

class PageTitleView: UIView {

	private var titles:[String]
	weak var delegate:PageTitleViewDelegate?
	var currentIndex:Int = 0//下标
	//懒加载
	private lazy var titleLabels:[UILabel] = [UILabel]()

	lazy var scrollView:UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.showsHorizontalScrollIndicator = false
		scrollView.scrollsToTop = false
		scrollView.bounces = false
//		scrollView.contentInsetAdjustmentBehavior = .never
//		scrollView.backgroundColor = .orange
		return scrollView
	}()
	private lazy var scrollLine:UIView = {
		let scrollLine = UIView()
		scrollLine.backgroundColor = .orange
		return scrollLine

	}()
	//  自定义构造函数
	init(frame: CGRect,titles:[String]) {
		self.titles = titles
		super.init(frame: frame)
		setupUI()//设置ui

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}

//MARK:设置UI界面
extension PageTitleView {
	private func setupUI() {
		//1.添加UIScrollView
		addSubview(scrollView)
		scrollView.frame = bounds
		setupTitleLabels()
		setupBottomLine()
	}
	//设置滚动标题
	private func setupTitleLabels() {

		let labelW:CGFloat = frame.width / CGFloat(titles.count)
		let labelH:CGFloat = frame.height - kScrollLineH
		let labelY:CGFloat = 0

		for (index,title) in titles.enumerated() {
			let label = UILabel()
			label.text = title
			label.font = UIFont.systemFont(ofSize: 16)
			label.textColor = .darkGray
			label.tag = index
			label.textAlignment = .center
			//设置frame
			let labelX:CGFloat = labelW * CGFloat(index)
			label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
			scrollView.addSubview(label)
			titleLabels.append(label)

			//添加手势
			label.isUserInteractionEnabled = true
			let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
			label.addGestureRecognizer(tapGes)


		}
	}

	private func setupBottomLine() {
		let bottomLine = UIView()
		let lineH:CGFloat = 0.5
		bottomLine.backgroundColor = .lightGray
		bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
		addSubview(bottomLine)
		//获取第一label
		guard let firstLabel = titleLabels.first else {
			return
		}
		firstLabel.textColor = .orange
		scrollView.addSubview(scrollLine)
		scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
	}

	
}

extension PageTitleView {
	@objc private func titleLabelClick(tapGes:UITapGestureRecognizer) {
		print("ppp")
		//当前label
		guard let currentLabel = tapGes.view as? UILabel else {return}

		//之前的label
		let oldLabel = titleLabels[currentIndex]
		//改变点击label文字颜色
		currentLabel.textColor = .orange
		oldLabel.textColor = .darkGray
		//保存最新下标值
		currentIndex = currentLabel.tag

		//滚动条位置
		let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
		UIView.animate(withDuration: 0.25) {
			self.scrollLine.frame.origin.x = scrollLineX
		}

		//通知代理
		delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)

	}
}
