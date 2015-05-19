//
//  NSDateSwiftExtension.swift
//  NSDateExtension
//
//  Created by Andrea Finollo on 17/05/15.
//  Copyright (c) 2015 CloudInTouch. All rights reserved.
//

import Foundation

public enum TimeUnitMeasure {
    case Seconds
    case Minutes
    case Hours
    case Days
    case Weeks
    case Months
    case Years
}


struct TimeFrame {
    var value: Int
    var unitMeasure: TimeUnitMeasure
    
    private func dateComponents() -> NSDateComponents {
        let cmpts = NSDateComponents()
        switch (self.unitMeasure) {
        case .Seconds:
            cmpts.second = value
        case .Minutes:
            cmpts.minute = value
        case .Hours:
            cmpts.hour = value
            break
        case .Days:
            cmpts.day = value
        case .Weeks:
            cmpts.weekOfYear = value
            break
        case .Months:
            cmpts.month = value
        case .Years:
            cmpts.year = value
        default:
            cmpts.day = value
        }
        return cmpts
    }
    
}


extension Int {
    var seconds: TimeFrame {
        return TimeFrame(value: self, unitMeasure:.Seconds);
    }
    var minutes: TimeFrame {
        return TimeFrame(value: self, unitMeasure:.Minutes);
    }
    var hours: TimeFrame {
        return TimeFrame(value: self, unitMeasure:.Hours);
    }
    var days: TimeFrame {
        return TimeFrame(value: self, unitMeasure:.Days);
    }
    var months: TimeFrame {
        return TimeFrame(value: self, unitMeasure:.Months);
    }
    var years: TimeFrame {
        return TimeFrame(value: self, unitMeasure:.Years);
    }

}

extension NSDate {
    static var calendar: NSCalendar {
            return NSCalendar.currentCalendar()
    }
    /**
    Curryed function to add a time unit for a specific value
    
    :param: timeUnit time unit
    
    :returns: a new `NSDate` as an optional
    */
    public class func dateByAddingCalendarComponent(#timeUnitMeasure: TimeUnitMeasure)(date:NSDate, value: UInt) -> NSDate?  {
        let val = Int(value)
        let dateComp = NSDateComponents()
        switch timeUnitMeasure {
        case .Seconds:
            dateComp.second = val
        case .Minutes:
            dateComp.minute = val
        case .Hours:
            dateComp.hour = val
        case .Days:
            dateComp.day = val
        case .Weeks:
            dateComp.weekOfYear = val
        case .Months:
            dateComp.month = val
        case .Years:
            dateComp.year = val
        }
        return calendar.dateByAddingComponents(dateComp, toDate: date, options: nil)
    }
    /**
    Curryed function to remove a time unit for a specific value
    
    :param: timeUnit time unit
    
    :returns: a new `NSDate` as an optional
    */

    public class func dateByRemovingCalendarComponent(#timeUnitMeasure: TimeUnitMeasure)(date:NSDate, value: UInt) -> NSDate?  {
        let val = -Int(value)
        let dateComp = NSDateComponents()
        switch timeUnitMeasure {
        case .Seconds:
            dateComp.second = val
        case .Minutes:
            dateComp.minute = val
        case .Hours:
            dateComp.hour = val
        case .Days:
            dateComp.day = val
        case .Weeks:
            dateComp.weekOfYear = val
        case .Months:
            dateComp.month = val
        case .Years:
            dateComp.year = val
        }
        return calendar.dateByAddingComponents(dateComp, toDate: date, options: nil)
    }

}

// MARK: NSDate operators overload

/**
    Compare date
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


/**
Operators that return the time interval between two dates

:param: left  A date
:param: right A date

:returns: time interval between the two dates in `NSTimeInterval`
*/
infix operator  >=< { associativity left precedence 140 }

func >=< (left: NSDate, right: NSDate) -> NSTimeInterval {
    return (left.timeIntervalSince1970 - right.timeIntervalSince1970)
}

// MARK: NSDate and TimeFrame operators overload

func - (left: NSDate, right: TimeFrame) -> NSDate {
    let negRight = TimeFrame(value: -right.value, unitMeasure: right.unitMeasure)
    return NSCalendar.currentCalendar().dateByAddingComponents(negRight.dateComponents(), toDate: left, options: nil)!
}

func + (left: NSDate, right: TimeFrame) -> NSDate {
    return NSCalendar.currentCalendar().dateByAddingComponents(right.dateComponents(), toDate: left, options: nil)!
}

func -= (left: NSDate, right: TimeFrame) -> NSDate {
    let negRight = TimeFrame(value: -right.value, unitMeasure: right.unitMeasure)
    return NSCalendar.currentCalendar().dateByAddingComponents(negRight.dateComponents(), toDate: left, options: nil)!
}

func += (left: NSDate, right: TimeFrame) -> NSDate {
    return NSCalendar.currentCalendar().dateByAddingComponents(right.dateComponents(), toDate: left, options: nil)!
}










