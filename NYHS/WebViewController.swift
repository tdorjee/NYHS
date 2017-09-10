//
//  WebViewController.swift
//  NYHS
//
//  Created by Thinley Dorjee on 8/12/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class WebViewController: UIViewController, UIWebViewDelegate {

    var schoolWebSite: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webview.delegate = self
        
        viewHierarchy()
        constraintConfig()
        
        
        guard let websiteInString = self.schoolWebSite, websiteInString != "" else { return print("The website is not available") }
        
        var finalWebsite: String
        
        if websiteInString.characters.first != "h"{
            finalWebsite = "http://\(websiteInString)"
        }else{
            finalWebsite = websiteInString
        }
        
        let webUrl = URL(string: finalWebsite)!
        let urlRequest = URLRequest(url: webUrl)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil{
                print("There is an error: \(String(describing: error))")
            }else {
                self.webview.loadRequest(urlRequest)
            }
        }
        task.resume()
        
    }
    
    func viewHierarchy(){
        view.addSubview(webview)
    }
    
    func constraintConfig(){
        
        self.edgesForExtendedLayout = []
        
        webview.snp.makeConstraints { (webview) in
            webview.leading.top.trailing.bottom.equalToSuperview()
        }
        
    }
    
    internal lazy var webview: UIWebView = {
        let webView = UIWebView()
        return webView
    }()
}

extension WebViewController {
    func webViewDidStartLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.title = webview.stringByEvaluatingJavaScript(from: "document.title")
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        print("There is an error loading: \(error)")
    }
}
