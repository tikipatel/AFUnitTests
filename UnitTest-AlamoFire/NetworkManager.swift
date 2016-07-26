//
//  NetworkManager.swift
//  UnitTest-AlamoFire
//
//  Created by Pratikbhai Patel on 7/26/16.
//  Copyright © 2016 Pratikbhai Patel. All rights reserved.
//

import Foundation
import Alamofire

enum NetworkError: ErrorType {
    case SomethingWentWrong
}

enum Result<T> {
    case Success(T?)
    case Error(NetworkError)
}

class NetworkManager {
    
    static let sharedInstance = NetworkManager()
    
    private let forecastIOAPIKey = "0c852834e560b691721ea810b93ff29c"
    private let baseURL = "https://api.forecast.io/forecast/"
    
    var user: String
    
    init() {
        self.user = "Some user"
    }
    
    func testAF() {
        let parameters = ["pratik" : "cool", "mobelephants" : "supercool"]
        Alamofire.request(.POST, "https://httpbin.org/post", parameters: parameters, encoding: .JSON).responseJSON { (response) in
            
            print(response.request)
            print(response.response)
            print(response.data)
            print(response.result)
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }
    
    func getWeatherData(lat: String, lon: String, completion:(Result<Weather>) -> () ) {
        Alamofire.request(.GET, "\(baseURL)\(forecastIOAPIKey)/\(lat),\(lon)").responseJSON { (response) in
            
//            print(response.request)
//            print(response.response)
//            print(response.data)
//            print(response.result)
            
//            if let currentlyJSON = (try? NSJSONSerialization.JSONObjectWithData(response.data!, options: .MutableLeaves) as? [String:AnyObject])??["currently"] {
//                print("NSJSONSeralized JSON: \(currentlyJSON)")
//            }
//            
            if let currentlyJSON = (response.result.value as? [String:AnyObject])?["currently"] as? [String:AnyObject] {
                print("JSON: \(currentlyJSON)")
                
                completion(.Success(self.parseJSONToWeather(currentlyJSON)))
            } else {
                completion(.Error(.SomethingWentWrong))
            }
        }
    }
    
    func parseJSONToWeather(JSON: [String:AnyObject]) -> Weather? {
        
        guard let time = JSON["time"] as? NSTimeInterval else {
            return nil
        }
        let date = NSDate(timeIntervalSince1970: time)
        let weather = Weather(time: date)
        
        weather.apparentTemperature = JSON["apparentTemperature"] as? Double
        weather.cloudCover = JSON["cloudCover"] as? Double
        weather.dewPoint = JSON["dewPoint"] as? Double
        weather.humidity = JSON["humidity"] as? Double
        weather.ozone = JSON["ozone"] as? Double
        weather.precipIntensity = JSON["precipIntensity"] as? Double
        weather.precipProbability = JSON["precipProbability"] as? Double
        weather.pressure = JSON ["pressure"] as? Double
        weather.summary = JSON["summary"] as? String
        weather.temperature = JSON["temperature"] as? Double
        weather.windBearing = JSON["windBearing"] as? Double
        weather.windSpeed = JSON["windSpeed"] as? Double
        
        return weather
    }
}


/*
 currently =     {
 apparentTemperature = "78.52";
 cloudCover = "0.3";
 dewPoint = "42.73";
 humidity = "0.28";
 
 ozone = "298.4";
 precipIntensity = 0;
 precipProbability = 0;
 pressure = "1004.43";
 summary = "Partly Cloudy";
 temperature = "78.52";
 time = 1469545266;
 windBearing = 256;
 windSpeed = "5.67";
 };*/