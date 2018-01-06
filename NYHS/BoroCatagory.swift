//
//  BoroCatagory.swift
//  NYHS
//
//  Created by Thinley Dorjee on 6/2/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation
import UIKit

struct ColorScheme {
    
    // Font size
    static let titleFont = UIFont.systemFont(ofSize: 15)
    static let subTitleFont = UIFont.boldSystemFont(ofSize: 12)
    static let descriptionFont = UIFont.systemFont(ofSize: 12)
    
    // Color
    static let lineSeparatorColor: UIColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1.0)
    static let lightGrey: UIColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 0.9)
    static let navColor : UIColor = UIColor(red: 80/255, green: 227/255, blue: 194/255, alpha: 1.0)
    
}

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
