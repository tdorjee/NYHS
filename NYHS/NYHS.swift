//
//  NYHS.swift
//  NYHS
//
//  Created by Thinley Dorjee on 5/3/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

/*
 
-- SCHOOL NAME
 
 school_name: "Murray Hill Academy",
 
 -- SUMMARY
 
 overview_paragraph: "Murray Hill Academy has a unique admissions model: 80% of the students are admitted through the high school admissions process and 20% are admitted as transfer students throughout the year. Our school offers students a challenging curriculum with blended learning. We learn inside and outside the traditional classroom, including online courses with in-school mentors and internships. We are committed to academic progress, as well as the social and emotional growth of our students. Our goal is to have our students graduate prepared for college and careers and ready to become successful and productive citizens. Every child can fulfill his/her potential, one successful step at a time.",
 
 - SCHOOL SIZE
 
 total_students: "283",
 
 -- CLASS TIME
 
 start_time: "8:00 AM",
 end_time: "2:58 PM",
 
 -- DISABLITY
 
 se_services: "This school will provide students with disabilities the supports and services indicated on their IEPs.",
 
 -- SPORTS
 
 school_sports: "In our Physical Education classes all students get introduced to Badminton, Basketball, Fitness Center (Strength and Conditioning), Floor Hockey, Handball, Scooter Ball, Volleyball, Whiffleball. After school Sports Club provides students sports opportunities based on interest.",
 
 4 - EXTRACURRICULAR ACTIVITIES
 
 extracurricular_activities: "After-School Support and Enrichment for Students: Tutoring and Regents Preparation (STARS), Saturday Tutoring, BEATS Music and Poetry, Visual Arts, Community Service, Film, Green Team, Mentoring with various organizations, Year Book, MOUSE Squad/Tech Squad, National Honor Society, NYPD Youth Explorers, Peer Mediation, School Newspaper ’Paw Print’, Student Government, Student Voice Collaborative, Student Activities (COSA), GSA, Students Against Destructive Decisions, Public Speaking, International trips",
 
 program_highlights: "Personalized Learning; Internships (i.e. Parsons the New School of Design), and Job Shadowing; Blended Learning Environment; Online courses with in-school mentors; iZone360 school with a Computer Science Track, CUNY College Now at Baruch College, Medgar Evers College, and Borough of Manhattan Community College, Co-Op Tech for professional certifications; Regents and SAT Preparation; Individual College and Career Counseling; Youth Development Program with One on One Advisory support; Arts program with Theater and Mixed Media; Youth Leadership collaboration with Chris Canty Foundation; Partnerships: Good Shepherd Services, NYC Mentoring Program, High Schools That Work, Big Brothers and Big Sisters, Eskolta, reDesign, Cents’ Ability, Gilder Lehrman Institute, PENCIL; International collaboration with a high school in Finland and Free State University in South Africa",
 

 
 -- TRANSPOTATIONS
 
 bus: "BM1, BM3, BM5, BxM1, BxM10, BxM11, BxM4, BxM7, BxM8, BxM9, M1, M101, M102, M15, M15-SBS, M34A-SBS, M34-SBS, M4, M42, M5, M9, QM10, QM18, QM2, QM21, QM3, QM5, QM6, X1, X10, X14, X17, X28, X30, X5, X64, X68, X7",
 subway: "4, 5, 7, S to Grand Central - 42nd St ; B, D, F, M, N, Q, R to 34th St-Herald Square ; 6 to 33rd St",
 
 
 -- CONTACT
 
 primary_address_line_1: "111 EAST 33RD STREET",
 zip: "10016"
 phone_number: "212-696-0195",
 fax_number: "212-696-2498",
 school_email: "Amannin3@schools.nyc.gov",
 
 website: "www.mhacademy.net",
 
 overview_paragraph
 total_students
 start_time
 end_time
 se_services
 school_sports
 extracurricular_activities
 program_highlights
 
 bus
 subway
 
 primary_address_line_1
 zip
 phone_number
 fax_number
 school_email
 website
 
 */

class School: NSObject {
    
    let name: String
    let boro: String
    
    let overview_paragraph: String
    let total_students: String
    let start_time: String
    let end_time: String
    let se_services: String
    let school_sports: String
    let diplomaendorsements: String
    let extracurricular_activities: String
    let program_highlights: String
    
    let bus: String
    let subway: String
    
    let primary_address_line_1: String
    let zip: String
    let phone_number: String
    let fax_number: String
    let school_email: String
    let website: String
 
    init(dictionary: [String: String]) {
        self.name = dictionary["school_name"] ?? ""
        self.boro = dictionary["boro"] ?? ""
        self.diplomaendorsements = dictionary["diplomaendorsements"] ?? "N/A"
        self.overview_paragraph = dictionary["overview_paragraph"] ?? ""
        self.total_students = dictionary["total_students"] ?? ""
        self.start_time = dictionary["start_time"] ?? ""
        self.end_time = dictionary["end_time"] ?? ""
        self.se_services = dictionary["se_services"] ?? ""
        self.school_sports = dictionary["school_sports"] ?? ""
        self.extracurricular_activities = dictionary["extracurricular_activities"] ?? ""
        self.program_highlights = dictionary["program_highlights"] ?? ""
         
        self.bus = dictionary["bus"] ?? ""
        self.subway = dictionary["subway"] ?? ""
        
        self.primary_address_line_1 = dictionary["primary_address_line_1"] ?? ""
        self.zip = dictionary["zip"] ?? ""
        self.phone_number = dictionary["phone_number"] ?? ""
        self.fax_number = dictionary["fax_number"] ?? ""
        self.school_email = dictionary["school_email"] ?? ""
        self.website = dictionary["website"] ?? ""
   
    }

    
}
