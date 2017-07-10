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
    var currentUserLocation: CLLocation!
    
    var mapView: GMSMapView!
    var locationManager = CLLocationManager()

    
    
    var currentLocation = CLLocationCoordinate2D()
    var animator = UIViewPropertyAnimator()

    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        //self.title = detailSchool?.name
        view.backgroundColor = .white
        
        locationManager.delegate = self
        locationManager.distanceFilter = 500
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        getLatAndLgn()
        setupMaps()
 
        viewHierarchy()
        constraintConfiguration()
        setBackBarButtonCustom()
        setMoreButtonCustom()
        
    }
    
    // show map fully
    
    var ifMapViewEpended = false
    
    func showMapFullScreen(){
        
        if !(ifMapViewEpended){
        
            UIView.animate(withDuration: 1, animations: {
                self.mapView.frame = CGRect(x: self.mapView.frame.origin.x, y: self.mapView.frame.origin.y, width: self.mapView.frame.width, height: self.view.frame.height)
                self.miniMainViewContainer.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height, width: self.miniMainViewContainer.frame.width, height: 0)
                
            }, completion: nil)
            
            self.showMapButton.setImage(#imageLiteral(resourceName: "mapUp2"), for: .normal)
            ifMapViewEpended = true
            
            print("Map expended")
        }else {
            
            UIView.animate(withDuration: 1, animations: {
                self.mapView.frame = CGRect(x: self.mapView.frame.origin.x, y: self.mapView.frame.origin.y, width: self.mapView.frame.width, height: 150)
                self.miniMainViewContainer.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y + 87, width: 100, height: 300)
            }, completion: nil)
            self.showMapButton.setImage(#imageLiteral(resourceName: "mapExpend2"), for: .normal)
            
            ifMapViewEpended = false
            print("MapView shrinked")

            
        }
        
        
        
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
        btnLeftMenu.addTarget(self, action: #selector(contactSchool), for: .touchUpInside)
        btnLeftMenu.frame = CGRect(x: 0, y: 0, width: 50/2, height: 50/2)
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        self.navigationItem.rightBarButtonItem = barButton
    }
        


    
    func contactSchool(){
        
        let contactVC = ContactSchoolViewController()
        contactVC.schoolFromdetailSchool = self.detailSchool
        self.present(contactVC, animated: true, completion: nil)
    }
    
    func setupMaps() {
        
        let camera = GMSCameraPosition.camera(withLatitude: 40.742362,
                                              longitude: -73.935365,
                                              zoom: 18)
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
                                        
                    let theLocation = LatAndLng(dictionary: location)
                    
                    DispatchQueue.main.async {
                        self.mapView?.camera = GMSCameraPosition.camera(withLatitude: theLocation.lat, longitude: theLocation.lng, zoom: 12)
                        self.mapView.isMyLocationEnabled = true
                        self.mapView.settings.myLocationButton = true
                        self.mapView.mapType = .terrain
                        let url = Bundle.main.url(forResource: "mapStyle", withExtension: "json")
                        let mapStyle = try! GMSMapStyle.init(contentsOfFileURL: url!)
                        self.mapView.mapStyle = mapStyle
                        
                        
                        let marker = GMSMarker()
                        marker.position = CLLocationCoordinate2D(latitude: theLocation.lat, longitude: theLocation.lng )
                        marker.icon = #imageLiteral(resourceName: "school")
                        marker.title = self.detailSchool.name
                        marker.snippet = self.detailSchool.boro
                        marker.map = self.mapView
                        
                        // MAKR: - Distance
                        
                        let timesSqureLat = 40.763555
                        let timesSqureLong = -73.983416
                        
                        
                        let schoolLocation = CLLocation(latitude: theLocation.lat, longitude: theLocation.lng)
                        
                        let distanceFromTimesSquare = CLLocation(latitude: timesSqureLat, longitude: timesSqureLong)
                        
                        let distance = round((1000.0*schoolLocation.distance(from: distanceFromTimesSquare)/1609)/1000.0)
                        
                        self.title = "Distance: \(distance)"
                        
                        
                        // MARKER: - Bound between school and user current location
                        
                        let currentSchoolLocation = CLLocationCoordinate2D(latitude: theLocation.lat, longitude: theLocation.lng)
                        
                        let fromTimesSquare = CLLocationCoordinate2D(latitude: timesSqureLat, longitude: timesSqureLong)
                        
                        let bounds = GMSCoordinateBounds(coordinate: currentSchoolLocation, coordinate: fromTimesSquare)
                        let camera = self.mapView.camera(for: bounds, insets: UIEdgeInsets())!
                        self.mapView.camera = camera
                        
                        let update = GMSCameraUpdate.fit(bounds, withPadding: 50.0)
                        self.mapView.moveCamera(update)
                        
                        
                        // MARK: - Path between current location and the school
                        
                        let path = GMSMutablePath()
                        path.add(currentSchoolLocation)
                        path.add(fromTimesSquare)
                        
                        let rectangle = GMSPolyline(path: path)
                        rectangle.strokeWidth = 2.0
                        rectangle.map = self.mapView
                        
                    }
                    
                    print("School phono no.: \(self.detailSchool.phone_number)")

                }
                
                
            } catch {
                print("Error getting lat and lng")
            }
        }
    }
    
    

        func toWebVC(){
        
        let webVC = WebViewController()
        webVC.url = (self.detailSchool?.website)!
        self.navigationController?.pushViewController(webVC, animated: true)
        
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
    
    internal lazy var showMapButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "mapExpend2"), for: .normal)
        button.addTarget(self, action: #selector(showMapFullScreen), for: .touchUpInside)
        return button
    }()
    
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
    internal lazy var moreButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = ColorScheme.navColor
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .normal)
        button.setTitle("More", for: .normal)
        button.addTarget(self, action: #selector(toWebVC), for: .touchUpInside)
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

extension DetailViewController: CLLocationManagerDelegate {
    
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        self.locationManager.stopUpdatingLocation()
      
        let currentUserLocation = CLLocation(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
        self.currentUserLocation = currentUserLocation
        
        let currentLocation = CLLocationCoordinate2D(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
        self.currentLocation = currentLocation
        
        let userLocationCamera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        
        let currentLocationMarker = GMSMarker()
        currentLocationMarker.position = userLocationCamera.target
        currentLocationMarker.isDraggable = true
        currentLocationMarker.isFlat = true
        currentLocationMarker.title =  "Current Location"
        currentLocationMarker.icon = #imageLiteral(resourceName: "user")
        currentLocationMarker.snippet = "Address"
        currentLocationMarker.appearAnimation = .pop
        currentLocationMarker.map = self.mapView
        mapView?.animate(to: userLocationCamera)
        
        //Finally stop updating location otherwise it will come again and again in this delegate
        
        
        // view = mapView
   
    }
    
    //MARK: Distance calculation
    
    func distanceCalculation(currentLocation: CLLocation, schoolLocation: CLLocation) -> Double{
        return currentLocation.distance(from: schoolLocation)
    }
}





