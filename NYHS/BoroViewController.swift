//
//  BoroViewController.swift
//  NYHS
//
//  Created by Thinley Dorjee on 6/2/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation
import SnapKit

// Make it UITabBarController eventually 

class BoroViewController: UITableViewController {

    let searchController = UISearchController(searchResultsController: nil)
    var filteredSchool: [School] = []
    var arrOfLatAndLng: [LatAndLng] = []
    
    
    let cellId = "MainCellId"
    let apiEndPoint: String = "https://data.cityofnewyork.us/resource/4isn-xf7m.json"
    // Map
    let mapView = GMSMapView()
    var boroSelected: String = ""
    var schools: [School] = []
    var sortSchool: [School] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.title = self.boroSelected
        
        // Search stuffs
        searchController.searchResultsUpdater = self as UISearchResultsUpdating
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        
        tableView.register(BoroTableViewCell.self, forCellReuseIdentifier: cellId)
        loadData()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(moveBack))
    
    }
    
    
    // Search func
    
    func filterContentInSearchBar(searchText: String, scope: String = "All") {
        filteredSchool = schools.filter { school in
            return school.name.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
    
    
    func moveBack(){
        dismiss(animated: true, completion: nil)
        
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
                 
                        
                        let addr = school.primary_address_line_1
                        let separatedAddr = addr.components(separatedBy: " ")
                        //Refactor into a forloop or mapping it
                        var addressStrSearch = ""
                        for i in 0..<separatedAddr.count {
                            if i == separatedAddr.count - 1 {
                                addressStrSearch.append(separatedAddr[i])
                                }else{
                                addressStrSearch.append(separatedAddr[i]+"+")
                            }
                        }
       
                        APIRequestManager.manager.getData(apiEndPoint: "https://maps.googleapis.com/maps/api/geocode/json?address=\(addressStrSearch)&key=AIzaSyDMS1l_U5Zswy_ZH51EJUNGBz-Tr-W6iCQ") { (data) in
                            
                            guard let data = data else { return }
                            
                            do{
                                guard let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
                                
                                guard let results = jsonDict["results"] as? [[String: Any]] else { return}
                                
                                for result in results {
                                    guard let geometry = result["geometry"] as? [String: Any] else { return }
                                    guard let location = geometry["location"] as? [String: Double] else { return }
                                    
                                    let theLocation = LatAndLng(dictionary: location)
                                    
                                    self.arrOfLatAndLng.append(theLocation)
                                    //print(self.arrOfLatAndLng)
                                }
                            
                                
                            } catch {
                                print(error)
                            }
                            
                        }
                        
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
        let nav = UINavigationController(rootViewController: detailVC)
        present(nav, animated: true, completion: nil)
        
        // Add map here
        
        
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let school: School
        
        if searchController.isActive && searchController.searchBar.text != ""{
            school = filteredSchool[indexPath.row]
        }else{
            
            school = sortSchool[indexPath.row]
        }
        cell.textLabel?.text = school.name
 
        return cell
    }
}

// MARK: Extension

extension BoroViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentInSearchBar(searchText: searchController.searchBar.text!)
    }
}
