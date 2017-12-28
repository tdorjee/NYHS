//
//  FilterResultVC.swift
//  NYHS
//
//  Created by Thinley Dorjee on 10/22/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class FilterResultVC: UITableViewController {

    let apiEndPoint: String = "https://data.cityofnewyork.us/resource/4isn-xf7m.json"
    let cellId = "cellId"
    
    var boroChoosen: [String] = []
    var schoolSizeMin: Int?
    var schoolSizeMax: Int?
    
    var filteredSchool: [School] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Search Results"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        getData()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "X", style: .plain, target: self, action: #selector(dismissTheVC))
        navigationController?.navigationBar.isTranslucent = false
    }
    
    @objc func dismissTheVC(){
        self.dismiss(animated: true, completion: nil)
        print("Removing all existing data")
    }
    
    func getData(){
    
        APIRequestManager.manager.getData(apiEndPoint: apiEndPoint) { (data) in
            guard let data = data else { return }
            
            do {
                let jsonDict = try JSONSerialization.jsonObject(with: data, options: [])
                
                guard let jsonData = jsonDict as? [[String: String]] else { return }
                
                for eachSchool in jsonData {
                    let school = School(dictionary: eachSchool)
                    
                        if self.schoolSizeMin != nil {
                            if self.boroChoosen.contains(school.boro) {
                            guard let minSchoolSize = self.schoolSizeMin else { return }
                            guard let maxSchoolSize = self.schoolSizeMax else { return }
                            if minSchoolSize <= Int(school.total_students)! && Int(school.total_students)! <= maxSchoolSize {
                                self.filteredSchool.append(school)
                                }
                            }
                        }else {
                            if self.boroChoosen.contains(school.boro){
                                self.filteredSchool.append(school)
                            }
                        }
                   
                }
               
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch {
                print("There is a promble parsing the data ")
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSchool.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedSchool: School
        
        let detialVC = DetailVC()
        selectedSchool = filteredSchool[indexPath.row]
        detialVC.detailSchool = selectedSchool
        detialVC.senderVC = "FilterResultVC"
        self.navigationController?.pushViewController(detialVC, animated: true)
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        

            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)

        print("filter school count: \(filteredSchool.count)")
        
        let eachSchoolInCell = filteredSchool[indexPath.row]
        cell.textLabel?.text = eachSchoolInCell.name
        cell.detailTextLabel?.text = "\(eachSchoolInCell.boro) - \(eachSchoolInCell.total_students)" 
        
        return cell
        
    }

}
