//
//  DetailViewController.swift
//  NYHS
//
//  Created by Thinley Dorjee on 5/19/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {

    var detailSchool: School?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.title = detailSchool?.name
        
        view.backgroundColor = .green
    
        viewHierarchy()
        constraintConfiguration()
        contentAdd()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(handleBackButton))
        
        
    }

    func viewHierarchy(){
        
       view.addSubview(scroolView)
       scroolView.addSubview(mainContainer)
       mainContainer.addSubview(overviewLabel)
       mainContainer.addSubview(overviewText)
       
       mainContainer.addSubview(schoolSizeLabel)
       mainContainer.addSubview(schoolSizeText)
       
       mainContainer.addSubview(schoolTimeLabel)
       mainContainer.addSubview(schoolTimeText)
       
       mainContainer.addSubview(disableFacilityLable)
       mainContainer.addSubview(disableFacilityText)
       
       mainContainer.addSubview(extracurricularActiviesLabel)
       mainContainer.addSubview(extracurricularActiviesText)
        
       mainContainer.addSubview(moreButton)
       
 
    }
    
    func constraintConfiguration(){
        
        self.edgesForExtendedLayout = []
        
        scroolView.snp.makeConstraints { (scrool) in
            scrool.top.left.right.bottom.equalToSuperview()
        }
        
        mainContainer.snp.makeConstraints { (container) in
            container.left.right.top.bottom.equalToSuperview()
            container.width.equalTo(self.view.frame.width)
            
        }
        
        
        // overView
        overviewLabel.snp.makeConstraints { (label) in
            label.centerX.equalToSuperview()
            label.top.equalToSuperview().offset(8)
        }
        
        overviewText.snp.makeConstraints { (text) in
            text.top.equalTo(overviewLabel.snp.bottom).offset(8)
            text.right.equalToSuperview().inset(8)
            text.left.equalToSuperview().offset(8)
            
        }
        
        // schoolSize
        
        schoolSizeLabel.snp.makeConstraints { (text) in
            text.top.equalTo(overviewText.snp.bottom).offset(8)
            text.left.equalToSuperview().offset(8)
        }
        
        schoolSizeText.snp.makeConstraints { (text) in
            text.left.equalTo(schoolSizeLabel.snp.right).offset(8)
            text.top.equalTo(schoolSizeLabel)
            
        }
        
        // schoolTime
        
        schoolTimeLabel.snp.makeConstraints { (text) in
            text.top.equalTo(schoolSizeLabel.snp.bottom).offset(8)
            text.left.equalToSuperview().offset(8)
        }
        
        schoolTimeText.snp.makeConstraints { (text) in
            text.left.equalTo(schoolTimeLabel.snp.right).offset(8)
            text.top.equalTo(schoolTimeLabel)
        }
        
        // disable facility 
    
        disableFacilityLable.snp.makeConstraints { (text) in
            text.top.equalTo(schoolTimeLabel.snp.bottom).offset(8)
            text.centerX.equalToSuperview()
        }
        
        disableFacilityText.snp.makeConstraints { (text) in
            text.top.equalTo(disableFacilityLable.snp.bottom).offset(8)
            text.left.equalToSuperview().offset(8)
            text.right.equalToSuperview().inset(8)
        }
        
        // ExtracurricularActivies
        
        extracurricularActiviesLabel.snp.makeConstraints { (text) in
            text.top.equalTo(disableFacilityText.snp.bottom).offset(8)
            text.centerX.equalToSuperview()
        }
        
        extracurricularActiviesText.snp.makeConstraints { (text) in
            text.top.equalTo(extracurricularActiviesLabel.snp.bottom).offset(8)
            text.bottom.equalTo(moreButton.snp.top).inset(8)
            text.left.equalToSuperview().offset(8)
            text.right.equalToSuperview().inset(8)
        }
        
        // More button
        
        moreButton.snp.makeConstraints { (button) in
            button.top.equalTo(extracurricularActiviesText.snp.bottom).offset(8)
            button.leading.equalToSuperview()
            button.width.equalTo(mainContainer.snp.width)
            button.bottom.equalToSuperview()
        }
        
    }
    
    func contentAdd(){
        
        
        //overview
        let attributedTextForOverview = NSMutableAttributedString(string: (detailSchool?.overview_paragraph)!, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15)])
        overviewText.attributedText = attributedTextForOverview
        
        //class size
        if let schoolSize = detailSchool?.total_students{
            schoolSizeText.text = schoolSize
        }
       
        //class time
        guard let schoolStartTime = detailSchool?.start_time, let schoolEndTime = detailSchool?.end_time else {
            return
        }
        
        let schoolTime = "\(schoolStartTime) - \(schoolEndTime)"
        schoolTimeText.text = schoolTime
        
        // disable facility 
        
        let attributedTextForDisableFacility = NSMutableAttributedString(string: (detailSchool?.se_services)!, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15)])
        
            disableFacilityText.attributedText = attributedTextForDisableFacility
      
        //extracurricular activity
        
        let attributedTextForExtracurrlarActivity = NSMutableAttributedString(string: (detailSchool?.extracurricular_activities)!, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15)])
        
        extracurricularActiviesText.attributedText = attributedTextForExtracurrlarActivity
    }
    
    //close button action
    func handleBackButton(){
        dismiss(animated: true, completion: nil)
    }

    func toWebVC(){
        
        let webVC = WebViewController()
        webVC.url = (self.detailSchool?.website)!
        self.navigationController?.pushViewController(webVC, animated: true)
        
    }
    
    //MARK: - Outlets
    
    // scroolview
    
    internal lazy var scroolView: UIScrollView = {
       let scroolView = UIScrollView()
        scroolView.isDirectionalLockEnabled = true
        return scroolView
    }()
    
    //main containter
    
    internal lazy var mainContainer: UIView = {
        let container = UIView()
        return container
    }()
    
    // overView
    internal lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.text = "Overview"
        return label
     }()

    internal lazy var overviewText: UITextView = {
        let text = UITextView()
        text.sizeToFit()
        text.isScrollEnabled = false
        text.textAlignment = .center
        text.isEditable = false
        return text
    }()

    // schoolSize
    internal lazy var schoolSizeLabel: UILabel = {
        let label = UILabel()
        label.text = "School Size: "
        return label
    }()
    
    internal lazy var schoolSizeText: UILabel = {
        let text = UILabel()
        return text
    }()
    
    // schoolTime
    internal lazy var schoolTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "School Time: "
        return label
    }()
    
    internal lazy var schoolTimeText: UILabel = {
        let text = UILabel()
        return text
    }()
    
    // disable facility 
    
    internal lazy var disableFacilityLable: UILabel = {
        let text = UILabel()
        text.text = "Disable Facility"
        return text
    }()
    
    internal lazy var disableFacilityText: UITextView = {
        let text = UITextView()
        text.sizeToFit()
        text.isScrollEnabled = false
        text.textAlignment = .center
        text.isEditable = false
        return text
    }()
    
    // Extracurricular Activies
    internal lazy var extracurricularActiviesLabel: UILabel = {
        let text = UILabel()
        text.text = "Extracurricular Activies"
        return text
    }()
    
    internal lazy var extracurricularActiviesText: UITextView = {
        let text = UITextView()
        text.sizeToFit()
        text.isScrollEnabled = false
        text.textAlignment = .center
        text.isEditable = false
        return text
    }()
    
    // More button
    internal lazy var moreButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("More", for: .normal)
        button.addTarget(self, action: #selector(toWebVC), for: .touchUpInside)
        return button
    }()
    
 
}
