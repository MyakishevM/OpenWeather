//
//  WeatherViewModel.swift
//  OpenWeather
//
//  Created by Vitaliy Petrovskiy on 18.07.22.
//

import Foundation

protocol WeatherUpdateDelegate {
    func updateElements()
}

final class WeatherViewModel {
    private let networkManager = FetchWeatherData()
    var updateDelegate: WeatherUpdateDelegate?
    var dataSource: WeatherDTO?

    func getDate() {
        networkManager.fetchWeather(lat: 37.33233141, long: -122.0312186) { [weak self] weather in
            DispatchQueue.global().async {
            self?.dataSource = weather
                self?.updateDelegate?.updateElements()
            }
        }
    }
}
