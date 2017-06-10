//
//  LatAndLng.swift
//  NYHS
//
//  Created by Thinley Dorjee on 6/8/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

class LatAndLng {
    let lat: Double
    let lng: Double
    
    init(dictionary: [String: Double]) {
        self.lat = dictionary["lat"] ?? 0.0
        self.lng = dictionary["lng"] ?? 0.0
    }
    
}
