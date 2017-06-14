//
//  DetailViewController.swift
//  NYHS
//
//  Created by Thinley Dorjee on 5/19/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import CoreLocation
import GoogleMaps
import GooglePlaces

class DetailViewController: UIViewController {
    
    var detailSchool: School!
    var locationManager = CLLocationManager()
    //var currentLatAndLng: LatAndLng?
    
    var mapView: GMSMapView!
    //var myInt: Int!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
         getLatAndLgn()
        setupMaps()
        print("second stage")

        
        view.backgroundColor = .white
        self.title = detailSchool?.name
        
        print("third stage")
        view.backgroundColor = Color.darkGreenBG
        
        viewHierarchy()
        constraintConfiguration()
        contentAdd()
        
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(handleBackButton))
// 
    }
    
    func setupMaps() {
        
        let camera = GMSCameraPosition.camera(withLatitude: 40.742362,
                                              longitude: -73.935365,
                                              zoom: 18)
        self.mapView = GMSMapView.map(withFrame: .zero, camera: camera)
    }
    
    func getLatAndLgn(){
        let addr = detailSchool.primary_address_line_1
        print("Current address: \(addr)")
        
        let separatedAddr = addr.components(separatedBy: " ")
        print("Current address separated: \(separatedAddr)")
        
        var addressStrSearch = ""
        
        for i in 0..<separatedAddr.count {
            if i == separatedAddr.count - 1 {
                addressStrSearch.append(separatedAddr[i])
            }else{
                addressStrSearch.append(separatedAddr[i]+"+")
            }
        }
        print("Address to search: \(addressStrSearch)")
        print("SPOT 1")

        APIRequestManager.manager.getData(apiEndPoint: "https://maps.googleapis.com/maps/api/geocode/json?address=\(addressStrSearch)&key=AIzaSyDMS1l_U5Zswy_ZH51EJUNGBz-Tr-W6iCQ") { (data) in
            print("SPOT 2")

            print("This is current address: \(addressStrSearch)")
            guard let data = data else { print("Something is going wroing here guard data")
                return }
            
            do{
                
                print("Inside the do and chatch")
                guard let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
                
                guard let results = jsonDict["results"] as? [[String: Any]] else { return}
                for result in results {
                    guard let geometry = result["geometry"] as? [String: Any] else { return }
                    guard let location = geometry["location"] as? [String: Double] else { return }
                    
                    let theLocation = LatAndLng(dictionary: location)
                    
//                    self.currentLatAndLng = theLocation
//                    print("The lat of the school is: \(theLocation.lat)")
//                    print("The lng of the school is: \(theLocation.lng)")
                    
                    DispatchQueue.main.async {
                        self.mapView?.camera = GMSCameraPosition.camera(withLatitude: theLocation.lat, longitude: theLocation.lng, zoom: 18)
//                        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
                        //self.mapContainerView = mapView
                        
                        let marker = GMSMarker()
                        marker.position = CLLocationCoordinate2D(latitude: theLocation.lat, longitude: theLocation.lng )
                        marker.title = self.detailSchool.name
                        marker.snippet = self.detailSchool.boro
                        marker.map = self.mapView
                    }

                }
                
                
            } catch {
                print("Error getting lat and lng")
            }
        }
        
        // Moving the map maker here
        print("SPOT 3")

        
    }
    
    func viewHierarchy(){
        
        view.addSubview(scroolView)
        //scroolView.addSubview(mapContainerView)
        //mapContainerView.addSubview(mapView!)
        
        scroolView.addSubview(mainContainer)
        mainContainer.addSubview(mapView!)
        mainContainer.addSubview(overviewLabel)
        mainContainer.addSubview(overviewText)
        
//        mainContainer.addSubview(schoolSizeLabel)
//        mainContainer.addSubview(schoolSizeText)
//        
//        mainContainer.addSubview(schoolTimeLabel)
//        mainContainer.addSubview(schoolTimeText)
//        
//        mainContainer.addSubview(disableFacilityLable)
//        mainContainer.addSubview(disableFacilityText)
//        
//        mainContainer.addSubview(extracurricularActiviesLabel)
//        mainContainer.addSubview(extracurricularActiviesText)
//        
        mainContainer.addSubview(moreButton)
        
        
    }
    
    func constraintConfiguration(){
        
        self.edgesForExtendedLayout = []
        
        scroolView.snp.makeConstraints { (scrool) in
            scrool.top.left.right.bottom.equalToSuperview()
        }
        
        
        mainContainer.snp.makeConstraints { (container) in
            container.left.right.bottom.top.equalToSuperview()
            container.width.equalTo(self.view.frame.width)
            
        }
        
//        // mapContainerView
//        mapContainerView.snp.makeConstraints { (view) in
//            view.leading.top.trailing.equalToSuperview()
//            view.height.equalTo(300)
//            view.width.equalTo(self.view.frame.width)
//        }
//
        // mapView
        
        mapView?.snp.makeConstraints { (map) in
            map.leading.top.trailing.equalToSuperview()
            map.height.equalTo(300)
        }

        
        // overView
        overviewLabel.snp.makeConstraints { (label) in
            label.centerX.equalToSuperview()
            label.top.equalTo((mapView?.snp.bottom)!).offset(8)
        }
        
        overviewText.snp.makeConstraints { (label) in
            label.top.equalTo(overviewLabel.snp.bottom).offset(8)
            label.right.equalToSuperview().inset(8)
            label.left.equalToSuperview().offset(8)
            label.height.equalTo(400)
            
            
        }
        
//        // schoolSize
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
//        
//        // More button
//        
        moreButton.snp.makeConstraints { (button) in
            button.top.equalTo(overviewText.snp.bottom).offset(8)
            button.leading.equalToSuperview()
            button.width.equalTo(mainContainer.snp.width)
            button.bottom.equalToSuperview().inset(8)
        }
        
    }
    
    func contentAdd(){
        
        
        //overview
        
        overviewText.text = detailSchool.overview_paragraph
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
    }
    
//    //close button action
//    func handleBackButton(){
//        dismiss(animated: true, completion: nil)
//    }
    
    func toWebVC(){
//        
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
    
    // MapContainerView
    
//    internal lazy var mapContainerView: UIView = {
//        let view = UIView()
//        return view
//    }()
    
    // overView
    internal lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.text = "Overview"
        return label
    }()
    
    internal lazy var overviewText: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.layer.cornerRadius = 10
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.layer.cornerRadius = 15
        //text.isScrollEnabled = false
        label.textAlignment = .center
        //label.isEditable = false
        return label
    }()
    
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
//    
//    // More button
    internal lazy var moreButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("More", for: .normal)
        button.addTarget(self, action: #selector(toWebVC), for: .touchUpInside)
        return button
    }()
    
    
}
