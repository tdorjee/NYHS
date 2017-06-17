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

    override func viewDidLoad() {
        super.viewDidLoad()
     
        //self.title = detailSchool?.name
        view.backgroundColor = .white
        
        getLatAndLgn()
        setupMaps()
 
        viewHierarchy()
        constraintConfiguration()
    
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: ))
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "favoriteIcon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(viewFavoriteSchools))
        
        //navigationItem.rightBarButtonItem(favSchools)

    }
    
    func addToFavourite(){
        
        let favSchool = UserDefaults.standard.object(forKey: "items")
        
        var favSchoolAdd: [String]
        
        if let tempSchool = favSchool as? [String]{
            favSchoolAdd = tempSchool
            favSchoolAdd.append(detailSchool.name)
            print("Check to see if the school is saved: \(favSchoolAdd)")
        }else {
            favSchoolAdd = [detailSchool.name]
        }
        
        UserDefaults.standard.set(favSchoolAdd, forKey: "items")
//        if var dict = UserDefaults.standard.dictionary(forKey: "favoriteSchools") {
//            dict[detailSchool.name] = detailSchool.name
//            UserDefaults.standard.set(dict, forKey: "favoriteSchools")
//        }else {
//            let dict = [detailSchool.name : detailSchool.name]
//            UserDefaults.standard.set(dict, forKey: "favoriteSchools")
//        }
    }
    
    func viewFavoriteSchools(){

        let favouriteVC = FavouriteTableViewController()
        self.navigationController?.pushViewController(favouriteVC, animated: true)
        
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
        mainContainer.addSubview(favoriteButton)
        mainContainer.addSubview(overviewLabel)
        mainContainer.addSubview(overviewText)
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
        
        // mapView
        mapView?.snp.makeConstraints { (map) in
            map.leading.top.trailing.equalToSuperview()
            map.height.equalTo(150)
        }

        
        // favorite button
        
        favoriteButton.snp.makeConstraints { (button) in
            button.centerY.equalTo(overviewLabel)
            button.right.equalToSuperview().inset(8)
            button.height.width.equalTo(40)
        }
        
        // overView
        overviewLabel.snp.makeConstraints { (label) in
            label.left.equalToSuperview().offset(8)
            label.top.equalTo((mapView?.snp.bottom)!).offset(8)
            label.right.equalTo(favoriteButton.snp.left).inset(8)
        }
        
        overviewText.snp.makeConstraints { (label) in
            label.left.equalToSuperview().offset(8)
            label.top.equalTo(overviewLabel.snp.bottom).offset(10)
            label.right.equalToSuperview().inset(8)
        }
        
//      More button

        moreButton.snp.makeConstraints { (button) in
            button.top.equalTo(overviewText.snp.bottom).offset(10)
            button.leading.equalToSuperview()
            button.width.equalTo(mainContainer.snp.width)
            button.bottom.equalToSuperview().inset(8)
        }
        
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
        label.text = "\(self.detailSchool.name)"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    // favorite button
    internal lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "starIcon"), for: .normal)
        button.backgroundColor = .yellow
        button.addTarget(self, action: #selector(addToFavourite), for: .touchUpInside)
        return button
    }()
    
    internal lazy var overviewText: UILabel = {
        let label = UILabel()
        //label.sizeToFit()
        label.text = self.detailSchool.overview_paragraph
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = ColorScheme.subtitleTextColor
        label.textColor = UIColor(white: 0.2, alpha: 1)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        return label
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

extension String {
    func height(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = self
        label.sizeToFit()
        
        return label.frame.height
    }
}






