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
    var locationManager = CLLocationManager()
    
    var mapView: GMSMapView!
    
    
    var currentLocation = CLLocationCoordinate2D()
    var animator = UIViewPropertyAnimator()

    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        //self.title = detailSchool?.name
        view.backgroundColor = .white
        
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
                self.miniMainViewContainer.frame = CGRect(x: UIScreen.main.bounds.size.width, y: UIScreen.main.bounds.size.height, width: 0, height: 0)
                
            }, completion: nil)
            ifMapViewEpended = true
            
            print("Map expended")
        }else {
            
            UIView.animate(withDuration: 1, animations: {
                self.mapView.frame = CGRect(x: self.mapView.frame.origin.x, y: self.mapView.frame.origin.y, width: self.mapView.frame.width, height: 150)
                self.miniMainViewContainer.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y + 87, width: 100, height: 300)
            }, completion: nil)
            
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

            guard let data = data else { print("Something is going wroing here guard data")
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

                        let marker = GMSMarker()
                        marker.position = CLLocationCoordinate2D(latitude: theLocation.lat, longitude: theLocation.lng )
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
    
    func viewHierarchy(){
        
        view.addSubview(scroolView)
        scroolView.addSubview(mainContainer)
        
        mainContainer.addSubview(mapView!)
        mapView.addSubview(showMapButton)
        
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
        
        miniMainViewContainer.addSubview(moreButton)
    
        
        
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
        
        // mapView
        mapView?.snp.makeConstraints { (map) in
            map.leading.top.trailing.equalToSuperview()
            map.height.equalTo(150)
        }
        
        showMapButton.snp.makeConstraints { (button) in
            button.left.top.equalToSuperview().offset(12)
            button.height.width.equalTo(40)
        }
        
        // MARK: outlets in miniMainView
        
        miniMainViewContainer.snp.makeConstraints { (view) in
            view.left.equalToSuperview()
            view.top.equalTo(mapView.snp.bottom)
            view.right.bottom.equalToSuperview()
        }
        
        // school name
        schoolNameLabel.snp.makeConstraints { (label) in
            label.left.equalToSuperview().offset(12)
            label.top.equalTo((mapView?.snp.bottom)!).offset(15)
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
        }
        
//      More button
        moreButton.snp.makeConstraints { (button) in
            button.top.equalTo(lineSeparator4.snp.bottom).offset(15)
            button.centerX.equalToSuperview()
            button.width.equalTo(150)
            button.bottom.equalToSuperview().inset(8)
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
        label.numberOfLines = 0
        return label
    }()
    
    
    // Expand map 
    
    internal lazy var showMapButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
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
        label.font = UIFont.systemFont(ofSize: 15)
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
        label.font = UIFont.systemFont(ofSize: 15)
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
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    // transpotation
    // school_sports
    
    // overview
    internal lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.text = "Overview"
        label.textColor = UIColor(white: 0.2, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    
    internal lazy var overviewText: UILabel = {
        let label = UILabel()
        //label.sizeToFit()
        label.text = self.detailSchool.overview_paragraph
        label.font = UIFont.systemFont(ofSize: 15)
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
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    internal lazy var extracurricularActiviesText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
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






