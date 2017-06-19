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
    
    let boroWithImage = [(Boro.Bronx.rawValue, #imageLiteral(resourceName: "bronxHD2"), "Schools: \(119)"), (Boro.Brooklyn.rawValue, #imageLiteral(resourceName: "brooklynHD4"), "Schools: \(121)"), (Boro.Manhattan.rawValue, #imageLiteral(resourceName: "manhattanHD"), "Schools: \(107)"), (Boro.Queens.rawValue, #imageLiteral(resourceName: "queenHD"), "Schools: \(80)"), (Boro.StatenIsland.rawValue, #imageLiteral(resourceName: "statenIslandHD"), "Schools: \(10)") ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "NYCHS"
        self.tableView.separatorStyle = .none

        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: cellId)
        
        setUpNavBarStyle()
    }
    
//    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//    self.navigationController?.navigationBar.isTranslucent = true

    
    func setUpNavBarStyle(){
        print("Style navigation bar style")
        navigationController?.navigationBar.barTintColor = ColorScheme.navColor
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.view.backgroundColor = .clear
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
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

extension UINavigationBar {
    
    func transparentNavigationBar() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
}
