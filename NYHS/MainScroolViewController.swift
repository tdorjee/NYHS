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
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        view.backgroundColor = .white
//        self.title = "NYCHS"
//        
//        viewHierarchy()
//        constrainConfiguration()
//        
//    }
//    
//    func viewHierarchy(){
//        
//        view.addSubview(scrollView)
//        scrollView.addSubview(mainView)
//        
//      mainView.addSubview(bronxButton)
//      mainView.addSubview(brooklynButton)
//      mainView.addSubview(manhattanButton)
//      mainView.addSubview(queensButton)
//      mainView.addSubview(statenIslandButton)
//    }
//    
//    func constrainConfiguration(){
//        
//        self.edgesForExtendedLayout = []
//     
//        
//        scrollView.snp.makeConstraints { (scroll) in
//            scroll.top.left.right.bottom.equalToSuperview()
//        }
//        
//        mainView.snp.makeConstraints { (view) in
//            view.left.right.bottom.top.equalToSuperview()
//            view.width.equalTo(self.view.frame.width)
//        }
//        
//        bronxButton.snp.makeConstraints { (button) in
//            button.left.top.right.equalToSuperview()
//            button.width.equalToSuperview()
//            button.height.equalTo(self.view).multipliedBy(0.30)
//        }
//        
//        brooklynButton.snp.makeConstraints { (button) in
//            button.top.equalTo(bronxButton.snp.bottom)
//            button.left.right.equalToSuperview()
//            button.width.equalToSuperview()
//            button.height.equalTo(bronxButton.snp.height)
//        }
//        
//        manhattanButton.snp.makeConstraints { (button) in
//            button.top.equalTo(brooklynButton.snp.bottom)
//            button.left.right.equalToSuperview()
//            button.width.equalToSuperview()
//            button.height.equalTo(bronxButton.snp.height)
//        }
//        
//        queensButton.snp.makeConstraints { (button) in
//            button.top.equalTo(manhattanButton.snp.bottom)
//            button.left.right.equalToSuperview()
//            button.width.equalToSuperview()
//            button.height.equalTo(bronxButton.snp.height)
//        }
//        
//        statenIslandButton.snp.makeConstraints { (button) in
//            button.top.equalTo(queensButton.snp.bottom)
//            button.left.right.bottom.equalToSuperview()
//            button.width.equalToSuperview()
//            button.height.equalTo(bronxButton.snp.height)
//            
//        }
//        
//    }
//    
//    // Add action and segue to MainVC
//    
//    func selectBoroAction(sender: UIButton){
//        
//        let labelTitle = sender.currentTitle
//        let mainVC = BoroViewController()
//        
//        mainVC.boroSelected = labelTitle!
//        self.navigationController?.pushViewController(mainVC, animated: true)
//        
//        
//    }
//    
//    // MARK: Outlets
//    internal lazy var mainView: UIView = {
//        let mainView = UIView()
//        mainView.backgroundColor = .yellow
//        return mainView
//    }()
//    
//    
//    internal lazy var scrollView: UIScrollView = {
//        var scroll = UIScrollView()
//        //scroll = UIScrollView(frame: self.view.bounds)
//        //scroll.contentSize = self.view.bounds.size
//        //scroll.contentSize = CGSize(width:2000, height: 5678)
//        scroll.isScrollEnabled = true
//        scroll.backgroundColor = .red
//        scroll.isDirectionalLockEnabled = true
//        return scroll
//    }()
//    
//    
//    
//    internal lazy var bronxButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Bronx", for: .normal)
////        button.setImage(#imageLiteral(resourceName: "bronx"), for: .normal)
//        button.contentMode = .scaleAspectFit
//        button.backgroundColor = .blue
//        button.addTarget(self, action: #selector(selectBoroAction), for: .touchUpInside)
//        return button
//    }()
//    
//    internal lazy var brooklynButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Brooklyn", for: .normal)
////        button.setImage(#imageLiteral(resourceName: "brooklynHD3"), for: .normal)
//        button.contentMode = .scaleAspectFit
//        button.backgroundColor = .red
//        button.addTarget(self, action: #selector(selectBoroAction), for: .touchUpInside)
//        
//        return button
//    }()
//    
//    internal lazy var manhattanButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Manhattan", for: .normal)
////        button.setImage(, for: .normal)
//        button.contentMode = .scaleAspectFit
//        button.backgroundColor = .green
//        button.addTarget(self, action: #selector(selectBoroAction), for: .touchUpInside)
//        
//        return button
//    }()
//    
//    
//    internal lazy var queensButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Queens", for: .normal)
////        button.setImage(#imageLiteral(resourceName: "queens"), for: .normal)
//        button.contentMode = .scaleAspectFit
//        button.backgroundColor = .gray
//        button.addTarget(self, action: #selector(selectBoroAction), for: .touchUpInside)
//        
//        return button
//    }()
//    
//    
//    internal lazy var statenIslandButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Staten Island", for: .normal)
////        button.setImage(#imageLiteral(resourceName: "statenIsland"), for: .normal)
//        button.backgroundColor = .orange
//        button.addTarget(self, action: #selector(selectBoroAction), for: .touchUpInside)
//        
//        return button
//    }()
    
    
}
