//
//  WeatherPresenter.swift
//  Weather-MVP
//
//  Created by Godwin Olorunshola on 16/12/2019.
//  Copyright © 2019 Godwin Olorunshola. All rights reserved.
//

import Foundation


protocol WeatherView {
    func didUpdateCurrentForecast(currentDayForecast : Forecast)
    func didUpdateFiveDaysForecast()
    func didUpdateWithError()
    func didChangeTheme()
}


class WeatherPresenter{
    let locationService : LocationService
    let weatherService : WeatherServiceProtocol
    let userDefaultService : UserDefaultsProtocol
    var backgroundColor = "", weatherImage = "", error = ""
    
    
    init(locationService : LocationService, weatherService: WeatherServiceProtocol, userDefaultService : UserDefaultsProtocol) {
        self.locationService = locationService
        self.weatherService = weatherService
        self.userDefaultService = userDefaultService
        
    }
    
    
    
}
