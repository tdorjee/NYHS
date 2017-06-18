//
//  BoroCatagory.swift
//  NYHS
//
//  Created by Thinley Dorjee on 6/2/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation
import UIKit

// MARK: googleMap API Key: AIzaSyDDQoigYktTRrieAf8-J3ZJJeBgB-MkLI8
// MARK: GoogleMaps geocoding API key: AIzaSyDMS1l_U5Zswy_ZH51EJUNGBz-Tr-W6iCQ


public enum Boro : String {
    case Bronx = "Bronx"
    case Brooklyn = "Brooklyn"
    case Manhattan = "Manhattan"
    case Queens = "Queens"
    case StatenIsland = "Staten Island"
    
    static let section: [String] = [Boro.Bronx,
                                    Boro.Brooklyn,
                                    Boro.Manhattan,
                                    Boro.Queens,
                                    Boro.StatenIsland].map{ $0.rawValue}
    

    
    static let totalSection: Int = Boro.section.count
}


//section

//count

//boro string
