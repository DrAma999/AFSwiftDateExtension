//
//  NSDateSwiftExtension.swift
//  NSDateExtension
//
//  Created by Andrea Finollo on 17/05/15.
//  Copyright (c) 2015 CloudInTouch. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation


extension NSDate {
    
    
    var year: Int { return components(flag: .CalendarUnitYear).year }
    var month: Int { return components(flag: .CalendarUnitMonth).month }
    var week: Int { return components(flag: .CalendarUnitWeekOfYear).weekOfYear }
    var day: Int { return components(flag: .CalendarUnitDay).day }
    var hour: Int { return components(flag: .CalendarUnitHour).hour }
    var minute: Int { return components(flag: .CalendarUnitMinute).minute }
    var second: Int { return components(flag: .CalendarUnitSecond).second }
    var weekday: Int { return components(flag: .CalendarUnitWeekday).weekday }
    var ordinalWeekday: Int { return self.components().weekdayOrdinal }
    
    var daysInMonth: Int { return NSDate.calendar.rangeOfUnit(NSCalendarUnit.CalendarUnitDay, inUnit:.CalendarUnitMonth, forDate: self).length }
    
    var daysInYear: Int { return NSDate.calendar.rangeOfUnit(NSCalendarUnit.CalendarUnitDay, inUnit:.CalendarUnitYear, forDate: self).length }
    
    /**
    Creates a date with time components specified but the others are inherited from current date
    
    :param: hours    hour to set in the new `NSDate`, zero by default. This parameter can be omitted
    :param: minutes  minutes to set in the new `NSDate`, zero by default. This parameter can be omitted
    :param: seconds  second to set in the new `NSDate`, zero by default. This parameter can be omitted
    
    :returns: a new `NSDate` as an optional
    */
    public class func dateWithTime(hour hours:Int = 0, minutes:Int = 0, seconds:Int = 0) -> NSDate? {
        return  NSDate.dateWithComponents(year: nil , month: nil, day: nil, hour: hours, minutes: minutes, seconds: seconds)
    }
    
    /**
    Creates a date with time components specified but the others are inherited from current date
    
    :param: year     year to set in the new `NSDate`, if nil the value default value will be the current date year
    :param: month    month to set in the new `NSDate`, if nil the value default value will be the current date month
    :param: day      day to set in the new `NSDate`, if nil the value default value will be the current date day
    :param: hours    hour to set in the new `NSDate`, zero by default. This parameter can be omitted
    :param: minutes  minutes to set in the new `NSDate`, zero by default. This parameter can be omitted
    :param: seconds  second to set in the new `NSDate`, zero by default. This parameter can be omitted
    
    :returns: a new `NSDate` as an optional
    */
    public class func dateWithComponents(#year:Int?, month:Int?, day:Int?,  hour:Int = 0, minutes:Int = 0, seconds:Int = 0) -> NSDate? {
        let cmpts = NSDate.calendar.components(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay | .CalendarUnitEra, fromDate: NSDate())
        if let y = year {
            cmpts.year = y
        }
        if let m = month {
            cmpts.month = m
        }
        if let d = day {
            cmpts.day = d
        }
        cmpts.hour = hour
        cmpts.minute = minutes
        cmpts.second = seconds
        return  NSDate.calendar.dateFromComponents(cmpts)
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
    /**
    Returns a date with time set to noon and other components inherited from the caller
    
    :returns: a new `NSDate` with time at noon but the other componets equal to the original
    */
    public func noonDate()-> NSDate? {
        var cmpts = NSDate.calendar.components(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay | .CalendarUnitEra, fromDate: self)
        cmpts.hour = 12
        cmpts.minute = 0
        cmpts.second = 0
        cmpts.nanosecond = 0
        return  NSDate.calendar.dateFromComponents(cmpts)
    }
    /**
    Returns a date with time set to midnight and other components inherited from the caller
    
    :returns: a new `NSDate` with time at midnight but the other componets equal to the original
    */
    public func mignightDate()-> NSDate? {
        var cmpts = NSDate.calendar.components(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay | .CalendarUnitEra, fromDate: self)
        cmpts.hour = 0
        cmpts.minute = 0
        cmpts.second = 0
        cmpts.nanosecond = 0
        return  NSDate.calendar.dateFromComponents(cmpts)
    }
    /**
    Returns a string based on the time difference between now and the instance
    
    :returns: a `String` based on the time difference between now and the instance
    */
    public func textTimeAgoFromNow()-> String {
        let interval =  self.timeIntervalSinceNow
        let agoBefore:String
        if interval < 0 {
            agoBefore = NSLocalizedString("KEY_BEFORE_INTERVAL", comment: "Before")
        }
        else {
            agoBefore = NSLocalizedString("KEY_AGO_INTERVAL", comment: "Ago")
        }
        
        let absInterval:Int = abs(Int(interval))
        var unit: String!
        var number: Int!
        var resto: Int!
        var returnString: String!
        let dateformatter = NSDate.dateFormatter
        switch absInterval {
        case 0:
            unit = NSLocalizedString("KEY_NOW_INTERVAL", comment: "Now")
            number = absInterval
            returnString = NSString.localizedStringWithFormat("%@",unit) as String
        case 1:
            unit = NSLocalizedString("KEY_SECOND_INTERVAL", comment: "Second")
            number = absInterval
            returnString =  NSString.localizedStringWithFormat("%@ %@ %@",String(number),unit, agoBefore) as String
        case 1..<60:
            unit = NSLocalizedString("KEY_SECONDS_INTERVAL", comment: "Seconds")
            returnString =  NSString.localizedStringWithFormat("%@ %@ %@",String(number),unit, agoBefore) as String
        case 60:
            unit = NSLocalizedString("KEY_MINUTE_INTERVAL", comment: "Minute")
            number = absInterval/kSecondsInMinute
            returnString =  NSString.localizedStringWithFormat("%@ %@ %@",String(number),unit, agoBefore) as String
        case 60..<3600:
            unit = NSLocalizedString("KEY_MINUTES_INTERVAL", comment: "Minutes")
            number = absInterval/kSecondsInMinute
            returnString =  NSString.localizedStringWithFormat("%@ %@ %@",String(number),unit, agoBefore) as String
        case 3600:
            unit = NSLocalizedString("KEY_HOUR_INTERVAL", comment: "Hour")
            number = absInterval/kSecondsInHour
            returnString =  NSString.localizedStringWithFormat("%@ %@ %@",String(number),unit, agoBefore) as String
        case 3600..<86400:
            unit = NSLocalizedString("KEY_TODAY_INTERVAL", comment: "Today")
            NSDate.dateFormatter.dateStyle = .NoStyle
            NSDate.dateFormatter.timeStyle = .MediumStyle
            let formattedTime = dateformatter.stringFromDate(self)
            returnString =  NSString.localizedStringWithFormat("%@ at %@",unit, formattedTime) as String
        case 86400:
            unit = NSLocalizedString("KEY_YESTERDAY_INTERVAL", comment: "Yesterday")
            returnString =  NSString.localizedStringWithFormat("%@",unit) as String
        case 86400..<172800:
            unit = NSLocalizedString("KEY_YESTERDAY_INTERVAL", comment: "Yesterday")
            dateformatter.dateStyle = .NoStyle
            dateformatter.timeStyle = .MediumStyle
            let formattedTime = dateformatter.stringFromDate(self)
            returnString =  NSString.localizedStringWithFormat("%@ at %@",unit, formattedTime) as String
        default:
            dateformatter.dateStyle = .MediumStyle
            dateformatter.timeStyle = .MediumStyle
            let formattedTime = dateformatter.stringFromDate(self)
            returnString =  NSString.localizedStringWithFormat("%@", formattedTime) as String
        }
        return returnString
    }
    
    /**
    Returns a tuple for components requested in this format (hour:Int?, minute:Int?, second:Int?, day:Int?, month:Int?, year:Int?)
    */
    subscript(indexes: TimeUnitMeasure...) -> (hour:Int?, minute:Int?, second:Int?, day:Int?, month:Int?, year:Int?) {
        var value:(hour:Int?, minute:Int?, second:Int?, day:Int?, month:Int?, year:Int?) ;
        for idx in indexes {
            let num = convertTimeUnitIntoDateValues(idx, forDate: self)
            switch idx {
            case .Seconds:
                value.second = num
            case .Minutes:
                value.minute = num
            case .Hours:
                value.hour = num
            case .Days:
                value.day = num
            case .Months:
                value.month = num
            case .Years:
                value.year = num
            case .Weeks:
                assert(true, "Weeks is not a valid index")
            }
        }
        return value
    }
    /**
    Returns an Int for the component requested
    */
    subscript(index: TimeUnitMeasure) -> Int {
        return convertTimeUnitIntoDateValues(index, forDate: self)
    }

    
    private func components(flag:NSCalendarUnit = NSDate.calendarFlags) -> NSDateComponents {
        return NSCalendar.currentCalendar().components(flag, fromDate: self)
    }
    
    private class func dateByChangingTimeUnit(timeUnitMeasure: TimeUnitMeasure, withValue val:Int, fromDate date:NSDate ) -> NSDate? {
        let val = Int(val)
        let dateComp = date.components()
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
        return NSDate.calendar.dateFromComponents(dateComp)
    }
    
    private func convertTimeUnitIntoDateValues(timeunit:TimeUnitMeasure, forDate date:NSDate) ->Int {
        let value:Int
        switch timeunit {
        case .Seconds:
            value = date.second
        case .Minutes:
            value = date.minute
        case .Hours:
            value = date.hour
        case .Days:
            value = date.day
        case .Months:
            value = date.month
        case .Years:
            value = date.year
        case .Weeks:
            value = date.week
        }
        return value
    }
    
    static var calendar: NSCalendar {
        return NSCalendar.currentCalendar()
    }
    static var dateFormatter: NSDateFormatter    {
        struct Static {
             static let instanceDateFormatter = NSDate.createDateFormatter()
        }
        return Static.instanceDateFormatter
    }
    private class func createDateFormatter() -> NSDateFormatter {
        return NSDateFormatter()
    }
    static var calendarFlags: NSCalendarUnit {
        return (.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay | .CalendarUnitWeekOfYear | .CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitSecond  | .CalendarUnitWeekday | .CalendarUnitWeekdayOrdinal | .CalendarUnitEra)
    }
    
}

public enum TimeUnitMeasure {
    case Seconds
    case Minutes
    case Hours
    case Days
    case Weeks
    case Months
    case Years
}


public struct TimeFrame {
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
        case .Days:
            cmpts.day = value
        case .Weeks:
            cmpts.weekOfYear = value
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
    let result = left.compare(right)
    var isEqual = false
    if (result == .OrderedSame) {
        isEqual = true
    }
    return isEqual

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


let kSecond = 1
let kSecondsInMinute = 60
let kSecondsInHour = 3600
let kSecondsInDay = 86400
let kSecondsInWeek = 604800






