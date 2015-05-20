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
    var weeks: TimeFrame {
        return TimeFrame(value: self, unitMeasure:.Weeks);
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
    
    public func noonDate()-> NSDate? {
        var cmpts = NSDate.calendar.components(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay, fromDate: self)
        cmpts.hour = 12
        cmpts.minute = 0
        cmpts.second = 0
        cmpts.nanosecond = 0
        return  NSDate.calendar.dateFromComponents(cmpts)
    }

    public func mignightDate()-> NSDate? {
        var cmpts = NSDate.calendar.components(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay, fromDate: self)
        cmpts.hour = 0
        cmpts.minute = 0
        cmpts.second = 0
        cmpts.nanosecond = 0
        return  NSDate.calendar.dateFromComponents(cmpts)
    }
    
    // TODO: to be finished
    public func textIntervalFromNow()-> String {
        let interval =  self.timeIntervalSinceNow
        var agoBefore:String!
        if interval < 0 {
            agoBefore = NSLocalizedString("KEY_BEFORE_INTERVAL", comment: "Before")
        }
        else {
            agoBefore = NSLocalizedString("KEY_BEFORE_INTERVAL", comment: "Ago")
        }
        
        let absInterval:Int = abs(Int(interval))
        var unit: String!
        var number: Int!
        switch absInterval {
        case 0:
            unit = NSLocalizedString("KEY_NOW_INTERVAL", comment: "Now")
            number = absInterval
        case 1:
            unit = NSLocalizedString("KEY_SECOND_INTERVAL", comment: "Second")
            number = absInterval
        case 1..<60:
            unit = NSLocalizedString("KEY_SECONDS_INTERVAL", comment: "Seconds")
        case 60:
            unit = NSLocalizedString("KEY_MINUTE_INTERVAL", comment: "Minute")
            number = absInterval/60
        case 60..<600:
            unit = NSLocalizedString("KEY_MINUTES_INTERVAL", comment: "Minutes")
            number = absInterval/60
        default:
            unit = ""
        }
        // TODO: absInterval multiplier
        return  "\(number) \(unit) \(agoBefore)"
    }
}

// MARK: NSDate operators overload

/**
    Compare dates
*/
func <=(left: NSDate, right: NSDate) -> Bool {
    let result = left.compare(right)
    var isEarlier = false
    if (result == .OrderedAscending || result == .OrderedSame) {
        isEarlier = true
    }
    return isEarlier
}
func >=(left: NSDate, right: NSDate) -> Bool {
    let result = left.compare(right)
    var isLater = false
    if (result == .OrderedDescending || result == .OrderedSame) {
        isLater = true
    }
    return isLater
}
func >(left: NSDate, right: NSDate) -> Bool {
    let result = left.compare(right)
    var isLater = false
    if (result == .OrderedDescending) {
        isLater = true
    }
    return isLater
}
func <(left: NSDate, right: NSDate) -> Bool {
    let result = left.compare(right)
    var isEarlier = false
    if (result == .OrderedAscending) {
        isEarlier = true
    }
    return isEarlier
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
infix operator  >-< { associativity left precedence 140 }

func >-< (left: NSDate, right: NSDate) -> NSTimeInterval {
    return (left.timeIntervalSince1970 - right.timeIntervalSince1970)
}

// MARK: NSDate and TimeFrame operators overload

func - (left: NSDate, right: TimeFrame) -> NSDate? {
    let negRight = TimeFrame(value: -right.value, unitMeasure: right.unitMeasure)
    return NSCalendar.currentCalendar().dateByAddingComponents(negRight.dateComponents(), toDate: left, options: nil)
}

func + (left: NSDate, right: TimeFrame) -> NSDate? {
    return NSCalendar.currentCalendar().dateByAddingComponents(right.dateComponents(), toDate: left, options: nil)
}

func -= (left: NSDate, right: TimeFrame) -> NSDate? {
    let negRight = TimeFrame(value: -right.value, unitMeasure: right.unitMeasure)
    return NSCalendar.currentCalendar().dateByAddingComponents(negRight.dateComponents(), toDate: left, options: nil)
}

func += (left: NSDate, right: TimeFrame) -> NSDate? {
    return NSCalendar.currentCalendar().dateByAddingComponents(right.dateComponents(), toDate: left, options: nil)
}










