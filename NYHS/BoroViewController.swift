//
//  BoroViewController.swift
//  NYHS
//
//  Created by Thinley Dorjee on 6/2/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import SnapKit

// Make it UITabBarController eventually 

class BoroViewController: UITableViewController {

    let cellId = "MainCellId"
    let apiEndPoint: String = "https://data.cityofnewyork.us/resource/4isn-xf7m.json"
    
    var boroSelected: String = ""
    var schools: [School] = []
    var sortSchool: [School] = []
    var filteredSchool: [School] = []
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.title = self.boroSelected
        
        navigationItem.rightBarButtonItem = editButtonItem
        
        // Search stuffs
        searchController.searchResultsUpdater = self as UISearchResultsUpdating
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        tableView.register(BoroTableViewCell.self, forCellReuseIdentifier: cellId)
        loadData()
    
    }
    
    
    // Search func
    func filterContentInSearchBar(searchText: String, scope: String = "All") {
        filteredSchool = schools.filter { school in
            return school.name.lowercased().contains(searchText.lowercased()) ||
            school.extracurricular_activities.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
    
    func loadData(){

        APIRequestManager.manager.getData(apiEndPoint: apiEndPoint) { (data) in
            guard let data = data else { return }
            
            do{
                let jsonDict = try JSONSerialization.jsonObject(with: data, options: [])
                guard let jsonData = jsonDict as? [[String: String]] else { return }
                
                for eachSchool in jsonData {
                    let school = School(dictionary: eachSchool)
                    
                    if school.boro == self.boroSelected {
                        self.schools.append(school)
                 
                        
                    }
                    
                    self.sortSchool = self.schools.sorted(by: { $0.name < $1.name })
 
                }

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }catch{
                print("Error encountered at do & chatch")
            }
        }
        
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentSchool: School
        
        if searchController.isActive && searchController.searchBar.text != "" {
            currentSchool = filteredSchool[indexPath.row]
        }else{
            currentSchool = sortSchool[indexPath.row]
        }
        
        
        let detailVC = DetailViewController()
        detailVC.detailSchool = currentSchool
        self.navigationController?.pushViewController(detailVC, animated: true)

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredSchool.count
        }
        return self.sortSchool.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BoroTableViewCell
        
        let school: School
        
        if searchController.isActive && searchController.searchBar.text != ""{
            school = filteredSchool[indexPath.row]
        }else{
            
            school = sortSchool[indexPath.row]
        }
        //cell.titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        //cell.titleLabel.numberOfLines = 0
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = school.name
        //cell.titleLabel.symbo
        //cell.detailLabel.text = school.phone_number
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let more = UITableViewRowAction(style: .normal, title: "More") { action, index in
            print("More action pressed")
        }
        more.backgroundColor = .gray
        
        let email = UITableViewRowAction(style: .normal, title: "Mail") { action, index in
            print("Mail button pressed")
        }
        email.backgroundColor = .red
        
        let phone = UITableViewRowAction(style: .normal, title: "Call") { action, index in
            print("Make phone call")
            
            if let phoneUrl = URL(string: self.sortSchool[indexPath.row].phone_number){                UIApplication.shared.open(phoneUrl, options: [:], completionHandler: nil)
            }
        }
        phone.backgroundColor = .green
        
        return [more, email, phone]
    }
    
}

// MARK: Extension

extension BoroViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentInSearchBar(searchText: searchController.searchBar.text!)
    }
}
