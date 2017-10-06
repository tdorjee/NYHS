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
    
    var theFavouriteSchools = DataStore.shareInstnce
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        self.tableView.separatorStyle = .singleLine
            self.title = "Favorite Schools"
      
        
        
        navigationItem.rightBarButtonItem = editButtonItem
        
        //SetBackBarButtonCustom()
        
        setUpNavBarStyle()
        
        loadData()
        
        tableView.reloadData()

    }
    
    var fromDetailVC = DetailViewController()
    
    private func loadData(){
        
        if let ourData = NSKeyedUnarchiver.unarchiveObject(withFile: fromDetailVC.filePath) as? [School] {
            fromDetailVC.store.favoriteSchool = ourData
        }
        
    }
    
    func setUpNavBarStyle(){
    
        navigationController?.navigationBar.barTintColor = ColorScheme.navColor
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
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
  
  
  /*
   
   if let loadedData = NSUserDefaults().dataForKey("personData") {
   
   if let loadedPerson = NSKeyedUnarchiver.unarchiveObjectWithData(loadedData) as? [Person] {
   loadedPerson[0].name   //"Leo"
   loadedPerson[0].age    //45
   }
   }
   
   */
    
   override func viewDidAppear(_ animated: Bool) {
    
//    let decoded = UserDefaults.standard.object(forKey: "detailSchool") as! Data
//    let decodedSchool = (NSKeyedUnarchiver.unarchiveObject(with: decoded) as! School)
//    theFavouriteSchools.append(decodedSchool)
    tableView.reloadData()
    
//
//      let data = UserDefaults.standard.object(forKey: "detailSchool")
//      
//      print("Stage: 1111")
//      
//      if let tempSchoolArr = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as? [School]{
//        
//        theFavouriteSchools =  tempSchoolArr
//      }
//        tableView.reloadData()
  }
  
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return theFavouriteSchools.favoriteSchool.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let backToDetailVc = DetailViewController()
        backToDetailVc.detailSchool = theFavouriteSchools.favoriteSchool[indexPath.row]
//        self.present(backToDeta ilVc, animated: true, completion: nil)
        self.navigationController?.pushViewController(backToDetailVc, animated: true)
        
//        let revisitVC = RevisitViewController()
//        revisitVC.school = theFavouriteSchools.favoriteSchool[indexPath.row]
//        self.present(revisitVC, animated: true, completion: nil)
//        self.navigationController?.pushViewController(revisitVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        let thisSchool = theFavouriteSchools.favoriteSchool[indexPath.row]
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
            
            theFavouriteSchools.favoriteSchool.remove(at: indexPath.row)
            
            tableView.reloadData()
            UserDefaults.standard.data(forKey: "favSchoolAdd")
    
        default:
            break
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }


}
