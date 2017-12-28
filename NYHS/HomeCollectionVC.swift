//
//  HomeCollectionVC.swift
//  NYHS
//
//  Created by Thinley Dorjee on 11/30/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit


class HomeCollectionVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let cellId = "cellId"
    
         let boroWithImage = [(Boro.Bronx.rawValue, #imageLiteral(resourceName: "empireStateBuilding-1"), "Schools: \(119)"), (Boro.Brooklyn.rawValue, #imageLiteral(resourceName: "empireStateBuilding-1"), "Schools: \(121)"), (Boro.Manhattan.rawValue, #imageLiteral(resourceName: "empireStateBuilding-1"), "Schools: \(107)"), (Boro.Queens.rawValue, #imageLiteral(resourceName: "empireStateBuilding-1"), "Schools: \(80)"), (Boro.StatenIsland.rawValue, #imageLiteral(resourceName: "empireStateBuilding-1"), "Schools: \(10)")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        
        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filter))
        navigationItem.title = "NYCHS"
        collectionView?.backgroundColor = .white
        collectionView!.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        navigationController?.navigationBar.isTranslucent = false
        self.tabBarController?.tabBar.isTranslucent = false
    }
    
    @objc func filter() {
        let filterVC = UINavigationController(rootViewController: FilterVC())
        self.present(filterVC, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 450)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let boroTitle = boroWithImage[indexPath.item].0
        let boroVC = BoroVC()
        boroVC.boroSelected = boroTitle
        self.navigationController?.pushViewController(boroVC, animated: true)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return boroWithImage.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MainCollectionViewCell
        
        let thisCell = boroWithImage[indexPath.item]
        cell.imageView.image = thisCell.1
        cell.borough.text = thisCell.0
        cell.totalNumberOfSchool.text = thisCell.2
        
        
        return cell
    }

}
