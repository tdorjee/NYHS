//
//  BoroViewController.swift
//  NYHS
//
//  Created by Thinley Dorjee on 6/2/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class BoroViewController: UITableViewController {
    
    let cellId = "MainCellId"
    let apiEndPoint: String = "https://data.cityofnewyork.us/resource/4isn-xf7m.json"
    
    var boySports: [String] = []
    var girlSport: [String] = []
    
    let sections = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    
    var boroSelected: String = ""
    
    var schools: [School] = []
    
    var sortSchool: [School] = []
    
    var filteredSchool: [School] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Schools"
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
        
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            // Fallback on earlier versions
            
            // searchController.hidesNavigationBarDuringPresentation = false
            // navigationItem.titleView = searchController.searchBar
            // definesPresentationContext = true
            
        }
        
        searchController.searchBar.searchBarStyle  = .default
        searchController.searchBar.placeholder = "Try Name, Address, Sports"
        
        
        // Search stuffs
        searchController.searchResultsUpdater = self as UISearchResultsUpdating
        searchController.dimsBackgroundDuringPresentation = false

        tableView.register(BoroTableViewCell.self, forCellReuseIdentifier: cellId)
        loadData()
        
        // SetBackBarButtonCustom()
        
        
    }
    
    //MARK: - Not calling it for second iteration designs
    
    func SetBackBarButtonCustom() {
        
        let btnLeftMenu: UIButton = UIButton()
        btnLeftMenu.setImage(#imageLiteral(resourceName: "customBackButton2"), for: .normal)
        btnLeftMenu.addTarget(self, action: #selector(onClcikBack), for: .touchUpInside)
        btnLeftMenu.frame = CGRect(x: 0, y: 0, width: 50/2, height: 50/2)
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    @objc func onClcikBack(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // Search func
    func filterContentInSearchBar(searchText: String, scope: String = "All") {
        filteredSchool = schools.filter { school in
            return school.name.lowercased().contains(searchText.lowercased())
            //                ||
            //            school.extracurricular_activities.lowercased().contains(searchText.lowercased()) || school.primary_address_line_1.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
    
    func loadData(){
        
        APIRequestManager.manager.getData(apiEndPoint: apiEndPoint) { (data) in
            guard let data = data else { return }
            do{
                let jsonDict = try JSONSerialization.jsonObject(with: data, options: [])
                guard let jsonData = jsonDict as? [[String: String]] else { return }
                
                // Get the largest and smallest high school
                
                var largestStudentNum: Int = 0
                var leastStudentNum: Int = 5000
                
                for eachSchool in jsonData {
                    let school = School(dictionary: eachSchool)
                    // MARK: - Retrive school sport
                    
   
                    guard let schoolSize = Int(school.total_students) else { return }
                    
                    
                    if schoolSize > largestStudentNum{
                        largestStudentNum = schoolSize
                    }
                    
                    if schoolSize < leastStudentNum {
                        leastStudentNum = schoolSize
                    }
                    
                    let eachBoySports = school.psal_sports_boys.components(separatedBy: ",")
                    let eachGirlSports = school.psal_sports_girls.components(separatedBy: ",")
                    
                    
                    
                    for i in eachBoySports{
                        if !i.hasPrefix(" "){
                            if !self.boySports.contains(i){
                                self.boySports.append(i)
                            }
                        }
                    }
                    
                    
                    for j in eachGirlSports {
                        if !self.girlSport.contains(j){
                            self.girlSport.append(j)
                        }
                    }
                    
                    let filterGirlSport = self.girlSport.filter{!$0.hasPrefix(" ")}
                    
                    print("All girl sports that has perfix: \(filterGirlSport)")
                    
                    if school.boro == self.boroSelected {
                        self.schools.append(school)
                        
                    }
                    
                    print("largest number of student: \(largestStudentNum)")
                    print("smallest number of studtent: \(leastStudentNum)")
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
        let range = NSMakeRange(0, resultString.characters.count)
        
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
        let range: NSRange = NSMakeRange(0, resultString.characters.count)
        
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
            
            cell.titleLabel.attributedText = hightSearchTitle(searchString: searchController.searchBar.text!, resultString: school.name)
            cell.detailLabel.attributedText = boldSearchResult(searchString: searchController.searchBar.text!, resultString: school.overview_paragraph)
        }else{
            
            
            school = sortSchool[indexPath.row]
        }
        
        
        //cell.textLabel?.text = school.name
        
        cell.titleLabel.numberOfLines = 0
        cell.titleLabel.lineBreakMode = .byWordWrapping
        cell.titleLabel.text = school.name
   
        
        cell.detailLabel.text = school.overview_paragraph
        cell.detailLabel.lineBreakMode = .byTruncatingTail
        cell.detailLabel.textColor = UIColor(white: 0, alpha: 0.5)
        cell.detailLabel.numberOfLines = 3
        
        
        return cell
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.sections
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
