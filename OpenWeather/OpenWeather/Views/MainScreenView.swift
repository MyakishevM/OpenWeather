//
//  MainScreenView.swift
//  OpenWeather
//
//  Created by Maxim Myakishev on 11.07.2022.
//

import UIKit

final class MainScreenView: UIView {
    private var cityLabel = UILabel(text: "City", fontSize: 25, color: UIColor.white, bold: true)
    private var temperatureLabel = UILabel(text: "17", fontSize: 70, color: UIColor.white, bold: false)
    private var gradusLabel = UILabel(text: "˚", fontSize: 80, color: UIColor.white, bold: true)
    private var descriptionLabel = UILabel(text: "showers", fontSize: 20, color: UIColor.white, bold: true)
    private var maxTemperatureLabel = UILabel(text: "H:18˚", fontSize: 20, color: UIColor.white, bold: true)
    private var minTemperatureLabel = UILabel(text: "L:12˚", fontSize: 20, color: UIColor.white, bold: true)
    let fetchWeatherData = FetchWeatherData()
    var weatherDTO: WeatherDTO? = nil
    var dailyWeather = [Daily]()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        fetchData()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchData(){
        self.fetchWeatherData.fetchWeather(lat: 37.33233141, long: -122.0312186) { (response) in
            guard let response = response else { return }
            self.weatherDTO = response
            let data = response.daily
            self.dailyWeather.append(contentsOf: data ?? [Daily(dt: nil, sunrise: nil, sunset: nil, moonrise: nil, moonset: nil, moonPhase: nil, temp: Temp(day: nil, min: nil, max: nil, night: nil, eve: nil, morn: nil), feelsLike: FeelsLike(day: nil, night: nil, eve: nil, morn: nil), pressure: nil, humidity: nil, dewPoint: nil, windSpeed: nil, windDeg: nil, windGust: nil, weather: nil, clouds: nil, pop: nil, rain: nil, uvi: nil)])
            print("Внутри кложура \(self.dailyWeather)")
        }
        print("СНАРУЖИ КЛОЖУРА \(dailyWeather)")
    }
    
}

private extension MainScreenView {
    func setupConstraints() {
        addSubview(cityLabel)
        addSubview(temperatureLabel)
        addSubview(descriptionLabel)
        addSubview(gradusLabel)
        
        let minMaxTempStack = UIStackView(views: [maxTemperatureLabel, minTemperatureLabel],
                                          axis: .horizontal,
                                          spacing: 5,
                                          alignment: .fill,
                                          distribution: .fillEqually)
        addSubview(minMaxTempStack)
        let constraints = [
            cityLabel.topAnchor.constraint(equalTo: topAnchor),
            cityLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            cityLabel.bottomAnchor.constraint(equalTo: temperatureLabel.topAnchor),
            
            temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor),
            temperatureLabel.centerXAnchor.constraint(equalTo: cityLabel.centerXAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor),
            
            gradusLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10),
            gradusLabel.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor),
            gradusLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor),
            descriptionLabel.centerXAnchor.constraint(equalTo: temperatureLabel.centerXAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: minMaxTempStack.topAnchor,
                                                     constant: -5),
            
            minMaxTempStack.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor,
                                                 constant: 5),
            minMaxTempStack.centerXAnchor.constraint(equalTo: descriptionLabel.centerXAnchor),
            minMaxTempStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    
}
