//
//  ColorScheme.swift
//  NYHS
//
//  Created by Thinley Dorjee on 5/5/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation
import UIKit

struct ColorScheme {
    
    static let subtitleTextColor: UIColor = UIColor(red: 148/255, green: 148/255, blue: 148/255, alpha: 1.0)
    
    static let darkGreenBG: UIColor = UIColor(red: 27/255, green: 142/255, blue: 85/255, alpha: 1.0)
    static let darkBlue: UIColor = UIColor(red: 0/255, green: 48/255, blue: 74/255, alpha: 1.0)
    static let yellow: UIColor = UIColor(red: 255/255, green: 210/255, blue: 92/255, alpha: 1.0)
    static let green: UIColor = UIColor(red: 0/255, green: 215/255, blue: 159/255, alpha: 1.0)
    static let lightGreen: UIColor = UIColor(red: 39/255, green: 156/255, blue: 166/255, alpha: 1.0)
    static let red: UIColor = UIColor(red: 216/255, green: 37/255, blue: 31/255, alpha: 1.0)
    
    static let bgColor: UIColor = UIColor(red: 106/255, green: 185/255, blue: 212/255, alpha: 1)
    
    static let lightGrey: UIColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 0.9)
}

/*
 
 REUSE LATER
 
 MARK: - Outlets constrains from DetailVC
 
 /        // schoolSize
 //
 //        schoolSizeLabel.snp.makeConstraints { (text) in
 //            text.top.equalTo(overviewText.snp.bottom).offset(8)
 //            text.left.equalToSuperview().offset(8)
 //        }
 //
 //        schoolSizeText.snp.makeConstraints { (text) in
 //            text.left.equalTo(schoolSizeLabel.snp.right).offset(8)
 //            text.top.equalTo(schoolSizeLabel)
 //
 //        }
 //
 //        // schoolTime
 //
 //        schoolTimeLabel.snp.makeConstraints { (text) in
 //            text.top.equalTo(schoolSizeLabel.snp.bottom).offset(8)
 //            text.left.equalToSuperview().offset(8)
 //        }
 //
 //        schoolTimeText.snp.makeConstraints { (text) in
 //            text.left.equalTo(schoolTimeLabel.snp.right).offset(8)
 //            text.top.equalTo(schoolTimeLabel)
 //        }
 //
 //        // disable facility
 //
 //        disableFacilityLable.snp.makeConstraints { (text) in
 //            text.top.equalTo(schoolTimeLabel.snp.bottom).offset(8)
 //            text.centerX.equalToSuperview()
 //        }
 //
 //        disableFacilityText.snp.makeConstraints { (text) in
 //            text.top.equalTo(disableFacilityLable.snp.bottom).offset(8)
 //            text.left.equalToSuperview().offset(8)
 //            text.right.equalToSuperview().inset(8)
 //        }
 //
 //        // ExtracurricularActivies
 //
 //        extracurricularActiviesLabel.snp.makeConstraints { (text) in
 //            text.top.equalTo(disableFacilityText.snp.bottom).offset(8)
 //            text.centerX.equalToSuperview()
 //        }
 //
 //        extracurricularActiviesText.snp.makeConstraints { (text) in
 //            text.top.equalTo(extracurricularActiviesLabel.snp.bottom).offset(8)
 //            text.bottom.equalTo(moreButton.snp.top).inset(8)
 //            text.left.equalToSuperview().offset(8)
 //            text.right.equalToSuperview().inset(8)
 //        }
 
 MARK: - String attributs from DetailVC
 
 // func contentAdd(){
 
 
 //overview
 
 // overviewText.text = detailSchool.overview_paragraph
 //        let attributedTextForOverview = NSMutableAttributedString(string: (detailSchool?.overview_paragraph)!, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15)])
 //
 //        overviewText.attributedText = attributedTextForOverview
 
 //        //class size
 //        if let schoolSize = detailSchool?.total_students{
 //            schoolSizeText.text = schoolSize
 //        }
 //
 //        //class time
 //        guard let schoolStartTime = detailSchool?.start_time, let schoolEndTime = detailSchool?.end_time else {
 //            return
 //        }
 //
 //        let schoolTime = "\(schoolStartTime) - \(schoolEndTime)"
 //        schoolTimeText.text = schoolTime
 //
 //        // disable facility
 //
 //        let attributedTextForDisableFacility = NSMutableAttributedString(string: (detailSchool?.se_services)!, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15)])
 //
 //        disableFacilityText.attributedText = attributedTextForDisableFacility
 //
 //        //extracurricular activity
 //
 //        let attributedTextForExtracurrlarActivity = NSMutableAttributedString(string: (detailSchool?.extracurricular_activities)!, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15)])
 //
 //        extracurricularActiviesText.attributedText = attributedTextForExtracurrlarActivity
 //}
 
 //    //close button action
 //    func handleBackButton(){
 //        dismiss(animated: true, completion: nil)
 //    }
 
 MARK: - Outlets from DetailVC
 
 
 //    // schoolSize
 //    internal lazy var schoolSizeLabel: UILabel = {
 //        let label = UILabel()
 //        label.text = "School Size: "
 //        return label
 //    }()
 //
 //    internal lazy var schoolSizeText: UILabel = {
 //        let text = UILabel()
 //        return text
 //    }()
 //
 //    // schoolTime
 //    internal lazy var schoolTimeLabel: UILabel = {
 //        let label = UILabel()
 //        label.text = "School Time: "
 //        return label
 //    }()
 //
 //    internal lazy var schoolTimeText: UILabel = {
 //        let text = UILabel()
 //        return text
 //    }()
 //
 //    // disable facility
 //
 //    internal lazy var disableFacilityLable: UILabel = {
 //        let text = UILabel()
 //        text.text = "Disable Facility"
 //        return text
 //    }()
 //
 //    internal lazy var disableFacilityText: UITextView = {
 //        let text = UITextView()
 //        text.sizeToFit()
 //        text.isScrollEnabled = false
 //        text.textAlignment = .center
 //        text.isEditable = false
 //        return text
 //    }()
 //
 //    // Extracurricular Activies
 //    internal lazy var extracurricularActiviesLabel: UILabel = {
 //        let text = UILabel()
 //        text.text = "Extracurricular Activies"
 //        return text
 //    }()
 //
 //    internal lazy var extracurricularActiviesText: UITextView = {
 //        let text = UITextView()
 //        text.sizeToFit()
 //        text.isScrollEnabled = false
 //        text.textAlignment = .center
 //        text.isEditable = false
 //        return text
 //    }()
 
 
 
 */
