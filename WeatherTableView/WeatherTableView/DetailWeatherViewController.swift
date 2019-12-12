//
//  DetailWeather.swift
//  WeatherTableView
//
//  Created by 低调 on 12/11/19.
//  Copyright © 2019 Kaiyuan Zhao. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
class DetailWeatherViewController: UIViewController {
   
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var maxTempLabel: UILabel!
    
    @IBOutlet weak var minTempLabel: UILabel!
    
    @IBOutlet weak var pressureLabel: UILabel!
    
    static var weatherArray: [Weather] = []

    var temp = ""
    var image = UIImage()
    var hum = ""
    var des = ""
    var maxTemp = ""
    var minTemp = ""
    var pressure = ""
    static var fet = true
//    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        tempLabel.text = "Daily: \(temp)°"
        weatherImage.image = image
        humidityLabel.text = "Humidity: \(hum)"
        descriptionLabel.text = des
        maxTempLabel.text = "Max: \(maxTemp)°"
        minTempLabel.text = "Min: \(minTemp)°"
        pressureLabel.text = "Pressure: \(pressure)"
        if DetailWeatherViewController.fet == true {
            fetchData()
            DetailWeatherViewController.fet = false
        }
        
    }
    
    func fetchData(){
        Alamofire.request("http://api.openweathermap.org/data/2.5/forecast?q=Philadelphia,us&mode=json&appid=a3dda1c09a26b1c0edf12dc3e88f6991&amp;units=metric&amp;cnt=4").responseJSON { (response) in
            if let responseStr = response.result.value {
                let jsonResponse = JSON(responseStr)
      
                    let jsonWeather = jsonResponse["list"][0]["weather"][0]
                    let jsonTemp = jsonResponse["list"][0]["main"]["temp"]
                    let jsonHum = jsonResponse["list"][0]["main"]["humidity"]
                    let iconName = jsonResponse["list"][0]["weather"][0]["icon"].stringValue
                    let jsonMaxTemp = jsonResponse["list"][0]["main"]["temp_max"]
                    let jsonMinTemp = jsonResponse["list"][0]["main"]["temp_min"]
                    let jsonPressure = jsonResponse["list"][0]["main"]["pressure"]
                
                let weather1 = Weather(temp: jsonTemp.doubleValue, huminity: jsonHum.intValue, description: jsonWeather["description"].stringValue, icon: UIImage(named: iconName)!, maxTemp: jsonMaxTemp.doubleValue, minTemp: jsonMinTemp.doubleValue, pressure: jsonPressure.intValue)
                self.tempLabel.text = "Daily: \(String(weather1.temp))°"
                self.weatherImage.image = weather1.icon
                self.humidityLabel.text = "Humidity: \(String(weather1.huminity))"
                self.descriptionLabel.text = weather1.description
                self.maxTempLabel.text = "Max: \(String(weather1.maxTemp))°"
                self.minTempLabel.text = "Min: \(String(weather1.minTemp))°"
                self.pressureLabel.text = "Pressure: \(weather1.pressure)"
            }
        }
    }
}
