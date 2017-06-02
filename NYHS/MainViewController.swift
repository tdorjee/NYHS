//
//  MainViewController.swift
//  NYHS
//
//  Created by Thinley Dorjee on 6/2/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    let cellId = "MainCellId"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: cellId)

    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Boro.totalSection
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        //var sectionLabelText = UILabel()
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = Boro.section[0]
        case 1:
            cell.textLabel?.text = Boro.section[1]
        case 2:
            cell.textLabel?.text = Boro.section[2]
        case 3:
            cell.textLabel?.text = Boro.section[3]
        default:
            cell.textLabel?.text = Boro.section[4]
      
        }
        
        return cell
    }


}
