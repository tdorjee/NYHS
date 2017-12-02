//
//  MainCollectionViewCell.swift
//  NYHS
//
//  Created by Thinley Dorjee on 11/30/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import SpriteKit

class MainCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    private let subCellId = "cellId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let topSubCollectionV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let topSubCollectionV =  UICollectionView(frame: .zero, collectionViewLayout: layout)
        topSubCollectionV.backgroundColor = .white
        topSubCollectionV.translatesAutoresizingMaskIntoConstraints = false
        return topSubCollectionV
    }()
    
    func setUp(){
        
        addSubview(topSubCollectionV)
        topSubCollectionV.snp.makeConstraints { (cell) in
            cell.left.top.right.bottom.equalToSuperview()
        }
        
        topSubCollectionV.dataSource = self
        topSubCollectionV.delegate = self
        
        topSubCollectionV.register(SubCell.self, forCellWithReuseIdentifier: subCellId)
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: subCellId, for: indexPath) as! SubCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
}

class SubCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "empireStateBuilding-1")
        iv.layer.cornerRadius = 16
        iv.clipsToBounds = true
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let totalNumberOfSchool: UILabel = {
       let label = UILabel()
        label.text = "The Numbe of Student"
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 2
        return label
    }()
    
    func setUp(){
        addSubview(imageView)
        addSubview(totalNumberOfSchool)
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        totalNumberOfSchool.frame = CGRect(x: 0, y: frame.width + 2, width: frame.width, height: 40)
    }
    
}
