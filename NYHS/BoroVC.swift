//
//  BoroVC.swift
//  NYHS
//
//  Created by Thinley Dorjee on 6/2/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class BoroVC: UITableViewController {
    
    let cellId = "MainCellId"
    let apiEndPoint: String = "https://data.cityofnewyork.us/resource/4isn-xf7m.json"
    
    var boroSelected: String = ""
    var schools: [School] = []
    var sortSchool: [School] = []
    var filteredSchool: [School] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    // MARK: - Shimmering
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        self.tableView.reloadData()
//        Loader.addLoaderTo(self.tableView)
//        Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(BoroVC.loaded), userInfo: nil, repeats: false)
//
//    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = boroSelected
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Try keyword"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        tableView.register(BoroTableViewCell.self, forCellReuseIdentifier: cellId)
        
        loadData()
        
    }
    
    // Search func
    func filterContentInSearchBar(searchText: String, scope: String = "All") {
        filteredSchool = schools.filter { school in
            return school.name.lowercased().contains(searchText.lowercased())
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
    
    // MARK: - Hight light func
    
    func hightSearchTitle(searchString: String, resultString: String) -> NSMutableAttributedString {
        
        let attributedString = NSMutableAttributedString(string: resultString)
        let pattern = searchString.lowercased()
        let range = NSMakeRange(0, resultString.count)
        
        let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options())
        
        regex.enumerateMatches(in: resultString.lowercased(), options: NSRegularExpression.MatchingOptions(), range: range) {
            (textCheckingResult, matchingFlags, stop) -> Void in
            let subRange = textCheckingResult?.range
            attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.blue, range: subRange!)
        }
        return attributedString
        
    }
    
    // MARK: - Bold search result
    
    func boldSearchResult(searchString: String, resultString: String) -> NSMutableAttributedString {
        
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: resultString)
        let pattern = searchString.lowercased()
        let range: NSRange = NSMakeRange(0, resultString.count)
        
        let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options())
        
        regex.enumerateMatches(in: resultString.lowercased(), options: NSRegularExpression.MatchingOptions(), range: range) { (textCheckingResult, matchingFlags, stop) -> Void in
            let subRange = textCheckingResult?.range
            attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.boldSystemFont(ofSize: 15.0), range: subRange!)
        }
        return attributedString
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentSchool: School
        
        if searchController.isActive && searchController.searchBar.text != "" {
            currentSchool = filteredSchool[indexPath.row]
        }else{
            currentSchool = sortSchool[indexPath.row]
        }
        let detailVC = DetailVC()
        detailVC.detailSchool = currentSchool
        detailVC.senderVC = "addFav"
        
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
            
            cell.titleLabel.attributedText = hightSearchTitle(searchString: searchController.searchBar.text!, resultString: school.name)
            cell.detailLabel.attributedText = boldSearchResult(searchString: searchController.searchBar.text!, resultString: school.overview_paragraph)
        }else{
            school = sortSchool[indexPath.row]
        }
        
        cell.titleLabel.numberOfLines = 0
        cell.titleLabel.lineBreakMode = .byWordWrapping
        cell.titleLabel.text = school.name
        cell.detailLabel.text = school.overview_paragraph
        cell.detailLabel.lineBreakMode = .byTruncatingTail
        cell.detailLabel.textColor = UIColor(white: 0, alpha: 0.5)
        cell.detailLabel.numberOfLines = 3
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

// MARK: Extension
extension BoroVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentInSearchBar(searchText: searchController.searchBar.text!)
    }
}
