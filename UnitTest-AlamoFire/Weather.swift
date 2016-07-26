//
//  Weather.swift
//  UnitTest-AlamoFire
//
//  Created by Pratikbhai Patel on 7/26/16.
//  Copyright © 2016 Pratikbhai Patel. All rights reserved.
//

import Foundation

class Weather:Hashable {
    
    var apparentTemperature: Double?
    var cloudCover:Double?
    var dewPoint:Double?
    var humidity: Double?
    var ozone:Double?
    var precipIntensity:Double?
    var precipProbability:Double?
    var pressure:Double?
    var summary:String?
    var temperature:Double?
    var time: NSDate
    var windBearing:Double?
    var windSpeed:Double?

    init(time: NSDate) {
        self.time = time
    }
    
    var hashValue: Int {
        return Int(time.timeIntervalSince1970 / Double(arc4random()))
    }
}

func ==(lhs:Weather, rhs:Weather) -> Bool {
    return lhs.apparentTemperature == rhs.apparentTemperature
}