//
//  secondNYHSTests.swift
//  secondNYHSTests
//
//  Created by Thinley Dorjee on 12/18/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import XCTest
@testable import NYHS

class secondNYHSTests: XCTestCase {
    
    var boroVC: BoroViewController!
    
    override func setUp() {
        super.setUp()
        
        boroVC = BoroViewController()
//        countTest()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoadData(){
        // given
        let expectation = self.expectation(description: "successful")
        // when
        expectation.fulfill()
        // then
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func countTest() {
        XCTAssert(boroVC.sortSchool.count == 200)
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
