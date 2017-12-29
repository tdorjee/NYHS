//
//  DetailVC.swift
//  NYHS
//
//  Created by Thinley Dorjee on 5/19/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import GoogleMaps

class DetailVC: UIViewController, GMSMapViewDelegate {
    
    var detailSchool: School!
    var mapView: GMSMapView!
    var senderVC = ""
    
    var animator = UIViewPropertyAnimator(duration: 0.10, curve: .linear)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMaps()
        if senderVC == "BoroVC" {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Fav.", style: .plain, target: self, action: #selector(addToFavourite))    
        }
        
        navigationController?.navigationBar.isTranslucent = false
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        } else {
            // Fallback on earlier versions
        }
        view.backgroundColor = .white
        viewHierarchy()
        constraintConfiguration()
        mapView.delegate = self
        
    }
    
    func setupMaps() {
        
        let camera = GMSCameraPosition.camera(withLatitude: Double(self.detailSchool.latitude)!, longitude: Double(self.detailSchool.longitude)!, zoom: 12)
        
        self.mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: Double(self.detailSchool.latitude)!, longitude: Double(self.detailSchool.longitude)! )
        marker.title = self.detailSchool.name
        marker.snippet = self.detailSchool.boro
        marker.map = self.mapView
    }
    
    @objc func addToFavourite(){
        print("Save data in coreData")
    }
    
    func contactSchool(){
        
        let contactVC = ContactSchoolVC()
        contactVC.schoolFromDetailSchool = self.detailSchool
        self.present(contactVC, animated: true, completion: nil)
    }
    
    // MARK: - Google map delegate
    
    var mapViewDidExpend = false
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
        if !mapViewDidExpend {
            animator.addAnimations {
                self.mapView.snp.remakeConstraints{ (make) in
                    make.leading.top.trailing.equalToSuperview()
                    make.width.equalTo(self.view.snp.width)
                    make.bottom.equalTo(self.view.snp.bottom)
                }
                self.view.layoutIfNeeded()
            }
            animator.startAnimation()
            mapViewDidExpend = true
        }else{
            animator.addAnimations {
                self.mapView.snp.remakeConstraints{ (make) in
                    make.top.equalToSuperview()
                    make.leading.trailing.equalToSuperview()
                    make.height.equalTo(200)
                }
                self.view.layoutIfNeeded()
                
            }
            animator.startAnimation()
            mapViewDidExpend = false
        }
    }
    
    //MARK: - Outlets
    internal lazy var lineSeparator1: UIView = {
        let line = UIView()
        line.backgroundColor = ColorScheme.lineSeparatorColor
        return line
    }()
    
    internal lazy var lineSeparator2: UIView = {
        let line = UIView()
        line.backgroundColor = ColorScheme.lineSeparatorColor
        return line
    }()
    
    internal lazy var lineSeparator3: UIView = {
        let line = UIView()
        line.backgroundColor = ColorScheme.lineSeparatorColor
        return line
    }()
    
    internal lazy var lineSeparator4: UIView = {
        let line = UIView()
        line.backgroundColor = ColorScheme.lineSeparatorColor
        return line
    }()
    
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
    
    //miniMainViewContainer
    internal lazy var miniMainViewContainer: UIView = {
        let container = UIView()
        return container
    }()
    
    //  school name
    internal lazy var schoolNameLabel: UILabel = {
        let label = UILabel()
        label.text = "\(self.detailSchool.name)"
        label.lineBreakMode = .byWordWrapping
        label.font = ColorScheme.titleFont
        label.numberOfLines = 0
        return label
    }()
    
    internal lazy var diplomaImage: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "diplomaIcon"), for: .normal)
        return button
    }()
    
    internal lazy var diplomaLable: UILabel = {
        let label = UILabel()
        label.text = "\(self.detailSchool.diplomaendorsements)"
        label.textColor = UIColor(white: 0.2, alpha: 1)
        label.font = ColorScheme.subTitleFont
        return label
    }()
    
    // school size
    internal lazy var schoolSizeImage: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "schoolSizeIcon"), for: .normal)
        return button
    }()
    
    internal lazy var schoolSizeLabel: UILabel = {
        let label = UILabel()
        label.text = "\(self.detailSchool.total_students)"
        label.textColor = UIColor(white: 0.2, alpha: 1)
        label.font = ColorScheme.subTitleFont
        return label
    }()
    
    // school timing
    
    internal lazy var timeImage: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "time"), for: .normal)
        return button
    }()
    
    internal lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "\(self.detailSchool.start_time) - \(self.detailSchool.end_time)"
        label.textColor = UIColor(white: 0.2, alpha: 1)
        label.font = ColorScheme.subTitleFont
        return label
    }()
    
    // overview
    internal lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.text = "Overview"
        label.textColor = UIColor(white: 0.2, alpha: 1)
        label.font = ColorScheme.subTitleFont
        return label
    }()
    
    
    internal lazy var overviewText: UILabel = {
        let label = UILabel()
        label.text = self.detailSchool.overview_paragraph
        label.font = ColorScheme.descriptionFont
        label.textColor = UIColor(white: 0.2, alpha: 1)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        return label
    }()
    
    // Extracurricular Activies
    internal lazy var extracurricularActiviesLabel: UILabel = {
        let label = UILabel()
        label.text = "Extracurricular"
        label.textColor = UIColor(white: 0.2, alpha: 1)
        label.font = ColorScheme.subTitleFont
        return label
    }()
    
    internal lazy var extracurricularActiviesText: UILabel = {
        let label = UILabel()
        label.font = ColorScheme.descriptionFont
        
        label.text = self.detailSchool.extracurricular_activities
        label.textColor = UIColor(white: 0.2, alpha: 1)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
}

extension String {
    func height(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = self
        label.sizeToFit()
        
        return label.frame.height
    }
}






