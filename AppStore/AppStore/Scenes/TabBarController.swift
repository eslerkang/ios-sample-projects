//
//  TabBarController.swift
//  AppStore
//
//  Created by 강태준 on 2022/08/26.
//

import UIKit

class TabBarController: UITabBarController {
    
    private lazy var todayViewController: UIViewController = {
        let viewController = TodayViewController()
        let tabBarItem = UITabBarItem(
            title: "투데이",
            image: UIImage(systemName: "mail"),
            tag: 0
        )
        viewController.tabBarItem = tabBarItem
                
        return viewController
    }()
    
    private lazy var appViewController: UIViewController = {
        let viewController = UINavigationController(rootViewController: AppViewController())
        let tabBarItem = UITabBarItem(
            title: "앱",
            image: UIImage(systemName: "square.stack.3d.up"),
            tag: 0
        )
        viewController.tabBarItem = tabBarItem
        
        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
                
        viewControllers = [todayViewController, appViewController]
    }
}
