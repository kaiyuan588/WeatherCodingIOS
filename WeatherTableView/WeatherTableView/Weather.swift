//
//  Weather.swift
//  WeatherTableView
//
//  Created by 低调 on 12/10/19.
//  Copyright © 2019 Kaiyuan Zhao. All rights reserved.
//

import Foundation
import UIKit

class Weather {
    
    var temp: Double
    var huminity: Int
    var description: String
    var icon: UIImage
    var maxTemp: Double
    var minTemp: Double
    var pressure: Int
    
    init(temp: Double, huminity: Int, description: String, icon: UIImage, maxTemp: Double, minTemp: Double, pressure: Int) {
        self.temp = temp
        self.huminity = huminity
        self.description = description
        self.icon = icon
        self.maxTemp = maxTemp
        self.minTemp = minTemp
        self.pressure = pressure
    }
    
}
