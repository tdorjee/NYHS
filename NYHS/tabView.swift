//
//  tabView.swift
//  NYHS
//
//  Created by Thinley Dorjee on 6/19/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class tabView: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstVC = MainTableViewController()
        let secondVC = FavouriteTableViewController()
        
        let firstNav = UINavigationController(rootViewController: firstVC)
        let secondNav = UINavigationController(rootViewController: secondVC)
        
        let firstBarIcon = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "home"), tag: 0)
        let secondBarIcon = UITabBarItem(title: "Favorite", image: #imageLiteral(resourceName: "favoriteIcon"), tag: 1)
        
        firstNav.tabBarItem = firstBarIcon
        secondVC.tabBarItem = secondBarIcon
        
        viewControllers = [firstNav, secondNav]
    }

}
