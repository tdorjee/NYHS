//
//  MainCollectionViewCell.swift
//  NYHS
//
//  Created by Thinley Dorjee on 11/30/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import SpriteKit

class MainCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate{
    
    private let subCellId = "cellId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        backgroundColor = .white
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let title: UILabel = {
        let label = UILabel()
        label.text = "Boroughs"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    let topSubCollectionV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let topSubCollectionV =  UICollectionView(frame: .zero, collectionViewLayout: layout)
        topSubCollectionV.backgroundColor = .white
        topSubCollectionV.translatesAutoresizingMaskIntoConstraints = false
        return topSubCollectionV
    }()
    
    func setUp(){
        
        addSubview(title)
        addSubview(topSubCollectionV)
        title.frame = CGRect(x: 14, y: 0, width: frame.width, height: 40)
        topSubCollectionV.snp.makeConstraints { (cell) in
            cell.top.equalTo(title.snp.bottom)
            cell.left.right.bottom.equalToSuperview()
        }
        topSubCollectionV.dataSource = self
        topSubCollectionV.delegate = self
        
        topSubCollectionV.register(SubCell.self, forCellWithReuseIdentifier: subCellId)
        
        
    }
    
    // MARK: SNEP
 
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let cellValue = scrollView.contentOffset.x
        
        switch cellValue {
        case  0...150.0:
            print("First cell")
            scrollView.isPagingEnabled = true
        case 151.0...300.0:
            scrollView.isPagingEnabled = true
        case 301.0...600.0:
            scrollView.isPagingEnabled = true
        case 601.0...800.0:
            scrollView.isPagingEnabled = true
        default:
                print("Fivth cell")
        }
    }
    
//    let middlePoint = Int(scrollView.contentOffset.x + UIScreen.main.bounds.width / 2)
//    if let indexPath = self.cvCollectionView.indexPathForItem(at: CGPoint(x: middlePoint, y: 0)) {
//        self.cvCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//    }
//
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        <#code#>
//    }
    
   
    
//    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        snapToNearestCell(scrollView)
//    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: subCellId, for: indexPath) as! SubCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 320, height: 320)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
}

class SubCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        backgroundColor = .white

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
    

    
    let borough: UILabel = {
       let label = UILabel()
        label.text = "Queens"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let totalNumberOfSchool: UILabel = {
       let label = UILabel()
        label.text = "The Numbe of Student"
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 2
        label.textColor = ColorScheme.subtitleTextColor
        return label
    }()
    
    
    func setUp(){
        
        addSubview(imageView)
        addSubview(borough)
        addSubview(totalNumberOfSchool)
        
        imageView.frame = CGRect(x: 0, y: -28, width: frame.width, height: frame.height)
        borough.frame = CGRect(x: 0, y: frame.width - 38, width: frame.width, height: 40)
        totalNumberOfSchool.frame = CGRect(x: 0, y: frame.width - 18, width: frame.width, height: 40)
    }
    
}
