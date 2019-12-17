//
//  WeatherService.swift
//  Weather
//
//  Created by Godwin Olorunshola on 11/12/2019.
//  Copyright © 2019 Godwin Olorunshola. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherServiceProtocol {
    func getCurrentDayWeather(lat : CLLocationDegrees, lng : CLLocationDegrees,   completion : @escaping (Result<Forecast, APIError>) -> () )
    func getFivedaysWeather(lat : CLLocationDegrees, lng : CLLocationDegrees, completion : @escaping (Result<ForecastList, APIError>) -> ())
}


class WeatherService : WeatherServiceProtocol{
    func getCurrentDayWeather(lat: CLLocationDegrees, lng: CLLocationDegrees,  completion: @escaping (Result<Forecast, APIError>) -> ()) {
        let url = String(format : URLConstants.getCurrentForcast, String(lat), String(lng))
        Networker.shared.makeGetRequest(url : url){(result : Result<Forecast, APIError>) in
            completion(result)
        }
    }
    

    
    func getFivedaysWeather(lat: CLLocationDegrees, lng: CLLocationDegrees, completion: @escaping (Result< ForecastList, APIError>) -> ()) {
        let url = String(format : URLConstants.getFiveDaysForecast, String(lat), String(lng))
        Networker.shared.makeGetRequest(url : url ){(result : Result<ForecastList, APIError>) in
            completion(result)
        }
        
    }
    
    
    
    
    
}
