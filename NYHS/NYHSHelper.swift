//
//  NYHSHelper.swift
//  NYHS
//
//  Created by Thinley Dorjee on 5/3/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

class NYHSHelper{
    
    static let manager = NYHSHelper()
    private init(){}
    
    let apiEndPoint: String = "https://data.cityofnewyork.us/resource/4isn-xf7m.json"
    
    func getData(apiEndPoint: String, callBack: @escaping (Data) -> Data){
        guard let url = URL(string: apiEndPoint) else { return }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { (data, response, error) in
            if error != nil{
                print("There is an error on: \(String(describing: error))")
            }
            
            //MARK: - Comment our becouse of the warning
            
//            guard let validData = data else { return }
//        
//            callBack(validData)
        }.resume()
    }
    
}
