//
//  NYHSHelper.swift
//  NYHS
//
//  Created by Thinley Dorjee on 5/3/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

class APIRequestManager{
    
    static let manager = APIRequestManager()
    private init(){}
    
    func getData(apiEndPoint: String, callBack: @escaping (Data?) -> Void){
        guard let url = URL(string: apiEndPoint) else { return }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { (data, response, error) in
            if error != nil{
                print("There is an error on: \(String(describing: error))")
            }
            
            //MARK: - Comment our becouse of the warning
            
            guard let validData = data else { return }
            callBack(validData)
        }.resume()
    }
    
}
