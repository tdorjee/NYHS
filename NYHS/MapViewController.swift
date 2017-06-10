//
//  MapViewController.swift
//  NYHS
//
//  Created by Thinley Dorjee on 5/20/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    //let schools: LatAndLng?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.title = "Map"
        
        viewHierarchy()
        constrainConfiguration()
        
        // MARK: Displaying map
        
        let lat = -33.86
        let long = 151.20
        
        //Terrain effet would improve the UI
        
        let camera = GMSCameraPosition.camera(withLatitude: lat , longitude: long , zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        // mapView.mapType = kGMSTypeTerrain
        view = mapView
        
        // MARK: Mark place
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(lat, long)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
//        let address = "4703 50th Avenue, woodside NY, 11377"
//        let geoCoder = CLGeocoder()
        
//        geoCoder.geocodeAddressString(address) { (placemarks, error) in
//            let placeMarked = placemarks?.first
//            let lat = placeMarked?.location?.coordinate.latitude
//            let log = placeMarked?.location?.coordinate.longitude
//        
//            // Use your location
//            //let locationByAdd = CLLocationC
//            
//            let location = CLLocationCoordinate2DMake(lat!, log!)
//            let span = MKCoordinateSpanMake(0.05, 0.04)
//    
//            let region = MKCoordinateRegion(center: location, span: span)
//            self.map.setRegion(region, animated: true)
//            
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = location
//            annotation.title = "London"
//            annotation.subtitle = "Unknown Place"
//        
//        self.map.addAnnotation(annotation)
//    }
        
        
        
    }
    
    func viewHierarchy(){
        //view.addSubview(map)
    }
    
    func constrainConfiguration(){
//        map.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        map.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        map.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        map.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
//    internal lazy var map: MKMapView = {
//        let map = MKMapView()
//        map.translatesAutoresizingMaskIntoConstraints = false
//        return map
//    }()
    
}
