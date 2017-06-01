//
//  MapViewController.swift
//  NYHS
//
//  Created by Thinley Dorjee on 5/20/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.title = "Map"
        
        view.addSubview(map)
        
        let location = CLLocationCoordinate2DMake(51.50007773, 0.1246402)
        let span = MKCoordinateSpanMake(0.05, 0.04)
        
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "London"
        annotation.subtitle = "Unknown Place"
        map.addAnnotation(annotation)
        
        
        map.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        map.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        map.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        map.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    internal lazy var map: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
}
