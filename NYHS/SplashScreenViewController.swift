//
//  SplashScreenViewController.swift
//  NYHS
//
//  Created by Thinley Dorjee on 6/17/17.
//  Copyright © 2017 C4Q. All rights reserved.
//
import UIKit
import SnapKit

class SplashScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        viewHierarchy()
        constraintConfiguration()
        
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.splashTimeOut(sender:)), userInfo: nil, repeats: false)
        
        UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseInOut, animations: {
            self.icon.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseInOut, animations: {
            self.iconLabel.alpha = 1.0
        }, completion: nil)
        
        //perform(#selector(SegueToOnboardVc), with: nil, afterDelay: 4)
        
        navigationController?.isNavigationBarHidden = true
        
    }
    
    func viewHierarchy(){
        
        
        view.addSubview(icon)
        view.addSubview(iconLabel)
        
        
    }
    
    func constraintConfiguration(){
        
        icon.snp.makeConstraints { (icon) in
            icon.centerX.equalToSuperview()
            icon.centerY.equalToSuperview()
            icon.height.equalTo(100)
            icon.width.equalTo(100)
        }
        
        iconLabel.snp.makeConstraints { (label) in
            
            label.left.equalToSuperview().offset(8)
            label.top.equalTo(icon.snp.bottom).offset(8)
            
        }
        
    }
    
    @objc func splashTimeOut(sender: Timer){
        AppDelegate.sharedInstance().window?.rootViewController = MainView()
    }
    
//    func SegueToOnboardVc(){
//        _ = UserDefaults.standard
//        
//            let onboardVC = tabView()
//            self.navigationController?.pushViewController(onboardVC, animated: true)
//      
//    }
  
    internal lazy var icon: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "appIcon1")
        image.alpha = 0.0
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    internal lazy var iconLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NYCHSnl;olfjelj'adkn", size: 22)
        label.backgroundColor = .red
        return label
    }()
    
}
