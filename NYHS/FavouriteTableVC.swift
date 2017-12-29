//
//  FavouriteTableVC.swift
//  NYHS
//
//  Created by Thinley Dorjee on 6/15/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class FavouriteTableVC: UITableViewController {

    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Favorite Schools"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.separatorStyle = .singleLine
        navigationItem.rightBarButtonItem = editButtonItem
        
        loadData()
        
        tableView.reloadData()

    }
    
    private func loadData(){
        print("load data")
        
    }

  
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
    }

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let backToDetailVc = DetailVC()
//        backToDetailVc.detailSchool = theFavouriteSchools.favoriteSchool[indexPath.row]
//        self.navigationController?.pushViewController(backToDetailVc, animated: true)
//
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)


        return cell
    }
    
    
    // MARK: - Edit section
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
    
        default:
            break
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }


}
