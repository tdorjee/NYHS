//
//  WebViewController.swift
//  NYHS
//
//  Created by Thinley Dorjee on 6/7/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class WebViewController: UIViewController {

    var url: String?
    let webView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        view.addSubview(webView)
        
        webView.snp.makeConstraints { (webView) in
            webView.right.top.left.bottom.equalToSuperview()
        }
        
        guard let URL = self.url else { return }
        let finalURL = NSURL(string: URL)
        let request = NSURLRequest(url: finalURL! as URL)
        webView.loadRequest(request as URLRequest)

    }


}
