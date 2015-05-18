//
//  NSDateSwiftExtension.swift
//  NSDateExtension
//
//  Created by Andrea Finollo on 17/05/15.
//  Copyright (c) 2015 CloudInTouch. All rights reserved.
//

import Foundation

public enum TimeUnit {
    case Second
    case Minutes
    case Hour
    case Day
    case Week
    case Month
    case Year
}

public extension NSDate {
    static var calendar: NSCalendar {
            return NSCalendar.currentCalendar()
    }
    
    public class func dateByAddingCalendarComponent(calendarComponent: TimeUnit)(date:NSDate, value: UInt) -> NSDate?  {
        let val = Int(value)
        let dateComp = NSDateComponents()
        switch calendarComponent {
        case .Second:
            dateComp.second = val
        case .Minutes:
            dateComp.minute = val
        case .Hour:
            dateComp.hour = val
        case .Day:
            dateComp.day = val
        case .Week:
            dateComp.weekOfYear = val
        case .Month:
            dateComp.month = val
        case .Year:
            dateComp.year = val
        }
        return calendar.dateByAddingComponents(dateComp, toDate: date, options: nil)
    }
    
    public class func dateByRemovingCalendarComponent(calendarComponent: TimeUnit)(date:NSDate, value: UInt) -> NSDate?  {
        let val = -Int(value)
        let dateComp = NSDateComponents()
        switch calendarComponent {
        case .Second:
            dateComp.second = val
        case .Minutes:
            dateComp.minute = val
        case .Hour:
            dateComp.hour = val
        case .Day:
            dateComp.day = val
        case .Week:
            dateComp.weekOfYear = val
        case .Month:
            dateComp.month = val
        case .Year:
            dateComp.year = val
        }
        return calendar.dateByAddingComponents(dateComp, toDate: date, options: nil)
    }

}
//http://codingventures.com/articles/Dating-Swift/
/**
OVERRIDE Operaor dtae
*/
func <=(left: NSDate, right: NSDate) -> Bool {
    return left.timeIntervalSince1970 <= right.timeIntervalSince1970
}
func >=(left: NSDate, right: NSDate) -> Bool {
    return left.timeIntervalSince1970 >= right.timeIntervalSince1970
}
func >(left: NSDate, right: NSDate) -> Bool {
    return left.timeIntervalSince1970 > right.timeIntervalSince1970
}
func <(left: NSDate, right: NSDate) -> Bool {
    return left.timeIntervalSince1970 < right.timeIntervalSince1970
}
func ==(left: NSDate, right: NSDate) -> Bool {
    return left.timeIntervalSince1970 == right.timeIntervalSince1970
}