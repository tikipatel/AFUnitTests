//
//  NetworkManager.swift
//  UnitTest-AlamoFire
//
//  Created by Pratikbhai Patel on 7/26/16.
//  Copyright © 2016 Pratikbhai Patel. All rights reserved.
//

import Foundation
import Alamofire


enum Result<T> {
    case Success(T)
    case Error(NSError)
}

class NetworkManager {
    
    static let sharedInstance = NetworkManager()
    
    private let forecastIOAPIKey = "0c852834e560b691721ea810b93ff29c"
    private let baseURL = "https://api.forecast.io/forecast/"
    
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
    
    func getWeatherData(lat: String, lon: String, completion:(Result<AnyObject>) ->() ) {
        Alamofire.request(.GET, "\(baseURL)\(forecastIOAPIKey)/\(lat),\(lon)").responseJSON { (response) in
            
            print(response.request)
            print(response.response)
//            print(response.data)
//            print(response.result)
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }
}