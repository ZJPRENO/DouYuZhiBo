//
//  PageTitleView.swift
//  ZJPDouYuZB
//
//  Created by 张俊平 on 2021/5/11.
//

import UIKit

//MARK:定义协议
protocol PageTitleViewDelegate: AnyObject {//只能被类遵守
	func pageTitleView(titleView:PageTitleView,selectedIndex index:Int)
}
//MARK:定义常量
private let kScrollLineH:CGFloat = 2
private let kNormalColor:(CGFloat,CGFloat,CGFloat) = (85,85,85)//元组
private let kSelectColor:(CGFloat,CGFloat,CGFloat) = (255,128,0)

//MARK:PageTitleView类
class PageTitleView: UIView {
	//MARK:定义属性
	private var titles:[String]
	weak var delegate:PageTitleViewDelegate?
	var currentIndex:Int = 0//下标
	//MARK:懒加载
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
	//MARK:自定义构造函数
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
			label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
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
		firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
		scrollView.addSubview(scrollLine)
		scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
	}

	
}

extension PageTitleView {
	@objc private func titleLabelClick(tapGes:UITapGestureRecognizer) {
//		print("ppp")

		//当前label
		guard let currentLabel = tapGes.view as? UILabel else {return}
		//如何点击的是同一个label就直接返回
		if currentLabel.tag == currentIndex {return}
		//之前的label
		let oldLabel = titleLabels[currentIndex]

		//改变点击label文字颜色
		currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
		oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
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
//MARK:对外暴露的方法
extension PageTitleView {
	func setTitleWithProgress(progress:CGFloat,sourceIndex:Int,targetIndex:Int) {
		 //取出label
		let soureLabel = titleLabels[sourceIndex]
		let targetLabel = titleLabels[targetIndex]
		//处理滑块的逻辑
		let moveTotalX = targetLabel.frame.origin.x - soureLabel.frame.origin.x
		let moveX = moveTotalX * progress
		scrollLine.frame.origin.x = soureLabel.frame.origin.x + moveX
		//颜色渐变处理
		let colorRange = (kSelectColor.0-kNormalColor.0,kSelectColor.1-kNormalColor.1,kSelectColor.2-kNormalColor.2)

		soureLabel.textColor = UIColor(r: kSelectColor.0-colorRange.0*progress, g: kSelectColor.1-colorRange.1*progress, b: kSelectColor.2-colorRange.2*progress)

		targetLabel.textColor = UIColor(r: kNormalColor.0+colorRange.0*progress, g: kNormalColor.1+colorRange.1*progress, b: kNormalColor.2+colorRange.2*progress)

		//记录最新的index
		currentIndex = targetIndex;


	}
}
