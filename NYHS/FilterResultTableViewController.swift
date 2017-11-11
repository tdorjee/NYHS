//
//  FilterResultTableViewController.swift
//  NYHS
//
//  Created by Thinley Dorjee on 10/22/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class FilterResultTableViewController: UITableViewController {

    let apiEndPoint: String = "https://data.cityofnewyork.us/resource/4isn-xf7m.json"
    let cellId = "cellId"
    
    var boroChoosen: [String] = []
    var schoolSizeMin: Int?
    var schoolSizeMax: Int?
    
    var filteredSchool: [School] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        getData()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "X", style: .plain, target: self, action: #selector(dismissTheVC))
   
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBackToFilterVC))
    }
    
    func dismissTheVC(){
        self.dismiss(animated: true, completion: nil)
        print("Removing all existing data")
    }
//    func goBackToFilterVC(){
//        self.dismiss(animated: true, completion: nil)
//    }
    
    func getData(){
    
        APIRequestManager.manager.getData(apiEndPoint: apiEndPoint) { (data) in
            guard let data = data else { return }
            
            do {
                let jsonDict = try JSONSerialization.jsonObject(with: data, options: [])
                
                guard let jsonData = jsonDict as? [[String: String]] else { return }
                
                for eachSchool in jsonData {
                    let school = School(dictionary: eachSchool)
                    
                    // Perform filter function
                    
                    print("printing: \(self.boroChoosen)")
                    
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
                            // Deal with the issue if boro is not choosen
                            
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
    
    // MARK: - filter function


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredSchool.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedSchool: School
        
        let detialVC = DetailViewController()
        selectedSchool = filteredSchool[indexPath.row]
        detialVC.detailSchool = selectedSchool
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
