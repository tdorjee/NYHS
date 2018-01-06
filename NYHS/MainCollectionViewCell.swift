//
//  MainCollectionViewCell.swift
//  NYHS
//
//  Created by Thinley Dorjee on 11/30/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import SpriteKit

class MainCollectionViewCell: UICollectionViewCell{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 16
        iv.clipsToBounds = true
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let borough: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        return label
    }()
    
    let totalNumberOfSchool: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = ColorScheme.lightGrey
        label.numberOfLines = 2
        return label
    }()
    
    
    func setUp(){
        
        addSubview(imageView)
        addSubview(borough)
        addSubview(totalNumberOfSchool)
        
        borough.frame = CGRect(x: 30, y: 20, width: frame.width, height: 40)
        imageView.frame = CGRect(x: 10, y: 10, width: frame.width - 20, height: frame.height - 20)
        totalNumberOfSchool.frame = CGRect(x: 200, y: 400, width: frame.width, height: 40)
    }
    
    
}
