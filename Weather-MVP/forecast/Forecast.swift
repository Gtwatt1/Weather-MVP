//
//  Forecast.swift
//  Weather
//
//  Created by Godwin Olorunshola on 12/12/2019.
//  Copyright © 2019 Godwin Olorunshola. All rights reserved.
//

import Foundation


struct Forecast : Codable{
    let weather: [Weather]?
    let main: Main?
    let dt, timezone, id: Int?
    let name, dateString: String?
    
    enum CodingKeys : String, CodingKey {
        case weather
        case main
        case dt, timezone, id, name
        case dateString = "dt_txt"
    }
}

// MARK: - Main
struct Main : Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, humidity: Int?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Weather
struct Weather : Codable {
    let id: Int?
    let main, weatherDescription, icon: String?
    
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}


enum WeatherType{
    case rainy, sunny, cloudy
}


struct ForecastList : Codable{
    var list : [Forecast]
}

enum Theme : String {
    case forest
    case sea
}
