//
//  FilterViewController.swift
//  NYHS
//
//  Created by Thinley Dorjee on 10/6/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class FilterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        self.navigationItem.title = "Filter"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissView))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(updateValue))
        
        viewHirarchy()
        ConstraintConfiguration()
    }
    
    @objc func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func updateValue(){
        print("start searching for new value")
        self.navigationController?.pushViewController(FilterResultTableViewController(), animated: true)
        
    }
    
    func viewHirarchy() {
        view.addSubview(boroTitle)
        view.addSubview(schoolSizeTitle)
        
        view.addSubview(brooklynLabel)
        view.addSubview(bronxLabel)
        view.addSubview(manhattanLabel)
        view.addSubview(queensLabel)
        view.addSubview(statenIslandLabel)
        
        view.addSubview(smallSchoolLabel)
        view.addSubview(mediumSchoolLabel)
        view.addSubview(largeSchoolLabel)
        
        view.addSubview(buttonOne)
    }
    
    func ConstraintConfiguration() {
        self.edgesForExtendedLayout = []
        
        boroTitle.snp.makeConstraints { (label) in
            label.leading.equalToSuperview().offset(20)
            label.top.equalToSuperview().offset(40)
        }
        
        brooklynLabel.snp.makeConstraints { (label) in
            label.leading.equalToSuperview().offset(40)
            label.top.equalTo(boroTitle.snp.bottom).offset(20)
        }
        
        bronxLabel.snp.makeConstraints { (label) in
            label.leading.equalToSuperview().offset(40)
            label.top.equalTo(brooklynLabel.snp.bottom).offset(20)
        }
        
        manhattanLabel.snp.makeConstraints { (label) in
            label.leading.equalToSuperview().offset(40)
            label.top.equalTo(bronxLabel.snp.bottom).offset(20)
        }
        
        queensLabel.snp.makeConstraints { (label) in
            label.leading.equalToSuperview().offset(40)
            label.top.equalTo(manhattanLabel.snp.bottom).offset(20)
        }
        
        statenIslandLabel.snp.makeConstraints { (label) in
            label.leading.equalToSuperview().offset(40)
            label.top.equalTo(queensLabel.snp.bottom).offset(20)
        }
        
        buttonOne.snp.makeConstraints { (button) in
            button.top.trailing.equalToSuperview()
        }
        
        schoolSizeTitle.snp.makeConstraints { (label) in
            label.leading.equalToSuperview().offset(20)
            label.centerY.equalToSuperview()
        }
        
        smallSchoolLabel.snp.makeConstraints { (label) in
            label.leading.equalToSuperview().offset(40)
            label.top.equalTo(schoolSizeTitle.snp.bottom).offset(20)
        }
        
        mediumSchoolLabel.snp.makeConstraints { (label) in
            label.leading.equalToSuperview().offset(40)
            label.top.equalTo(smallSchoolLabel.snp.bottom).offset(20)
        }
        
        largeSchoolLabel.snp.makeConstraints { (label) in
            label.leading.equalToSuperview().offset(40)
            label.top.equalTo(mediumSchoolLabel.snp.bottom).offset(20)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: = Outlets
    
    internal lazy var boroTitle: UILabel = {
       let label = UILabel()
        label.text = "Borough"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    internal lazy var brooklynLabel: UILabel = {
        let label = UILabel()
        label.text = "Brooklyn"
        return label
    }()
    internal lazy var bronxLabel: UILabel = {
        let label = UILabel()
        label.text = "Bronx"
        return label
    }()
    internal lazy var manhattanLabel: UILabel = {
        let label = UILabel()
        label.text = "Manhattan"
        return label
    }()
    internal lazy var queensLabel: UILabel = {
        let label = UILabel()
        label.text = "Queens"
        return label
    }()
    internal lazy var statenIslandLabel: UILabel = {
        let label = UILabel()
        label.text = "Staten Island"
        return label
    }()
    
    

    internal lazy var schoolSizeTitle: UILabel = {
        let label = UILabel()
        label.text = "School Size"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    internal lazy var smallSchoolLabel: UILabel = {
        let label = UILabel()
        label.text = "1 - 1000"
        return label
    }()
    internal lazy var mediumSchoolLabel: UILabel = {
        let label = UILabel()
        label.text = "1001 - 3000"
        return label
    }()
    internal lazy var largeSchoolLabel: UILabel = {
        let label = UILabel()
        label.text = "3001 - 6000"
        return label
    }()
    
    
    
    internal lazy var buttonOne: UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        button.addTarget(self, action: #selector(tapedButton), for: .touchUpInside)
        return button
    }()
    
    var buttonCheckStatus: Bool = false
    
    func tapedButton() {
        buttonCheckStatus = true
        
        if buttonCheckStatus{
            buttonOne.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        }
        buttonCheckStatus = false
    }
}
