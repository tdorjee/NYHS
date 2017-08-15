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

class DetailViewController: UIViewController {
    
    var detailSchool: School!
//    var currentUserLocation: CLLocation!
    var schoolLatAndLng: LatAndLng?
    
    var mapView: GMSMapView!
    var locationManager = CLLocationManager()
    

    
    
//    var currentLocation = CLLocationCoordinate2D()
//    var animator = UIViewPropertyAnimator()

    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        //self.title = detailSchool?.name
        view.backgroundColor = .white
        
//        locationManager.delegate = self
//        locationManager.distanceFilter = 500
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
        
        getLatAndLgn()
        setupMaps()
 
        viewHierarchy()
        constraintConfiguration()
        setBackBarButtonCustom()
        setMoreButtonCustom()
        
//        self.mapView.canPerformAction(#selector(showMapFullScreen), withSender: self)
        
        
    }
    
    func setBackBarButtonCustom() {
        
        let btnLeftMenu: UIButton = UIButton()
        btnLeftMenu.setImage(#imageLiteral(resourceName: "customBackButton2"), for: .normal)
        btnLeftMenu.addTarget(self, action: #selector(onClcikBack), for: .touchUpInside)
        btnLeftMenu.frame = CGRect(x: 0, y: 0, width: 50/2, height: 50/2)
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    func onClcikBack(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func setMoreButtonCustom() {
        
        let btnLeftMenu: UIButton = UIButton()
        btnLeftMenu.setImage(#imageLiteral(resourceName: "customMoreOption2"), for: .normal)
        btnLeftMenu.addTarget(self, action: #selector(addToFavourite), for: .touchUpInside)
        btnLeftMenu.frame = CGRect(x: 0, y: 0, width: 50/2, height: 50/2)
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    
    func addToFavourite(){
        
        // Convert Array to Data
        let encodeData = NSKeyedArchiver.archivedData(withRootObject: detailSchool)
        let objectArchive = UserDefaults.standard.set(encodeData, forKey: "favSchoolAdd")
        UserDefaults.standard.synchronize()
        
        
        // testing retriving
        
//        func retriveSchool() -> [School]? {
//            
//            if let data = UserDefaults.standard.object(forKey: "favSchoolAdd") as? NSData {
//                return NSKeyedUnarchiver.unarchiveObject(with: data as Data) as? [School]
//
//            }
//           return nil
//        }
//        
//        if let classA = NSUserDefaultsManager.userDefaults.dataForKey("classAarray") {
//            if let classAunpacked = NSKeyedUnarchiver.unarchiveObjectWithData(classA) as? [ClassA] {
//                // Use classAunpacked here
//            }
//        }
//        
//        if let retriveSchool = retriveSchool() {
//            for i in retriveSchool {
//                print(i.school_email)
//            }
//        }
        
        
//        var favSchoolAdd: [School]
//        
//        if let tempSchool = objectArchive as? [School] {
//            favSchoolAdd = tempSchool
//            favSchoolAdd.append(detailSchool!)
//        }else{
//            favSchoolAdd = [detailSchool!]
//        }
//        UserDefaults.standard.set(favSchoolAdd, forKey: "favSchoolAdd")
//        
//        
        
        let alert = UIAlertController(title: "Saved", message: "School added to Favorite list", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
//                        self.mapView.isMyLocationEnabled = false
//                        self.mapView.settings.myLocationButton = true
//                        self.mapView.mapType = .terrain
                        let url = Bundle.main.url(forResource: "mapStyle", withExtension: "json")
                        let mapStyle = try! GMSMapStyle.init(contentsOfFileURL: url!)
                        self.mapView.mapStyle = mapStyle
                        
                        
                        let marker = GMSMarker()
                        marker.position = CLLocationCoordinate2D(latitude: schoolLocation.lat, longitude: schoolLocation.lng )
//                        marker.icon = #imageLiteral(resourceName: "school")
                        marker.title = self.detailSchool.name
                        marker.snippet = self.detailSchool.boro
                        marker.map = self.mapView
                        
                        
                    }
                    
                    print("School phono no.: \(self.detailSchool.phone_number)")

                }
                
                
            } catch {
                print("Error getting lat and lng")
            }
        }
    }
    
        func toWeb(){
            
            let website = WebViewController()
            website.schoolWebSite = self.detailSchool.website
            self.navigationController?.pushViewController(website, animated: true)
        
        }
    
    
        func toMap(){
        
        let googleMap = googleMapVC()
            googleMap.schoolLat = Float(self.schoolLatAndLng!.lat)
            
            googleMap.schoolLog = Float(self.schoolLatAndLng!.lng)
        googleMap.schoolAddress = (self.detailSchool?.primary_address_line_1)!
        self.navigationController?.pushViewController(googleMap, animated: true)
        
    }


    //MARK: - Outlets
    
    
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
    
    
    // Expand map 
//    
//    internal lazy var showMapButton: UIButton = {
//        let button = UIButton()
//        button.tintColor = .red
//        button.addTarget(self, action: #selector(showMapFullScreen), for: .touchUpInside)
//        return button
//    }()

    
    // diploma endorsements
    
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
    
    // transpotation
    // school_sports
    
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
        //label.sizeToFit()
        label.text = self.detailSchool.overview_paragraph
        label.font = ColorScheme.descriptionFont
//        label.textColor = ColorScheme.subtitleTextColor
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
    
// More button
    internal lazy var showWebsite: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = ColorScheme.lineSeparatorColor
        button.addTarget(self, action: #selector(toWeb), for: .touchUpInside)
        button.setTitle("Website", for: .normal)
        return button
    }()
    
    internal lazy var showDirection: UIButton = {
        let button = UIButton()
        button.backgroundColor = ColorScheme.lineSeparatorColor
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Get Direction", for: .normal)
        button.addTarget(self, action: #selector(toMap), for: .touchUpInside)
        return button
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






