//
//  WeatherViewController.swift
//  Weather-MVP
//
//  Created by Godwin Olorunshola on 16/12/2019.
//  Copyright © 2019 Godwin Olorunshola. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var temperatureLabel : UILabel!
    @IBOutlet weak var cityLabel : UILabel!

    @IBOutlet weak var minTemperatureLabel : UILabel!
    @IBOutlet weak var maxTemperatureLabel : UILabel!
    @IBOutlet weak var currentTemperatureLabel : UILabel!
    @IBOutlet weak var moreCurrentDayTemperatureDetailsLabel : UIStackView!


    @IBOutlet weak var weatherDescriptionLabel : UILabel!
    @IBOutlet weak var weatherImage : UIImageView!
    
    let presenter = WeatherPresenter(locationService: LocationService(), weatherService: WeatherService(), userDefaultService: UserDefaultService())
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   

}


extension WeatherViewController : WeatherView{
    func didUpdateCurrentForecast(currentDayForecast : Forecast) {
        cityLabel.text = currentDayForecast.name
        weatherDescriptionLabel.text = currentDayForecast.weather?[0].weatherDescription?.capitalized
        temperatureLabel.text = "\( currentDayForecast.main?.temp ?? 0)º"
        minTemperatureLabel.text = "\( currentDayForecast.main?.tempMin ?? 0)º"
        maxTemperatureLabel.text = "\( currentDayForecast.main?.tempMax ?? 0 )º"
        currentTemperatureLabel.text = "\( currentDayForecast.main?.temp ?? 0)º"
        weatherImage.image = UIImage(named : presenter.weatherImage)
        let backgroundColor = UIColor.hexStringToUIColor(hex: presenter.backgroundColor)
            tableView.backgroundColor =  backgroundColor
        moreCurrentDayTemperatureDetailsLabel.addBackground(color :  backgroundColor)
        temperatureLabel.fadeIn()
        weatherDescriptionLabel.fadeIn()
        cityLabel.fadeIn()
                
    }
    
    func didUpdateFiveDaysForecast() {
        tableView.reloadData()
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
