//
//  ViewController.swift
//  WeatherTableView
//
//  Created by 低调 on 12/9/19.
//  Copyright © 2019 Kaiyuan Zhao. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var myTableView: UITableView!
    var weatherArray: [Weather] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myTableView.delegate = self
        myTableView.dataSource = self
        Alamofire.request("https://api.openweathermap.org/data/2.5/forecast/daily?q=Philadelphia,us&appid=a3dda1c09a26b1c0edf12dc3e88f6991&mode=json").responseJSON { (response) in
            if let responseStr = response.result.value {
                let jsonResponse = JSON(responseStr)
                let jsonWeather = jsonResponse["weather"].array![0]
                let jsonTemp = jsonResponse["temp"]
                let jsonHum = jsonResponse["humidity"]
                let iconName = jsonResponse["icon"].stringValue
                
                let weather1 = Weather(temp: jsonTemp["day"].doubleValue, huminity: jsonHum.intValue, description: jsonWeather["description"].stringValue, icon: UIImage(named: iconName)!)
                self.weatherArray.append(weather1)
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let weather = weatherArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell") as! WeatherCell
        cell.setWeather(weather: weather)
        return cell
    }
}

