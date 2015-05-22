//
//  NSDateExtensionTests.swift
//  NSDateExtensionTests
//
//  Created by Andrea Finollo on 17/05/15.
//  Copyright (c) 2015 CloudInTouch. All rights reserved.
//

import UIKit
import XCTest

class NSDateExtensionTests: XCTestCase {
    let date = NSDate()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testAddRemoveUsingOperatorOnSeconds() {
        // Add
        var dateComp = NSDateComponents()
        dateComp.second = 10
        let datePlusTenSeconds =  NSCalendar.currentCalendar().dateByAddingComponents(dateComp, toDate: date, options: nil)
        let datePlusTensSecondsExtension = date + 10.seconds
        XCTAssertTrue(datePlusTenSeconds!.isEqualToDate(datePlusTensSecondsExtension!), "Test failed dates are not equal")
        
        // Remove
        dateComp = NSDateComponents()
        dateComp.second = -10
        let dateLessOneDay =  NSCalendar.currentCalendar().dateByAddingComponents(dateComp, toDate: date, options: nil)
        let dateLessOneDayExtension = date - 10.seconds
        XCTAssertTrue(dateLessOneDay!.isEqualToDate(dateLessOneDayExtension!), "Test passed dates are equal")
    }
    func testAddRemoveUsingOperatorOnMinutes() {
        // Add
        var dateComp = NSDateComponents()
        dateComp.minute = 35
        let datePlusMinutes =  NSCalendar.currentCalendar().dateByAddingComponents(dateComp, toDate: date, options: nil)
        let datePlusMinutesExtension = date + 35.minutes
        XCTAssertTrue(datePlusMinutes!.isEqualToDate(datePlusMinutesExtension!), "Test failed dates are not equal")
        
        // Remove
        dateComp = NSDateComponents()
        dateComp.minute = -13
        let dateLessMinutes =  NSCalendar.currentCalendar().dateByAddingComponents(dateComp, toDate: date, options: nil)
        let dateLessMinutesExtension = date - 13.minutes
        XCTAssertTrue(dateLessMinutes!.isEqualToDate(dateLessMinutesExtension!), "Test failed dates are not equal")

    }
    func testAddRemoveUsingOperatorOnHours() {
        // Add
        var dateComp = NSDateComponents()
        dateComp.hour = 26
        let datePlusHours =  NSCalendar.currentCalendar().dateByAddingComponents(dateComp, toDate: date, options: nil)
        let datePlusHoursExtension = date + 26.hours
        XCTAssertTrue(datePlusHours!.isEqualToDate(datePlusHoursExtension!), "Test failed dates are not equal")
        
        // Remove
        dateComp = NSDateComponents()
        dateComp.hour = -14
        let dateLessHours =  NSCalendar.currentCalendar().dateByAddingComponents(dateComp, toDate: date, options: nil)
        let dateLessHoursExtension = date - 14.hours
        XCTAssertTrue(dateLessHours!.isEqualToDate(dateLessHoursExtension!), "Test failed dates are not equal")
        
    }
    
    func testAddRemoveUsingOperatorOnDays() {
        // Add
        var dateComp = NSDateComponents()
        dateComp.day = 1
        let datePlusOneDay =  NSCalendar.currentCalendar().dateByAddingComponents(dateComp, toDate: date, options: nil)
        let datePlusOneDayLib = date + 1.days
        XCTAssertTrue(datePlusOneDay!.isEqualToDate(datePlusOneDayLib!), "Test failed dates are not equal")
        
        // Remove
        dateComp = NSDateComponents()
        dateComp.day = -1
        let dateLessOneDay =  NSCalendar.currentCalendar().dateByAddingComponents(dateComp, toDate: date, options: nil)
        let dateLessOneDayLib = date - 1.days
        XCTAssertTrue(dateLessOneDay!.isEqualToDate(dateLessOneDayLib!), "Test failed dates are not equal")
        
    }
    func testAddRemoveUsingOperatorOnMonth() {
        // Add
        var dateComp = NSDateComponents()
        dateComp.month = 11
        let datePlusMonth =  NSCalendar.currentCalendar().dateByAddingComponents(dateComp, toDate: date, options: nil)
        let datePlusMonthExtension = date + 11.months
        XCTAssertTrue(datePlusMonth!.isEqualToDate(datePlusMonthExtension!), "Test failed dates are not equal")
        
        // Remove
        dateComp = NSDateComponents()
        dateComp.month = -14
        let dateLessMonth =  NSCalendar.currentCalendar().dateByAddingComponents(dateComp, toDate: date, options: nil)
        let dateLessMonthExtension = date - 14.months
        XCTAssertTrue(dateLessMonth!.isEqualToDate(dateLessMonthExtension!), "Test failed dates are not equal")
    }
    func testAddRemoveUsingOperatorOnWeek() {
        // Add
        var dateComp = NSDateComponents()
        dateComp.weekOfYear = 4
        let datePlusWeek =  NSCalendar.currentCalendar().dateByAddingComponents(dateComp, toDate: date, options: nil)
        let datePlusWeekExtension = date + 4.weeks
        XCTAssertTrue(datePlusWeek!.isEqualToDate(datePlusWeekExtension!), "Test failed dates are not equal")
        
        // Remove
        dateComp = NSDateComponents()
        dateComp.weekOfYear = -3
        let dateLessWeek =  NSCalendar.currentCalendar().dateByAddingComponents(dateComp, toDate: date, options: nil)
        let dateLessWeekExtension = date - 3.weeks
        XCTAssertTrue(dateLessWeek!.isEqualToDate(dateLessWeekExtension!), "Test failed dates are not equal")
    }
    
    func testIntervalOperator() {
        let datePlusTensSecondsExtension = date + 600.seconds
        let intervalFramework = datePlusTensSecondsExtension!.timeIntervalSinceDate(date)
        let intervalOperator = datePlusTensSecondsExtension! >-< date 
        XCTAssertTrue(intervalFramework == intervalOperator, "Test failed intervals are not equal")

    }

    
    func testAddingDayFromFrameworkPerformance() {
        
        self.measureBlock { () -> Void in
            let date = NSDate()
            var dateComp = NSDateComponents()
            dateComp.day = 1
            let datePlusOneDay =  NSCalendar.currentCalendar().dateByAddingComponents(dateComp, toDate: date, options: nil)
            
        }
    }
    func testAddingDayFromExtensionPerformance() {
        // This is an example of a performance test case.
        
        self.measureBlock { () -> Void in
            let date = NSDate()
            let datePlusOneDayLib = date + 1.days
            
        }
    }
    
    func testOperatorOverload() {
        let now = NSDate()
        let now2 = NSDate()
        
        let equalFW = now.isEqualToDate(now2)
        let equalEXT = now == now2
        XCTAssertTrue(equalEXT == equalFW, "Test failed date should be equal")
        
        let laterDate = now2 + 1.days
        let laterFW = laterDate!.laterDate(now)
        let answer = laterDate! > now
        let laterEXT = answer ? laterDate : now
        XCTAssertTrue(laterEXT!.isEqualToDate(laterFW), "Test failed date should be equal")

        
        let earlierDate = now2 - 2.days
        let earlierFW = earlierDate!.earlierDate(now)
        let answer2 = earlierDate! < now
        let earlierEXT = answer2 ? earlierDate : now
        XCTAssertTrue(earlierEXT!.isEqualToDate(earlierFW), "Test failed date should be equal")

    }
    
    func testComponents() {
        let noonDate = NSDate().noonDate()!
        let mignightDate = NSDate().mignightDate()!
        XCTAssertTrue(noonDate.hour == 12, "Test failed must be noon")
        XCTAssertTrue(mignightDate.hour == 00, "Test failed muste be midnight (00)")
        XCTAssertTrue(mignightDate.hour != noonDate.hour, "Test failed hour component should be different")

        
    }
    
}
