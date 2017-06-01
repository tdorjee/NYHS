//
//  HomeViewController.swift
//  NYHS
//
//  Created by Thinley Dorjee on 5/3/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {

//     UITableViewDelegate, UITableViewDataSource
    
    var schools: [School] = []
    let cellId = "cellId"
    
    enum Boro: Int {
        case Bronx, Brooklyn, Manhattan, Queens, StatenIsland
    }
    
    var filteredSchool = [School]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.title = "Home"

        loadData()
        
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: cellId)
        
        //MARK: Search stuffs
        searchController.searchResultsUpdater = self as UISearchResultsUpdating
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.scopeButtonTitles = ["All", "No", "Yes"]
        searchController.searchBar.delegate = self
        
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
    }
    func loadData(){
        
        if let url = URL(string: "https://data.cityofnewyork.us/resource/4isn-xf7m.json"){
            
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print("Error on URLSession")
                    return
                }
                guard let data = data else {
                    print("There is an error at DATA")
                    return
                }
                
                do {
                    let jsonDict = try JSONSerialization.jsonObject(with: data, options: [])
                    guard let jsonData = jsonDict as? [[String: String]] else { return }
                    
                    //self.school = []
                    for eachData in jsonData {
                        let schools = School(dictionary: eachData)
                        self.schools.append(schools)
                        
                        //print("School count: \(self.schools.count)")
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }catch{
                    print("Error on jsonserialization")
                }
            }).resume()
            
        }
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All"){
        
        filteredSchool = schools.filter { school in
            let catagoryMatch = (scope == "All") || (school.boro == scope)
            return catagoryMatch && school.name.lowercased().contains(searchText.lowercased())

        }
        
        tableView.reloadData()
        
    }
    
    
    //MARK: Present detial view controller
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let school: School
        
        if searchController.isActive && searchController.searchBar.text != "" {
            //Change need to be here
            school = filteredSchool[indexPath.row]
        } else {
            guard let schoolInSection = Boro.init(rawValue: indexPath.section),
                var data = byBoro(schoolInSection) else {
                    return
            }
            
            //Change need to be here
            school = data[indexPath.row]
        }
      
        let detailViewController = DetailViewController()
        detailViewController.detailSchool = school
        
        let navController = UINavigationController(rootViewController: detailViewController)
        present(navController, animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.isActive && searchController.searchBar.text != "" {
            
            return filteredSchool.count
            
        }
        guard let school = Boro.init(rawValue: section),
            let data = byBoro(school) else {
                return 0
        }
        return data.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
 
        let school: School
        if searchController.isActive && searchController.searchBar.text != "" {
            school = filteredSchool[indexPath.row]
        } else {
            school = schools[indexPath.row]
        }
        
        cell.textLabel?.text = school.name
        
        guard let schoolName = Boro.init(rawValue: indexPath.section), let data = byBoro(schoolName) else {
            return cell
        }
        
        cell.textLabel?.text = data[indexPath.row].name
        
        return cell
        
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let boro = Boro.init(rawValue: section) else {
            return ""
        }
        
        switch boro {
        case .Bronx:
            return "Bronx"
        case .Brooklyn:
            return "Brooklyn"
        case .Manhattan:
            return "Manhattan"
        case .Queens:
            return "Queens"
        case .StatenIsland:
            return "Staten Island"
        }
    }


    func byBoro(_ boro: Boro) -> [School]? {
        
        let filter: (School) -> Bool
        
        switch boro {
            
        case .Bronx:
            
            filter = { (a) -> Bool in
                a.boro == "Bronx"
            }
        
        case .Brooklyn:
        
        filter = { (a) -> Bool in
            a.boro == "Brooklyn"
        }
            
        case .Manhattan:
            
            filter = { (a) -> Bool in
                a.boro == "Manhattan"
                
            }
            
        case .Queens:
            
            filter = { (a) -> Bool in
                a.boro == "Queens"
                
            }
            
        case .StatenIsland:
            
            filter = { (a) -> Bool in
                a.boro == "Staten Island"
                
            }
        }
        
        let filtered = schools.filter(filter).sorted { $0.name < $1.name }
        
        return filtered
        }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchText: searchController.searchBar.text!, scope: scope)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchText: searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}
