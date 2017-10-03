//
//  RevisitViewController.swift
//  NYHS
//
//  Created by Thinley Dorjee on 7/21/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class RevisitViewController: UIViewController {

    var school: School?
    
    lazy internal var schoolName: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        view.addSubview(closeButton)
        view.addSubview(schoolName)
        
        closeButton.snp.makeConstraints { (button) in
            button.leading.top.equalToSuperview()
            button.height.width.equalTo(100)
        }
        
        schoolName.snp.makeConstraints({ (label) in
            label.centerX.centerY.equalToSuperview()
        })
        
        schoolName.text = school?.name
    }
    
    @objc func closeView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    internal lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        return button
    }()
    

}
