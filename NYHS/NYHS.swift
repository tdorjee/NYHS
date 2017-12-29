//
//  NYHS.swift
//  NYHS
//
//  Created by Thinley Dorjee on 5/3/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

class School: NSObject, NSCoding{
    
    let name: String
    let boro: String
    let overview_paragraph: String
    let total_students: String
    let start_time: String
    let end_time: String
    let school_sports: String
    let psal_sports_boys: String
    let psal_sports_girls: String
    let diplomaendorsements: String
    let extracurricular_activities: String
    let primary_address_line_1: String
    let zip: String
    let phone_number: String
    let fax_number: String
    let school_email: String
    let website: String
    let latitude: String
    let longitude: String
 
    init(dictionary: [String: String]) {
        self.name = dictionary["school_name"] ?? ""
        self.boro = dictionary["boro"] ?? ""
        self.diplomaendorsements = dictionary["diplomaendorsements"] ?? "N/A"
        self.overview_paragraph = dictionary["overview_paragraph"] ?? ""
        self.total_students = dictionary["total_students"] ?? ""
        self.start_time = dictionary["start_time"] ?? ""
        self.end_time = dictionary["end_time"] ?? ""
        self.school_sports = dictionary["school_sports"] ?? ""
        self.psal_sports_boys = dictionary["psal_sports_boys"] ?? ""
        self.psal_sports_girls = dictionary["psal_sports_girls"] ?? ""
        self.extracurricular_activities = dictionary["extracurricular_activities"] ?? ""
        self.primary_address_line_1 = dictionary["primary_address_line_1"] ?? ""
        self.zip = dictionary["zip"] ?? ""
        self.phone_number = dictionary["phone_number"] ?? ""
        self.fax_number = dictionary["fax_number"] ?? ""
        self.school_email = dictionary["school_email"] ?? ""
        self.website = dictionary["website"] ?? ""
        self.latitude = dictionary["latitude"] ?? ""
        self.longitude = dictionary["longitude"] ?? ""
   
    }
    
    required init(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: "school_name") as? String ?? ""
        self.boro = decoder.decodeObject(forKey: "boro") as? String ?? ""
        self.diplomaendorsements = decoder.decodeObject(forKey: "diplomaendorsements") as? String ?? ""
        self.overview_paragraph = decoder.decodeObject(forKey: "overview_paragraph") as? String ?? ""
        self.total_students = decoder.decodeObject(forKey: "total_students") as? String ?? ""
        self.start_time = decoder.decodeObject(forKey: "start_time") as? String ?? ""
        self.end_time = decoder.decodeObject(forKey: "end_time") as? String ?? ""
        self.school_sports = decoder.decodeObject(forKey: "school_sports") as? String ?? ""
        self.psal_sports_boys = decoder.decodeObject(forKey: "psal_sports_boys") as? String ?? ""
        self.psal_sports_girls = decoder.decodeObject(forKey: "psal_sports_girsl") as? String ?? ""
        self.extracurricular_activities = decoder.decodeObject(forKey: "extracurricular_activities") as? String ?? ""
        self.primary_address_line_1 = decoder.decodeObject(forKey: "primary_address_line_1") as? String ?? ""
        self.zip = decoder.decodeObject(forKey: "zip") as? String ?? ""
        self.phone_number = decoder.decodeObject(forKey: "phone_number") as? String ?? ""
        self.fax_number = decoder.decodeObject(forKey: "fax_number") as? String ?? ""
        self.school_email = decoder.decodeObject(forKey: "school_email") as? String ?? ""
        self.website = decoder.decodeObject(forKey: "website") as? String ?? ""
        self.latitude = decoder.decodeObject(forKey: "latitude") as? String ?? ""
        self.longitude = decoder.decodeObject(forKey: "longitude") as? String ?? ""
        
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "school_name")
        coder.encode(boro, forKey: "boro")
        coder.encode(diplomaendorsements, forKey: "diplomaendorsements")
        coder.encode(overview_paragraph, forKey: "overview_paragraph")
        coder.encode(start_time, forKey: "start_time")
        coder.encode(end_time, forKey: "end_time")
        coder.encode(school_sports, forKey: "school_sports")
        coder.encode(psal_sports_boys, forKey: "psal_sports_boys")
        coder.encode(psal_sports_girls, forKey: "psal_sports_girls")
        coder.encode(extracurricular_activities, forKey: "extracurricular_activities")
        coder.encode(primary_address_line_1, forKey: "primary_address_line_1")
        coder.encode(zip, forKey: "zip")
        coder.encode(phone_number, forKey: "phone_number")
        coder.encode(fax_number, forKey: "fax_number")
        coder.encode(school_email, forKey: "school_email")
        coder.encode(website, forKey: "website")
        coder.encode(latitude, forKey: "latitude")
        coder.encode(longitude, forKey: "longitude")
    }
}
