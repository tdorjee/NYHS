//
//  FavouriteTableVC.swift
//  NYHS
//
//  Created by Thinley Dorjee on 6/15/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class FavouriteTableVC: UITableViewController {
    
    
    var storedSchool = [School]()
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorite Schools"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.separatorStyle = .singleLine
        navigationItem.rightBarButtonItem = editButtonItem
        self.tableView.reloadData()
    }
    
    // MARK: - Load Data
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        retrieveSchool()
        self.tableView.reloadData()
        
    }
    
    @objc func retrieveSchool() {
        if let unarchivedObject = UserDefaults.standard.object(forKey: "school") as? NSData {
            storedSchool = (NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject as Data) as? [School])!
        }
        
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storedSchool.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let backToDetailVc = DetailVC()
        backToDetailVc.detailSchool = storedSchool[indexPath.row]
        self.navigationController?.pushViewController(backToDetailVc, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let thisCell = storedSchool[indexPath.row]
        cell.textLabel?.text = thisCell.name
        
        return cell
    }
    
    
    // MARK: - Edit section
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            storedSchool.remove(at: indexPath.row)
            updateStoreSchool()
            retrieveSchoolAgainAfterDeletion()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func updateStoreSchool(){
        let favSchoolData = DetailVC().archiveSchool(schoolArr: storedSchool)
        let userDefault: UserDefaults = UserDefaults.standard
        userDefault.set(favSchoolData, forKey: "school")
    }
    
    @objc func retrieveSchoolAgainAfterDeletion(){
        if let unarchivedObject = UserDefaults.standard.object(forKey: "school") as? NSData {
            storedSchool = (NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject as Data) as? [School])!
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
