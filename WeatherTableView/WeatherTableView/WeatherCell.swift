//
//  WeatherCell.swift
//  WeatherTableView
//
//  Created by 低调 on 12/9/19.
//  Copyright © 2019 Kaiyuan Zhao. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var huminityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!

    func setWeather(weather: Weather) {
        tempLabel.text = "Daily:\(String(weather.temp))°"
        huminityLabel.text = "Humidity:\(String(weather.huminity))"
        descriptionLabel.text = weather.description
        iconImage.image = weather.icon
    }
    
}
