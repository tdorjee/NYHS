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
    
    let boroWithImage = [(Boro.Bronx.rawValue, #imageLiteral(resourceName: "boroOne"),"SCHOOLS: \(119)"),  (Boro.Brooklyn.rawValue,  #imageLiteral(resourceName: "boroSix"), "SCHOOLS: \(121)"),(Boro.Manhattan.rawValue,#imageLiteral(resourceName: "boroFour") , "SCHOOLS: \(107)"), (Boro.Queens.rawValue, #imageLiteral(resourceName: "borothirteen"), "SCHOOLS: \(80)"), (Boro.StatenIsland.rawValue, #imageLiteral(resourceName: "boroTwelve"), "SCHOOLS: \(10)")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        navigationController?.navigationBar.prefersLargeTitles = true
        let filterImage = UIImage(named: "filterIcon")?.withRenderingMode(.alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: filterImage, style: .plain, target: self, action: #selector(filter))
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
