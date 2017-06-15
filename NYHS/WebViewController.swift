//
//  WebViewController.swift
//  NYHS
//
//  Created by Thinley Dorjee on 6/7/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import WebKit

class WebViewController: UIViewController {

    var url: String?
    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewHierarchy()
        constraintConfiguration()
    
        let finalURL = NSURL(string: url!)
        let request = NSURLRequest(url: finalURL! as URL)
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
