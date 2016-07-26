//
//  UnitTest_AlamoFireTests.swift
//  UnitTest-AlamoFireTests
//
//  Created by Pratikbhai Patel on 7/26/16.
//  Copyright © 2016 Pratikbhai Patel. All rights reserved.
//

import XCTest
@testable import UnitTest_AlamoFire

class UnitTest_AlamoFireTests: XCTestCase {
    
    let dateFormatter = DateFormatter.sharedInstance
    let julyDateString = "2016-07-26T20:19:56-05:00"
    let mayDateString = "2016-05-26T20:19:56-05:00"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testFileExists() {
        let fileName = "weather"
        let fileType = "json"
        let filePath = NSBundle(forClass: UnitTest_AlamoFireTests.self).pathForResource(fileName, ofType: fileType)
        XCTAssertNotNil(filePath, "Assert that file exists in bundle")
    }
    
    func weatherJSONFilePath() -> String {
        let fileName = "weather"
        let fileType = "json"
        let filePath = NSBundle(forClass: UnitTest_AlamoFireTests.self).pathForResource(fileName, ofType: fileType)
        return filePath!
    }
    
    func testParser() {
        let jsonData = NSData(contentsOfFile: weatherJSONFilePath())
        let JSON = try! NSJSONSerialization.JSONObjectWithData(jsonData!, options: .MutableLeaves) as! [String:AnyObject]
        let weather = NetworkManager.sharedInstance.parseJSONToWeather(JSON)
        XCTAssertNotNil(weather, "The parser should have given us a weather object. Something's wrong with the time.")
        XCTAssertEqual(weather!.time.timeIntervalSince1970, 1469553771, "The time interval should match our JSON file.")
        XCTAssertEqual(weather!.summary, "Partly Cloudy", "Should be equal to what we have in JSON.")
        // and so on...
    }
        
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func getJulyDate() -> NSDate {
        guard let date = dateFormatter.getDateFromFormat(.ISO8601, string: julyDateString) else {
            fatalError()
        }
        return date
    }
    func getMayDate() -> NSDate {
        guard let date = dateFormatter.getDateFromFormat(.ISO8601, string: mayDateString) else {
            fatalError()
        }
        return date
    }
    
    
    func testMontYearFormat() {
        let testString = "July 2016"
        let julyDate = getJulyDate()
        let julyYearString = dateFormatter.monthYearString(julyDate)
        XCTAssertEqual(julyYearString, testString, "The month-year string returned from the formatter should equal our test string.")
        
        let test2String = "May 2016"
        let mayDate = getMayDate()
        let mayYearString = dateFormatter.monthYearString(mayDate)
        XCTAssertEqual(mayYearString, test2String, "Some sensible text here")
        

    }
    
    func testDateFormatter() {
        let myDateFormatter = DateFormatter.sharedInstance
        let dateString = "2016-07-26T20:19:56-05:00"
        let myDate = myDateFormatter.getDateFromFormat(.ISO8601, string: dateString)
        XCTAssertNotNil(myDate, "The date formatter should have been able to parse the given date.")
    }
    
    func testCustomDateFormatter() {
        
        
        
    }
    
    
}
