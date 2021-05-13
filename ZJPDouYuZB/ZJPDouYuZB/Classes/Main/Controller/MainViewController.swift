//
//  MainViewController.swift
//  ZJPDouYuZB
//
//  Created by 张俊平 on 2021/5/11.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

		addChildVC(storyboardName: "Home")
		addChildVC(storyboardName: "Live")
		addChildVC(storyboardName: "Follow")
		addChildVC(storyboardName: "Profile")

	}
	private  func addChildVC(storyboardName: String) {
		let childVc = UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController()!
		addChild(childVc)
	}
    


}
