//
//  FavouriteTableViewController.swift
//  NYHS
//
//  Created by Thinley Dorjee on 6/15/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class FavouriteTableViewController: UITableViewController {

    let cellId = "cellId"
    
    var theFavouriteSchools: [School] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("********************* now to the favorite page")
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        self.tableView.separatorStyle = .singleLine
            self.title = "Favorite Schools"
      
        
        
        navigationItem.rightBarButtonItem = editButtonItem
        
        //SetBackBarButtonCustom()
        
        setUpNavBarStyle()
        
        saveSchool()
        
    }
    
    func setUpNavBarStyle(){
        print("Style navigation bar style")
        navigationController?.navigationBar.barTintColor = ColorScheme.navColor
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
//    func SetBackBarButtonCustom() {
//        
//        let btnLeftMenu: UIButton = UIButton()
//        btnLeftMenu.setImage(#imageLiteral(resourceName: "customBackButton2"), for: .normal)
//        btnLeftMenu.addTarget(self, action: #selector(onClcikBack), for: .touchUpInside)
//        btnLeftMenu.frame = CGRect(x: 0, y: 0, width: 50/2, height: 50/2)
//        let barButton = UIBarButtonItem(customView: btnLeftMenu)
//        self.navigationItem.leftBarButtonItem = barButton
//    }
//    
//    func onClcikBack(){
//        _ = self.navigationController?.popViewController(animated: true)
//    }
    
    
    func saveSchool(){
        
        print("view did load")
        
        print("schools in userdefault: \(theFavouriteSchools)")
        
    }
    
   override func viewDidAppear(_ animated: Bool) {
//    var array : [School] = []
    
    
    
    if let data = UserDefaults.standard.object(forKey: "favSchoolAdd") as? NSData {
        
        if let tempSchoolArr = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as? [School]{
            
            theFavouriteSchools = tempSchoolArr
            print("All the schools in userdefaulst: \(tempSchoolArr)")
            }
        
    
        }
    tableView.reloadData()
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return theFavouriteSchools.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let revisitVC = RevisitViewController()
        revisitVC.school = theFavouriteSchools[indexPath.row]
        self.navigationController?.pushViewController(revisitVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        let thisSchool = theFavouriteSchools[indexPath.row]
        cell.textLabel?.text = thisSchool.name
        cell.detailTextLabel?.text = thisSchool.boro
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping

        return cell
    }
    
    
    // MARK: - Edit section
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            
            theFavouriteSchools.remove(at: indexPath.row)
            tableView.reloadData()
            UserDefaults.standard.data(forKey: "favSchoolAdd")
            //UserDefaults.standard.set(theFavouriteSchools, forKey: "")
        default:
            break
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }


}
