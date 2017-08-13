//
//  googleMapVC.swift
//  NYHS
//
//  Created by Thinley Dorjee on 6/7/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import WebKit

class googleMapVC: UIViewController {

    let currentLocation = "Times Square, Address Manhattan, NY 10036"
    var schoolAddress: String?
    
    var schoolLat: Float = 0.0
    var schoolLog: Float = 0.0
    
    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewHierarchy()
        constraintConfiguration()
        
        print("lat: \(schoolLat)")
        print("lng: \(schoolLog)")
        
        //MARK: - Show GoogleMap
        
        
    /*
         
    
         if (UIApplication.shared.canOpenURL(NSURL(string:"https://maps.google.com")! as URL))
         {
         UIApplication.shared.openURL(NSURL(string:
         "https://maps.google.com/?q=@\(schoolLat),\(schoolLog)")! as URL)
         }
         
         */
        
        
        
         let googleMap = NSURL(string: "https://maps.google.com/?q=@\(schoolLat),\(schoolLog)")
        
         let request = NSURLRequest(url: googleMap! as URL)
         webView.load(request as URLRequest)
         
 
        
        //print("The website is: \(url)")
    }
    
    func viewHierarchy(){
        view.addSubview(webView)
        
    }
    
    func constraintConfiguration(){
        
        self.edgesForExtendedLayout = []
        webView.snp.makeConstraints { (webView) in
            webView.right.top.left.bottom.equalToSuperview()
        }
        
    }



}
