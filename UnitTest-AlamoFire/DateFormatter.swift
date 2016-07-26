//
//  DateFormatter.swift
//  UnitTest-AlamoFire
//
//  Created by Pratikbhai Patel on 7/26/16.
//  Copyright © 2016 Pratikbhai Patel. All rights reserved.
//

import Foundation

enum DateFormat: String {
    case ISO8601 = "yyyy-MM-dd'T'HH:mm:ssZ"
    case MonthYear = "MMMM yyyy"
}


class DateFormatter {
    
    static let sharedInstance = DateFormatter()
    
    let dateFormatter = NSDateFormatter()
    
    func getDateFromFormat(format: DateFormat, string: String) -> NSDate? {
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.dateFromString(string)
    } //"July 2016"
    
    // "Tuesday, 26th of July, 2016 HH:MM AM"
    
    func monthYearString(date: NSDate) -> String {
        let formatString = "MMMM yyyy"
        dateFormatter.dateFormat = formatString
        return dateFormatter.stringFromDate(date)
    }
    
    func getCustomDateString(date: NSDate) -> String {
        func getSuffix(date: NSDate) -> String {
            let calender = NSCalendar.currentCalendar()
            let dayOfMonth = calender.component(.Day, fromDate: date)
            switch dayOfMonth {
            case 1,21,31: return "st"; case 2,22: return "nd"; case 3,23: return "rd";default: return "th"
            }
        }
        
        let mySuffix = getSuffix(date)
        dateFormatter.dateFormat = "EEEE, dd'\(mySuffix) of' MMMM, YYYY hh:mm a"
        return dateFormatter.stringFromDate(date)
    }
}