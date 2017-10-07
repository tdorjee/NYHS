//
//  MainTableViewController.swift
//  NYHS
//
//  Created by Thinley Dorjee on 6/17/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    let cellId = "cellId"
    
    let boroWithImage = [(Boro.Bronx.rawValue, #imageLiteral(resourceName: "brooklynHD4"), "Schools: \(119)"), (Boro.Brooklyn.rawValue, #imageLiteral(resourceName: "brooklynHD4"), "Schools: \(121)"), (Boro.Manhattan.rawValue, #imageLiteral(resourceName: "brooklynHD4"), "Schools: \(107)"), (Boro.Queens.rawValue, #imageLiteral(resourceName: "brooklynHD4"), "Schools: \(80)"), (Boro.StatenIsland.rawValue, #imageLiteral(resourceName: "brooklynHD4"), "Schools: \(10)")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "NYCHS"
        self.tableView.separatorStyle = .none
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterPage))

        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: cellId)
        
//        setUpNavBarStyle()
    }
    
    // MARK: - Display filter page
    
    func filterPage(){
        let filterNav = UINavigationController(rootViewController: FilterViewController())
        self.present(filterNav, animated: true, completion: nil)
    }
    
    //MARK: Not calling it for second itteration of design
    
    func setUpNavBarStyle(){
        navigationController?.navigationBar.barTintColor = ColorScheme.navColor
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.view.backgroundColor = .clear
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let labelTitle = boroWithImage[indexPath.row].0
        let mainVC = BoroViewController()
        
        mainVC.boroSelected = labelTitle
        self.navigationController?.pushViewController(mainVC, animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boroWithImage.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MainTableViewCell

        let thisBoro = boroWithImage[indexPath.row]
        
        cell.cellImage.image = thisBoro.1
        cell.cellLabel.text = thisBoro.0
        cell.schoolNumberLabel.text = thisBoro.2
        

        return cell
    }

}

// MARK: - Not calling it for second itteration of UI design

//extension UINavigationBar {
//
//    func transparentNavigationBar() {
//        self.setBackgroundImage(UIImage(), for: .default)
//        self.shadowImage = UIImage()
//        self.isTranslucent = true
//    }
//}

