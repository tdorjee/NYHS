//
//  extension-DetailVC.swift
//  NYHS
//
//  Created by Thinley Dorjee on 7/8/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

extension DetailViewController {
    
    // MARK - View Hierarchy
    
    
    func viewHierarchy(){
        
        view.addSubview(scroolView)
        scroolView.addSubview(mainContainer)
        
        mainContainer.addSubview(mapView!)
        mapView.addSubview(bringMapUp)
        
        mainContainer.addSubview(miniMainViewContainer)
        
        miniMainViewContainer.addSubview(schoolNameLabel)
        miniMainViewContainer.addSubview(lineSeparator1)
        
        miniMainViewContainer.addSubview(diplomaImage)
        miniMainViewContainer.addSubview(diplomaLable)
        
        miniMainViewContainer.addSubview(schoolSizeImage)
        miniMainViewContainer.addSubview(schoolSizeLabel)
        
        miniMainViewContainer.addSubview(timeImage)
        miniMainViewContainer.addSubview(timeLabel)
        
        
        miniMainViewContainer.addSubview(lineSeparator2)
        
        miniMainViewContainer.addSubview(overviewLabel)
        miniMainViewContainer.addSubview(overviewText)
        
        miniMainViewContainer.addSubview(lineSeparator3)
        
        miniMainViewContainer.addSubview(extracurricularActiviesLabel)
        miniMainViewContainer.addSubview(extracurricularActiviesText)
        
        miniMainViewContainer.addSubview(lineSeparator4)
        
        
        
    }
    
    
    // MARK - Constrain Configuration
    
    func constraintConfiguration(){
        
        self.edgesForExtendedLayout = []
        
        scroolView.snp.makeConstraints { (scroll) in
            scroll.top.left.right.bottom.equalToSuperview()
        }
        
        
        mainContainer.snp.makeConstraints { (container) in
            container.left.right.bottom.top.equalToSuperview()
            container.width.equalTo(self.view.frame.width)
            
        }
        
        // mapView
        mapView?.snp.makeConstraints { (map) in
            map.top.equalToSuperview()
            map.leading.trailing.equalToSuperview()
            map.height.equalTo(200)
        }
        
        bringMapUp.snp.makeConstraints { (up) in
            up.centerX.equalToSuperview()
            up.bottom.equalToSuperview().offset(80)
           
        }
        
        miniMainViewContainer.snp.makeConstraints { (view) in
            view.left.equalToSuperview()
            view.top.equalTo(mapView.snp.bottom)
            view.right.bottom.equalToSuperview()
        }
        
        // school name
        schoolNameLabel.snp.makeConstraints { (label) in
            label.left.equalToSuperview().offset(12)
            label.top.equalTo(mapView.snp.bottom).offset(15)
            label.right.equalToSuperview().inset(12)
        }
        
        // lineSeparator 1
        
        lineSeparator1.snp.makeConstraints { (line) in
            line.top.equalTo(schoolNameLabel.snp.bottom).offset(15)
            line.left.equalTo(schoolNameLabel.snp.left)
            line.right.equalTo(schoolNameLabel.snp.right)
            line.height.equalTo(0.5)
        }
        
        // diploma endorsment
        diplomaImage.snp.makeConstraints { (label) in
            label.top.equalTo(lineSeparator1.snp.bottom).offset(15)
            label.left.equalTo(schoolNameLabel.snp.left)
        }
        
        diplomaLable.snp.makeConstraints { (label) in
            label.top.equalTo(lineSeparator1.snp.bottom).offset(15)
            label.left.equalTo(diplomaImage.snp.right).offset(8)
            label.right.equalTo(schoolNameLabel.snp.right)
        }
        
        // school size
        
        schoolSizeImage.snp.makeConstraints { (label) in
            label.top.equalTo(diplomaLable.snp.bottom).offset(8)
            label.left.equalTo(schoolNameLabel.snp.left)
        }
        
        schoolSizeLabel.snp.makeConstraints { (label) in
            label.top.equalTo(schoolSizeImage.snp.top)
            label.left.equalTo(schoolSizeImage.snp.right).offset(8)
            label.right.equalTo(schoolNameLabel.snp.right)
        }
        
        // school time
        
        timeImage.snp.makeConstraints { (label) in
            label.top.equalTo(schoolSizeLabel.snp.bottom).offset(8)
            label.left.equalTo(schoolNameLabel.snp.left)
        }
        
        timeLabel.snp.makeConstraints { (label) in
            label.top.equalTo(timeImage.snp.top)
            label.left.equalTo(timeImage.snp.right).offset(8)
            label.right.equalTo(schoolNameLabel.snp.right)
        }
        
        // lineSeparator 2
        
        lineSeparator2.snp.makeConstraints { (line) in
            line.top.equalTo(timeLabel.snp.bottom).offset(15)
            line.left.equalTo(schoolNameLabel.snp.left)
            line.right.equalTo(schoolNameLabel.snp.right)
            line.height.equalTo(0.5)
        }
        
        // overviewLabel
        
        overviewLabel.snp.makeConstraints { (label) in
            label.top.equalTo(lineSeparator2.snp.bottom).offset(15)
            label.left.equalTo(schoolNameLabel.snp.left)
            label.right.equalTo(schoolNameLabel.snp.right)
        }
        
        overviewText.snp.makeConstraints { (label) in
            label.top.equalTo(overviewLabel.snp.bottom).offset(8)
            label.left.equalTo(schoolNameLabel.snp.left)
            label.right.equalTo(schoolNameLabel.snp.right)
        }
        
        
        lineSeparator3.snp.makeConstraints { (line) in
            line.top.equalTo(overviewText.snp.bottom).offset(15)
            line.left.equalTo(schoolNameLabel.snp.left)
            line.right.equalTo(schoolNameLabel.snp.right)
            line.height.equalTo(0.5)
        }
        
        // extracurricular activity
        
        extracurricularActiviesLabel.snp.makeConstraints { (label) in
            label.top.equalTo(lineSeparator3.snp.bottom).offset(15)
            label.left.equalTo(schoolNameLabel.snp.left)
            label.right.equalTo(schoolNameLabel.snp.right)
        }
        
        extracurricularActiviesText.snp.makeConstraints { (label) in
            label.top.equalTo(extracurricularActiviesLabel.snp.bottom).offset(8)
            label.left.equalTo(schoolNameLabel.snp.left)
            label.right.equalTo(schoolNameLabel.snp.right)
        }
        
        lineSeparator4.snp.makeConstraints { (line) in
            line.top.equalTo(extracurricularActiviesText.snp.bottom).offset(15)
            line.left.equalTo(schoolNameLabel.snp.left)
            line.right.equalTo(schoolNameLabel.snp.right)
            line.height.equalTo(0.5)
            line.bottom.equalToSuperview().inset(8)
        }
    } 
}
