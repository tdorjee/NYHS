//
//  DetailViewController.swift
//  NYHS
//
//  Created by Thinley Dorjee on 5/19/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import GoogleMaps
import GooglePlaces

class DetailViewController: UIViewController, GMSMapViewDelegate {
    
    var store = DataStore.shareInstnce
    var detailSchool: School!
    var schoolLatAndLng: LatAndLng?
    var mapView: GMSMapView!
    var locationManager = CLLocationManager()
    var allSchoolSoFar: [School] = []
    
    var animator = UIViewPropertyAnimator(duration: 0.10, curve: .linear)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Fav.", style: .plain, target: self, action: #selector(addToFavourite))
        
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        } else {
            // Fallback on earlier versions
        }
    
        
        
        view.backgroundColor = .white
        getLatAndLgn()
        setupMaps()
        
        viewHierarchy()
        constraintConfiguration()
        
        mapView.delegate = self
        
    }
    
    @objc func onClcikBack(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: File path
    
    var filePath: String {
        
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        return (url!.appendingPathComponent("Data").path)
        
    }
    
    // MARK: Save Data
    
    private func saveData(item: School) {
        self.store.favoriteSchool.append(item)
        NSKeyedArchiver.archiveRootObject(self.store.favoriteSchool, toFile: filePath)
        
    }
    
    // MARK: Load Data
    @objc func addToFavourite(){
        
        self.saveData(item: detailSchool)
        
    }
    
    func contactSchool(){
        
        let contactVC = ContactSchoolViewController()
        contactVC.schoolFromDetailSchool = self.detailSchool
        self.present(contactVC, animated: true, completion: nil)
    }
    
    func setupMaps() {
        
        let camera = GMSCameraPosition.camera(withLatitude: 40.742362,
                                              longitude: -73.935365,
                                              zoom: 7)
        self.mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        
    }
    
    // MARK: - Google map delegate
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
        self.bringMapUp.setImage(#imageLiteral(resourceName: "slideUp"), for: .normal)
        // Expend the map
        
        animator.addAnimations {
            self.mapView.snp.remakeConstraints{ (make) in
                make.leading.top.trailing.equalToSuperview()
                make.width.equalTo(self.view.snp.width)
                make.bottom.equalTo(self.view.snp.bottom)
            }
            
            self.bringMapUp.snp.makeConstraints{ (up) in
                up.bottom.equalToSuperview().inset(8)
            }
            
            self.view.layoutIfNeeded()
        }
        animator.startAnimation()
    }
    
    // Animate constrian back to normal
    
    @objc func animateBackToNormal(){
        
        self.bringMapUp.setImage(nil, for: .normal)
        animator.addAnimations {
            self.mapView.snp.remakeConstraints{ (make) in
               make.top.equalToSuperview()
               make.leading.trailing.equalToSuperview()
               make.height.equalTo(200)
            }
            
            self.bringMapUp.snp.makeConstraints { (up) in
                up.centerX.equalToSuperview()
                up.bottom.equalToSuperview().offset(80)
            }
            self.view.layoutIfNeeded()
            
        }
        animator.startAnimation()
    
    }
    
    func getLatAndLgn(){
        let addr = detailSchool.primary_address_line_1
        
        let separatedAddr = addr.components(separatedBy: " ")
        
        var addressStrSearch = ""
        
        for i in 0..<separatedAddr.count {
            if i == separatedAddr.count - 1 {
                addressStrSearch.append(separatedAddr[i])
            }else{
                addressStrSearch.append(separatedAddr[i]+"+")
            }
        }
        
        
        APIRequestManager.manager.getData(apiEndPoint: "https://maps.googleapis.com/maps/api/geocode/json?address=\(addressStrSearch)&key=AIzaSyDMS1l_U5Zswy_ZH51EJUNGBz-Tr-W6iCQ") { (data) in
            
            guard let data = data else { print("Something is going wrong here guard data")
                return }
            
            do{
                
                guard let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
                
                guard let results = jsonDict["results"] as? [[String: Any]] else { return}
                for result in results {
                    guard let geometry = result["geometry"] as? [String: Any] else { return }
                    guard let location = geometry["location"] as? [String: Double] else { return }
                    
                    let schoolLocation = LatAndLng(dictionary: location)
                    self.schoolLatAndLng = schoolLocation
                    DispatchQueue.main.async {
                        self.mapView?.camera = GMSCameraPosition.camera(withLatitude: schoolLocation.lat, longitude: schoolLocation.lng, zoom: 12)
                        
                        let marker = GMSMarker()
                        marker.position = CLLocationCoordinate2D(latitude: schoolLocation.lat, longitude: schoolLocation.lng )
                        marker.title = self.detailSchool.name
                        marker.snippet = self.detailSchool.boro
                        marker.map = self.mapView
                    }
                }
            } catch {
                print("Error getting lat and lng")
            }
        }
    }
    
    //MARK: - Outlets

    // Make mapview smaller
    
    internal lazy var bringMapUp: UIButton = {
       let button = UIButton()
//        button.setImage(#imageLiteral(resourceName: "mapExpend"), for: .normal)
        button.addTarget(self, action: #selector(animateBackToNormal), for: .touchUpInside)
        return button
    }()
    
    // line separator 
    
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






