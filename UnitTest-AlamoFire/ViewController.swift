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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        NetworkManager.sharedInstance.testAF()
        networkManger.getWeatherData("44", lon: "100") { (result) in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

