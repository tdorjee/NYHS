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
    
    // Obtain value
    
    var boroChoosen: [String] = []
    var schoolSizeRang: String?
    
    @objc func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func updateValue(){
        
      
        
        print("start searching for new value")
        let filterVC = FilterResultTableViewController()
        filterVC.boroChoosen = boroChoosen
        if schoolSizeRang == ""{
            // if school size is not choosen, alert the user to choose one
            
            let schoolSizeNotChoosenAlert = UIAlertController(title: "School Size", message: "Please choose a school size", preferredStyle: .alert)
            schoolSizeNotChoosenAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(schoolSizeNotChoosenAlert, animated: true, completion: nil)
        }else {
            filterVC.schoolSizeMin = Int((schoolSizeRang?.components(separatedBy: " ")[0])!)
            filterVC.schoolSizeMax = Int((schoolSizeRang?.components(separatedBy: " ")[1])!)
            self.navigationController?.pushViewController(filterVC, animated: true)
        }
    }
    
    func viewHirarchy() {
        view.addSubview(boroTitle)
        view.addSubview(schoolSizeTitle)
        
        view.addSubview(brooklynLabel)
        view.addSubview(bronxLabel)
        view.addSubview(manhattanLabel)
        view.addSubview(queensLabel)
        view.addSubview(statenIslandLabel)
        
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(button3)
        view.addSubview(button4)
        view.addSubview(button5)
        
        view.addSubview(smallSchoolLabel)
        view.addSubview(mediumSchoolLabel)
        view.addSubview(largeSchoolLabel)
        
        view.addSubview(button6)
        view.addSubview(button7)
        view.addSubview(button8)
        

    }
    
    func ConstraintConfiguration() {
        self.edgesForExtendedLayout = []
        
        // Boros
        
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
        
        // Button for boros
        
        button1.snp.makeConstraints { (button) in
            button.top.equalTo(brooklynLabel.snp.top)
            button.trailing.equalToSuperview().inset(10)
        }
        
        button2.snp.makeConstraints { (button) in
            button.top.equalTo(bronxLabel.snp.top)
            button.trailing.equalToSuperview().inset(10)
        }
        
        button3.snp.makeConstraints { (button) in
            button.top.equalTo(manhattanLabel.snp.top)
            button.trailing.equalToSuperview().inset(10)
        }
        
        button4.snp.makeConstraints { (button) in
            button.top.equalTo(queensLabel.snp.top)
            button.trailing.equalToSuperview().inset(10)
        }
        
        button5.snp.makeConstraints { (button) in
            button.top.equalTo(statenIslandLabel.snp.top)
            button.trailing.equalToSuperview().inset(10)
        }
        
        
        // School sizes
        
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
        
        // Buttons for schools sizes
        
        button6.snp.makeConstraints { (button) in
            button.top.equalTo(smallSchoolLabel.snp.top)
            button.trailing.equalToSuperview().inset(10)
        }
        
        button7.snp.makeConstraints { (button) in
            button.top.equalTo(mediumSchoolLabel.snp.top)
            button.trailing.equalToSuperview().inset(10)
        }
        
        button8.snp.makeConstraints { (button) in
            button.top.equalTo(largeSchoolLabel.snp.top)
            button.trailing.equalToSuperview().inset(10)
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
    
    // MARK: - Check button
    
    internal lazy var button1: UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        button.titleLabel?.text = "Brooklyn"
        button.addTarget(self, action: #selector(tapedButton), for: .touchUpInside)
        return button
    }()
    
    internal lazy var button2: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "Bronx"
        button.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        button.addTarget(self, action: #selector(tapedButton), for: .touchUpInside)
        return button
    }()
    
    internal lazy var button3: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "Manhattan"
        button.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        button.addTarget(self, action: #selector(tapedButton), for: .touchUpInside)
        return button
    }()
    
    internal lazy var button4: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "Queens"
        button.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        button.addTarget(self, action: #selector(tapedButton), for: .touchUpInside)
        return button
    }()
    
    internal lazy var button5: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "Staten Island"
        button.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        button.addTarget(self, action: #selector(tapedButton), for: .touchUpInside)
        return button
    }()
    
    internal lazy var button6: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "1 1000"
        button.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        button.addTarget(self, action: #selector(tapedSizeButton), for: .touchUpInside)
        return button
    }()
    
    internal lazy var button7: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "1001 3000"
        button.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        button.addTarget(self, action: #selector(tapedSizeButton), for: .touchUpInside)
        return button
    }()
    
    internal lazy var button8: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "3001 6000"
        button.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        button.addTarget(self, action: #selector(tapedSizeButton), for: .touchUpInside)
        return button
    }()
    
    var buttonCheckStatus: Bool = true
    
    @objc func tapedButton(sender: UIButton) {
      
        var justSelectedBoro: String?
        
        if buttonCheckStatus {
            sender.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
            boroChoosen.append(sender.titleLabel?.text ?? "")
            buttonCheckStatus = false
            print("selected the boro")
            justSelectedBoro = sender.titleLabel?.text
        } else {
            guard justSelectedBoro == sender.titleLabel?.text else {
                sender.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
                buttonCheckStatus = true
                if let index = boroChoosen.index(of: (sender.titleLabel?.text)!) {
                    boroChoosen.remove(at: index)
                }
                print("not selected the boro")
                return
            }
            
            sender.titleLabel?.text! != justSelectedBoro && buttonCheckStatus == false
            buttonCheckStatus = true
            sender.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
            boroChoosen.append(sender.titleLabel?.text ?? "")
            justSelectedBoro = sender.titleLabel?.text
            buttonCheckStatus = false
    
        }
    }
    
    @objc func tapedSizeButton(sender: UIButton) {
        
        if buttonCheckStatus{
            sender.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
            schoolSizeRang = sender.titleLabel?.text ?? ""
            buttonCheckStatus = false
            print("selected the school size")
        }else{
            sender.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
            buttonCheckStatus = true
            schoolSizeRang = ""
            print("not selected school size")
        }
    }
}
