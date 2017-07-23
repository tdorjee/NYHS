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
        
        view.addSubview(schoolName)
        
        schoolName.snp.makeConstraints({ (label) in
            label.centerX.centerY.equalToSuperview()
        })
        
        schoolName.text = school?.name
    }

}
