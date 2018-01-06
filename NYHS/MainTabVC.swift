//
//  MainTabVC.swift
//  NYHS
//
//  Created by Thinley Dorjee on 6/19/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class MainTabVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        let mainCollectionVC =  HomeCollectionVC(collectionViewLayout: layout)
        
        let firstVC = mainCollectionVC
        let secondVC = FavouriteTableVC()
        
        let firstNav = UINavigationController(rootViewController: firstVC)
        let secondNav = UINavigationController(rootViewController: secondVC)
        
        let firstBarIcon = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "home"), tag: 0)
        let secondBarIcon = UITabBarItem(title: "Favorites", image: #imageLiteral(resourceName: "favoriteIcon"), tag: 1)
        
        firstNav.tabBarItem = firstBarIcon
        secondVC.tabBarItem = secondBarIcon
        viewControllers = [firstNav, secondNav]
        
         self.tabBarController?.tabBar.isTranslucent = false

    }
    
    
}
