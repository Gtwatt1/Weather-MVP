//
//  WeatherViewController.swift
//  Weather-MVP
//
//  Created by Godwin Olorunshola on 16/12/2019.
//  Copyright © 2019 Godwin Olorunshola. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    var weatherDataSource : WeatherDataSource?

    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var temperatureLabel : UILabel!
    @IBOutlet weak var cityLabel : UILabel!

    @IBOutlet weak var minTemperatureLabel : UILabel!
    @IBOutlet weak var maxTemperatureLabel : UILabel!
    @IBOutlet weak var currentTemperatureLabel : UILabel!
    @IBOutlet weak var moreCurrentDayTemperatureDetailsLabel : UIStackView!


    @IBOutlet weak var weatherDescriptionLabel : UILabel!
    @IBOutlet weak var weatherImage : UIImageView!
    
    
    var presenter : WeatherPresenter!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = WeatherPresenter(view: self, locationService: LocationService(), weatherService: WeatherService(), userDefaultService: UserDefaultService())
        weatherDataSource = WeatherDataSource(weatherPresenter: presenter)
        weatherDataSource?.configureTableView(tableView : tableView)
        presenter.viewDidLoad()

    }
   

}


extension WeatherViewController : WeatherView{
    func didUpdateCurrentForecast(currentDayForecast : Forecast) {
        DispatchQueue.main.async {[weak self] in
          
            self?.cityLabel.text = currentDayForecast.name
            self?.weatherDescriptionLabel.text = currentDayForecast.weather?[0].weatherDescription?.capitalized
            self?.temperatureLabel.text = "\( currentDayForecast.main?.temp ?? 0)º"
            self?.minTemperatureLabel.text = "\( currentDayForecast.main?.tempMin ?? 0)º"
            self?.maxTemperatureLabel.text = "\( currentDayForecast.main?.tempMax ?? 0 )º"
            self?.currentTemperatureLabel.text = "\( currentDayForecast.main?.temp ?? 0)º"
            if let weatherImage = self?.presenter.weatherImage{
                self?.weatherImage.image = UIImage(named : weatherImage)
            }
            if let backgroundColor = self?.presenter.backgroundColor{
                let backgroundColor = UIColor.hexStringToUIColor(hex: backgroundColor)
                self?.tableView.backgroundColor =  backgroundColor
                self?.moreCurrentDayTemperatureDetailsLabel.addBackground(color :  backgroundColor)
            }
                
            self?.temperatureLabel.fadeIn()
            self?.weatherDescriptionLabel.fadeIn()
            self?.cityLabel.fadeIn()
        }
    }
    
    func didUpdateFiveDaysForecast() {
        DispatchQueue.main.async {[weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func didUpdateWithError() {
        if presentedViewController == nil{
            showAlert(withTitle : "Weather", withMessage : presenter.error)
        }
    }
    
    func didChangeTheme() {
        UIView.transition(with: weatherImage,
        duration: 0.75,
        options: .transitionCrossDissolve,
        animations: { self.weatherImage.image = UIImage(named : self.presenter.weatherImage) },
        completion: nil)
    }
    
    
}




