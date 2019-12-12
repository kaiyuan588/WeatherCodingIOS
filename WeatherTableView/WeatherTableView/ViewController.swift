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


class ViewController: UITableViewController{
   // @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet var myTableView: UITableView!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myTableView.delegate = self
        myTableView.dataSource = self
    Alamofire.request("http://api.openweathermap.org/data/2.5/forecast?q=Philadelphia,us&mode=json&appid=a3dda1c09a26b1c0edf12dc3e88f6991&amp;units=metric&amp;cnt=4").responseJSON { (response) in
            if let responseStr = response.result.value {
                let jsonResponse = JSON(responseStr)
                for eachList in 0 ..< jsonResponse["list"].count {
                    let jsonWeather = jsonResponse["list"][eachList]["weather"][0]
                    let jsonTemp = jsonResponse["list"][eachList]["main"]["temp"]
                    let jsonHum = jsonResponse["list"][eachList]["main"]["humidity"]
                    let iconName = jsonResponse["list"][eachList]["weather"][0]["icon"].stringValue
                    let jsonMaxTemp = jsonResponse["list"][eachList]["main"]["temp_max"]
                    let jsonMinTemp = jsonResponse["list"][eachList]["main"]["temp_min"]
                    let jsonPressure = jsonResponse["list"][eachList]["main"]["pressure"]

                    let weather1 = Weather(temp: jsonTemp.doubleValue, huminity: jsonHum.intValue, description: jsonWeather["description"].stringValue, icon: UIImage(named: iconName)!, maxTemp: jsonMaxTemp.doubleValue, minTemp: jsonMinTemp.doubleValue, pressure: jsonPressure.intValue)
                    
                    DetailWeatherViewController.self.weatherArray.append(weather1)
                }

                self.myTableView.reloadData()
            }
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DetailWeatherViewController.weatherArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let weather = DetailWeatherViewController.weatherArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell") as! WeatherCell
        cell.setWeather(weather: weather)

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(identifier: "DetailViewController") as! DetailWeatherViewController
        
        vc.temp = String(DetailWeatherViewController.weatherArray[indexPath.row].temp)
        vc.image = DetailWeatherViewController.weatherArray[indexPath.row].icon
        vc.hum = String(DetailWeatherViewController.weatherArray[indexPath.row].huminity)
        vc.des = DetailWeatherViewController.weatherArray[indexPath.row].description
        vc.maxTemp = String(DetailWeatherViewController.weatherArray[indexPath.row].maxTemp)
        vc.minTemp = String(DetailWeatherViewController.weatherArray[indexPath.row].minTemp)
        vc.pressure = String(DetailWeatherViewController.weatherArray[indexPath.row].pressure)

        splitViewController?.showDetailViewController(vc, sender: nil)
        
        
    }
}

