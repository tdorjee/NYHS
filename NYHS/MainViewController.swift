//
//  MainViewController.swift
//  NYHS
//
//  Created by Thinley Dorjee on 6/3/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.title = "NYCHS"
        
        viewHierarchy()
        constrainConfiguration()
   
    }
    
    func viewHierarchy(){
        view.addSubview(bronxButton)
        view.addSubview(brooklynButton)
        view.addSubview(manhattanButton)
        view.addSubview(queensButton)
        view.addSubview(statenIslandButton)
    }
    
    func constrainConfiguration(){
        
        self.edgesForExtendedLayout = []
        
        bronxButton.snp.makeConstraints { (button) in
            button.top.equalToSuperview()
            button.width.equalTo(self.view.frame.width)
            button.height.equalToSuperview().multipliedBy(0.20)
        }
        
        brooklynButton.snp.makeConstraints { (button) in
            button.top.equalTo(bronxButton.snp.bottom)
            button.width.equalTo(bronxButton.snp.width)
            button.height.equalTo(bronxButton.snp.height)
        }
        
        manhattanButton.snp.makeConstraints { (button) in
            button.top.equalTo(brooklynButton.snp.bottom)
            button.width.equalTo(bronxButton.snp.width)
            button.height.equalTo(bronxButton.snp.height)
        }
        
        queensButton.snp.makeConstraints { (button) in
            button.top.equalTo(manhattanButton.snp.bottom)
            button.width.equalTo(bronxButton.snp.width)
            button.height.equalTo(bronxButton.snp.height)
        }
        
        statenIslandButton.snp.makeConstraints { (button) in
            button.top.equalTo(queensButton.snp.bottom)
            button.width.equalTo(bronxButton.snp.width)
            button.height.equalTo(bronxButton.snp.height)
        }
        
    }
    
    // Add action and segue to MainVC
    
    func selectBoroAction(sender: UIButton){
        
        let labelTitle = sender.currentTitle
        let mainVC = BoroViewController()

        mainVC.boroSelected = labelTitle!
        
       // let nav = UINavigationController(rootViewController: mainVC)
        
        // initail tabVC
        let tabVC = UITabBarController()
        
        // set first and second VC as rootVc of NavVC
        let firstVC = UINavigationController(rootViewController: mainVC)
        let secondVC = UINavigationController(rootViewController: MapViewController())
        
        // make 2 tabBarItems label
        let firstTabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "home"), tag: 0)
        let secondTabBarItem = UITabBarItem(title: "Map", image: #imageLiteral(resourceName: "map"), tag: 1)
        
        // associate the 2 barItems in 2 navVC
        firstVC.tabBarItem = firstTabBarItem
        firstVC.tabBarItem = secondTabBarItem
        
        // add 2 nav in the main tabVc
        tabVC.viewControllers = [firstVC, secondVC]
        
        // present it
        present(tabVC, animated: true, completion: nil)

    }
    
    // Do sth with this repeatation. Maybe making a func and calling it in viewdidload()
    
//    func buttons(name: UIButton, title: String) {
//        
//        var name: UIButton = {
//            
//            let button = UIButton()
//            button.setTitle(title, for: .normal)
//            button.backgroundColor = .blue
//            button.addTarget(self, action: #selector(selectBoroAction), for: .touchUpInside)
//            return button
//            
//        }()
//    }
    
    
    // MARK: Outlets
    
    internal lazy var bronxButton: UIButton = {
        let button = UIButton()
        button.setTitle("Bronx", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(selectBoroAction), for: .touchUpInside)
        return button
    }()
    
    internal lazy var brooklynButton: UIButton = {
        let button = UIButton()
        button.setTitle("Brooklyn", for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(selectBoroAction), for: .touchUpInside)
        
        return button
    }()
    
    internal lazy var manhattanButton: UIButton = {
        let button = UIButton()
        button.setTitle("Manhattan", for: .normal)
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(selectBoroAction), for: .touchUpInside)
        
        return button
    }()

    
    internal lazy var queensButton: UIButton = {
        let button = UIButton()
        button.setTitle("Queens", for: .normal)
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(selectBoroAction), for: .touchUpInside)
        
        return button
    }()

    
    internal lazy var statenIslandButton: UIButton = {
        let button = UIButton()
        button.setTitle("Staten Island", for: .normal)
        button.backgroundColor = .orange
        button.addTarget(self, action: #selector(selectBoroAction), for: .touchUpInside)
        
        return button
    }()


}
