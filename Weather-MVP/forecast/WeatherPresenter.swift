//
//  WeatherPresenter.swift
//  Weather-MVP
//
//  Created by Godwin Olorunshola on 16/12/2019.
//  Copyright © 2019 Godwin Olorunshola. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherCellView {
    func displayDay(day : String)
    func displayWeatherType(image : String)
    func displayTemperature(temp : String)
}

protocol WeatherView : class{
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
    weak fileprivate var view : WeatherView?
    var fiveDayForecast : [Forecast]?

    
    
    init(view : WeatherView, locationService : LocationService, weatherService: WeatherServiceProtocol, userDefaultService : UserDefaultsProtocol) {
        self.locationService = locationService
        self.weatherService = weatherService
        self.userDefaultService = userDefaultService
        
    }
    
    
    func viewDidLoad(){
        requestLocationService()
    }
    
    
    
    func requestLocationService(){
        locationService.delegate = self
        locationService.startLocationRequest()
    }
    
    var weatherType = WeatherType.cloudy{
        didSet{
            setBackgroundView()
        }
    }
    
    
    func configureCell(cell : WeatherCellView, row: Int){
        let dayForecast = fiveDayForecast?[row]
        let weatherImage = getWeatherType(dayForecast?.weather?[0].main?.lowercased())
        let cellDay = getDayOfTheWeek(intDate: dayForecast?.dt ?? 0)
        cell.displayWeatherType(image: weatherImage.rawValue)
        cell.displayDay(day: cellDay)
        cell.displayTemperature(temp: "\(Int(dayForecast?.main?.temp?.rounded() ?? 0.0) )º")
    }
    
    func setBackgroundView() {
        switch weatherType {
        case .cloudy:
            weatherImage = theme == Theme.forest ? "forest_cloudy" : "sea_cloudy"
            backgroundColor = "54717A"
        case .rainy:
            weatherImage = theme == Theme.forest ? "forest_rainy" : "sea_rainy"
            backgroundColor = "57575D"
        case .sunny:
            weatherImage = theme == Theme.forest ? "forest_sunny" : "sea_sunny"
            backgroundColor = "47AB2F"
        }
    }
    
    var theme : Theme?{
        didSet{
            if let theme = theme{
                userDefaultService.setTheme(value: theme)
                setBackgroundView()
            }
            view?.didChangeTheme()
        }
    }
    
    fileprivate func getWeatherType(_ weatherMain: String?) -> WeatherType{
        switch weatherMain {
        case "rain", "thunderstorm", "drizzle", "snow", "mist":
            return WeatherType.rainy
        case let str where str?.contains("cloud") ?? false:
            return WeatherType.cloudy
        default:
            return WeatherType.sunny
        }
    }
    
    func getDayOfTheWeek(intDate: Int) -> String{
        let date = Date(timeIntervalSince1970: TimeInterval(intDate))
        return date.dayOfWeek()
    }
    
    
}

extension WeatherPresenter : LocationServiceDelegate{
    
    
    func didGetLocation(_ lat: CLLocationDegrees, lng: CLLocationDegrees) {
        weatherService.getCurrentDayWeather(lat: lat, lng: lng) {[weak self] (result: Result<Forecast , APIError> ) in
            switch result{
                case .success(let forecast) :
                    self?.view?.didUpdateCurrentForecast(currentDayForecast: forecast)
                    let weatherMain = forecast.weather?[0].main?.lowercased()
                    self?.weatherType = self?.getWeatherType(weatherMain) ?? .rainy
                case .failure(let error) :
                    self?.error = error.localizedDescription

            }
            
        }
        
        weatherService.getFivedaysWeather(lat: lat, lng: lat) { [weak self] (result: Result<ForecastList , APIError> )  in
            switch result{
                case .success(let forecasts) :
                    let forecastsAtMidday = forecasts.list.filter { (forecast) -> Bool in
                        // choosing to display the weather condition at 6am
                        (forecast.dateString?.contains("06:00:00") ?? false)
                    }
                    self?.view?.didUpdateFiveDaysForecast()
                case .failure(let error) :
                    self?.error = error.localizedDescription

            }
        }
        
    }
    
    func locationdidFail(_ reason: String) {
        error = reason
    }
    
    
}

