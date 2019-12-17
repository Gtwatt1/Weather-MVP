//
//  WeatherCell.swift
//  Weather
//
//  Created by Godwin Olorunshola on 12/12/2019.
//  Copyright © 2019 Godwin Olorunshola. All rights reserved.
//

import UIKit


class WeatherCell : UITableViewCell, WeatherCellView{
    
    
    @IBOutlet weak var dayLabel : UILabel!
    @IBOutlet weak var weatherTypeImage : UIImageView!
    @IBOutlet weak var currentTempLabel : UILabel!

    
    func displayDay(day: String) {
        dayLabel.text = day
    }
    
    func displayWeatherType(image: String) {
        weatherTypeImage.image = UIImage(named: image)
    }
    
    func displayTemperature(temp: String) {
        currentTempLabel.text = temp
    }
   
    
}
