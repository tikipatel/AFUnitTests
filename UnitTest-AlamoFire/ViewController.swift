//
//  ViewController.swift
//  UnitTest-AlamoFire
//
//  Created by Pratikbhai Patel on 7/26/16.
//  Copyright © 2016 Pratikbhai Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let networkManger = NetworkManager.sharedInstance
    @IBOutlet weak var tableView: UITableView!
    
    var weatherData = [String]()
    var globalWeather = Weather(time: NSDate())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //        NetworkManager.sharedInstance.testAF()
        
        networkManger.user = "ViewController"
        networkManger.getWeatherData("44", lon: "10") { (result) in
            switch result {
            case .Success(let weather):
                if let weather = weather {
                    self.globalWeather = weather
                    self.weatherData = Mirror(reflecting: weather).children.flatMap { $0.label }
                    self.tableView.reloadData()
                }
            case .Error(let error):
                print(error)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("weatherCell")! as UITableViewCell
        
        cell.textLabel?.text = (weatherData[indexPath.row] as String).uppercaseString
        cell.detailTextLabel?.text = returnDetailForIndex(globalWeather, index: indexPath.row)
        return cell
    }
    
    func returnDetailForIndex(weather: Weather, index: Int) -> String {
        switch index {
        case 0:
            return "\(weather.apparentTemperature!) ºF"
        case 1:
            return "\(weather.cloudCover!)"
        case 2:
            return "\(weather.dewPoint!)"
        case 3:
            return "\(weather.humidity!)"
        case 4:
            return "\(weather.ozone!)"
        case 5:
            return "\(weather.precipIntensity!)"
        case 6:
            return "\(weather.precipProbability!)"
        case 7:
            return "\(weather.pressure!)"
        case 8:
            return "\(weather.summary!)"
        case 9:
            return "\(weather.temperature!)"
        case 10:
            return "\(DateFormatter.sharedInstance.getCustomDateString(weather.time))"
        case 11:
            return "\(weather.windBearing!)"
        case 12:
            return "\(weather.windSpeed!)"
        default:
            return ""
        }
    }
}

extension ViewController: UITableViewDelegate {
    
}
